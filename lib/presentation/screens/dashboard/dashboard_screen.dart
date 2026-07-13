import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/notification_providers.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../domain/usecases/fuel/calculate_avg_consumption_usecase.dart';
import '../../../domain/usecases/reports/get_monthly_overview_usecase.dart';
import '../../../domain/usecases/maintenance/predict_next_maintenance_usecase.dart';
import '../../providers/fuel_providers.dart';
import '../../providers/maintenance_providers.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/responsive_center.dart';
import '../../widgets/vehicle_summary_header.dart';
import 'widgets/dashboard_quick_actions.dart';
import 'widgets/dashboard_spending_trend_card.dart';
import 'widgets/dashboard_stats_grid.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(selectedVehicleProvider);

    if (vehicle == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final maintenanceAsync = ref.watch(maintenanceListProvider(vehicle.id!));
    final fuelAsync = ref.watch(fuelListProvider(vehicle.id!));

    final prediction = maintenanceAsync.maybeWhen(
      data: (list) => const PredictNextMaintenanceUsecase().call(
        list,
        vehicle.currentMileage,
      ),
      orElse: () => null,
    );

    // Alerta local (não agendado) quando a manutenção prevista está
    // atrasada. Roda após o build para não disparar side-effects
    // durante a renderização, e usa notifiedMaintenanceKeysProvider
    // para não repetir o alerta a cada rebuild da tela.
    if (prediction != null && prediction.isOverdue) {
      final key = '${vehicle.id}_${prediction.type.name}';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notified = ref.read(notifiedMaintenanceKeysProvider);
        if (!notified.contains(key)) {
          ref
              .read(notificationServiceProvider)
              .showNow(
                // id único por veículo+tipo — soma simples colidiria
                // (veículo 1/tipo 2 == veículo 2/tipo 1).
                id: vehicle.id! * 100 + prediction.type.index,
                title: '${prediction.type.label} atrasada',
                body:
                    '${vehicle.brand} ${vehicle.model} está '
                    '${(-prediction.kmRemaining).toStringAsFixed(0)} km '
                    'além do previsto.',
              );
          ref.read(notifiedMaintenanceKeysProvider.notifier).state = {
            ...notified,
            key,
          };
        }
      });
    }

    final consumption = fuelAsync.maybeWhen(
      data: (list) => const CalculateAvgConsumptionUsecase().call(list),
      orElse: () => const AvgConsumptionResult(),
    );

    // Gastos do mês — usando o usecase compartilhado com Relatórios,
    // garantindo que os dois lugares sempre mostrem o mesmo número.
    const overviewUsecase = GetMonthlyOverviewUsecase();
    final totalMonthlyExpense = overviewUsecase.currentMonthTotal(
      fuel: fuelAsync.value ?? [],
      maintenance: maintenanceAsync.value ?? [],
    );
    final monthlyBreakdown = overviewUsecase.monthlyBreakdown(
      fuel: fuelAsync.value ?? [],
      maintenance: maintenanceAsync.value ?? [],
      monthsBack: 6,
    );

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(vehicleListProvider);
          ref.invalidate(maintenanceListProvider(vehicle.id!));
          ref.invalidate(fuelListProvider(vehicle.id!));
        },
        child: ResponsiveCenter(
          maxWidth: 900,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              VehicleSummaryHeader(
                vehicle: vehicle,
                onSwapVehicle: () => context.push(RouteNames.vehicleSelector),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Resumo', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.md),
              DashboardStatsGrid(
                vehicle: vehicle,
                prediction: prediction,
                consumption: consumption,
                totalMonthlyExpense: totalMonthlyExpense,
              ),
              const SizedBox(height: AppSpacing.xl),
              DashboardSpendingTrendCard(months: monthlyBreakdown),
              const SizedBox(height: AppSpacing.xl),
              Text('Ações rápidas', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.md),
              const DashboardQuickActions(),
            ],
          ),
        ),
      ),
    );
  }
}
