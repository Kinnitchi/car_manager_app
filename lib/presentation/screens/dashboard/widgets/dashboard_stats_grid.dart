import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../domain/entities/vehicle_entity.dart';
import '../../../../domain/usecases/fuel/calculate_avg_consumption_usecase.dart';
import '../../../../domain/usecases/maintenance/predict_next_maintenance_usecase.dart';
import '../../../providers/fuel_providers.dart';
import '../../../providers/maintenance_providers.dart';
import '../../../widgets/premium_card.dart';
import '../../../widgets/shimmer_box.dart';
import '../../../widgets/stat_card.dart';

/// Grade de estatísticas rápidas do dashboard: quilometragem, último
/// abastecimento, última/próxima manutenção, gastos do mês e consumo
/// médio. Responsiva (2 colunas no celular, 3 em telas largas).
class DashboardStatsGrid extends ConsumerWidget {
  final VehicleEntity vehicle;
  final NextMaintenancePrediction? prediction;
  final AvgConsumptionResult consumption;
  final double totalMonthlyExpense;

  const DashboardStatsGrid({
    super.key,
    required this.vehicle,
    required this.prediction,
    required this.consumption,
    required this.totalMonthlyExpense,
  });

  double? get _maintenanceProgress {
    final p = prediction;
    if (p == null) return null;
    final interval = p.type.suggestedIntervalKm;
    if (interval == null || interval <= 0) return null;
    return (1 - (p.kmRemaining / interval)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final maintenanceAsync = ref.watch(maintenanceListProvider(vehicle.id!));
    final fuelAsync = ref.watch(fuelListProvider(vehicle.id!));

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 560 ? 3 : 2;
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            // Altura fixa (em vez de aspect ratio) porque o conteúdo do
            // StatCard tem altura praticamente constante independente
            // da largura da coluna.
            mainAxisExtent: 168,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            StatCard(
              index: 0,
              icon: Icons.speed_rounded,
              title: 'Quilometragem atual',
              value: '${vehicle.currentMileage.toStringAsFixed(0)} km',
            ),

            // Último abastecimento — dado real.
            fuelAsync.when(
              data: (list) {
                if (list.isEmpty) {
                  return StatCard(
                    index: 1,
                    icon: Icons.local_gas_station_rounded,
                    title: 'Último abastecimento',
                    value: 'Sem registros',
                    subtitle: 'Nenhum abastecimento ainda',
                    iconColor: AppColors.fuel,
                    onTap: () => context.go(RouteNames.fuelList),
                  );
                }
                final last = list.first;
                return StatCard(
                  index: 1,
                  icon: Icons.local_gas_station_rounded,
                  title: 'Último abastecimento',
                  value: Formatters.currency(last.totalValue),
                  subtitle: Formatters.date(last.date),
                  iconColor: AppColors.fuel,
                  onTap: () => context.go(RouteNames.fuelList),
                );
              },
              loading: () => const _StatCardSkeleton(),
              error: (_, _) => StatCard(
                index: 1,
                icon: Icons.local_gas_station_rounded,
                title: 'Último abastecimento',
                value: 'Erro',
                iconColor: AppColors.fuel,
                onTap: () => context.go(RouteNames.fuelList),
              ),
            ),

            // Última manutenção — dado real.
            maintenanceAsync.when(
              data: (list) {
                if (list.isEmpty) {
                  return StatCard(
                    index: 2,
                    icon: Icons.build_rounded,
                    title: 'Última manutenção',
                    value: 'Sem registros',
                    subtitle: 'Nenhuma manutenção ainda',
                    iconColor: AppColors.maintenance,
                    onTap: () => context.go(RouteNames.maintenanceList),
                  );
                }
                final last = list.first;
                return StatCard(
                  index: 2,
                  icon: Icons.build_rounded,
                  title: 'Última manutenção',
                  value: last.type.label,
                  subtitle: Formatters.date(last.date),
                  iconColor: AppColors.maintenance,
                  onTap: () => context.go(RouteNames.maintenanceList),
                );
              },
              loading: () => const _StatCardSkeleton(),
              error: (_, _) => StatCard(
                index: 2,
                icon: Icons.build_rounded,
                title: 'Última manutenção',
                value: 'Erro',
                iconColor: AppColors.maintenance,
                onTap: () => context.go(RouteNames.maintenanceList),
              ),
            ),

            // Próxima manutenção — previsão real, com barra de progresso.
            StatCard(
              index: 3,
              icon: prediction != null && prediction!.isOverdue
                  ? Icons.warning_amber_rounded
                  : Icons.event_available_rounded,
              title: 'Próxima manutenção',
              value: prediction == null
                  ? 'Não prevista'
                  : prediction!.type.label,
              subtitle: prediction == null
                  ? 'Registre manutenções para prever'
                  : null,
              progress: prediction == null ? null : _maintenanceProgress,
              iconColor: prediction != null && prediction!.isOverdue
                  ? theme.colorScheme.error
                  : AppColors.upcoming,
              onTap: () => context.go(RouteNames.maintenanceList),
            ),

            // Gastos do mês — combinação real de Fuel + Maintenance.
            StatCard(
              index: 4,
              icon: Icons.account_balance_wallet_rounded,
              title: 'Gastos do mês',
              value: Formatters.currency(totalMonthlyExpense),
              iconColor: theme.colorScheme.error,
              onTap: () => context.go(RouteNames.reports),
            ),

            // Consumo médio — cálculo real.
            StatCard(
              index: 5,
              icon: Icons.speed_outlined,
              title: 'Consumo médio',
              value: consumption.hasData
                  ? '${consumption.averageKmPerLiter!.toStringAsFixed(1)} km/l'
                  : '-- km/l',
              subtitle: consumption.hasData
                  ? null
                  : 'Registre 2+ tanques cheios',
              iconColor: AppColors.consumption,
              onTap: () => context.go(RouteNames.fuelList),
            ),
          ],
        );
      },
    );
  }
}

class _StatCardSkeleton extends StatelessWidget {
  const _StatCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(width: 36, height: 36, radius: AppRadius.sm),
          SizedBox(height: AppSpacing.md),
          ShimmerBox(width: 90, height: 10),
          SizedBox(height: AppSpacing.sm),
          ShimmerBox(width: 60, height: 16),
        ],
      ),
    );
  }
}
