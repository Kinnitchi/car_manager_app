import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/usecases/fuel/calculate_avg_consumption_usecase.dart';
import '../../../domain/usecases/reports/get_consumption_trend_usecase.dart';
import '../../../domain/usecases/reports/get_monthly_overview_usecase.dart';
import '../../providers/fuel_providers.dart';
import '../../providers/maintenance_providers.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/consumption_trend_chart.dart';
import '../../widgets/expense_breakdown_chart.dart';
import '../../widgets/monthly_expense_chart.dart';
import '../../widgets/responsive_center.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(selectedVehicleProvider);

    if (vehicle == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final fuelAsync = ref.watch(fuelListProvider(vehicle.id!));
    final maintenanceAsync = ref.watch(maintenanceListProvider(vehicle.id!));

    final isLoading = fuelAsync.isLoading || maintenanceAsync.isLoading;
    final hasError = fuelAsync.hasError || maintenanceAsync.hasError;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (hasError) {
      return const Scaffold(
        body: Center(child: Text('Erro ao carregar dados dos relatórios')),
      );
    }

    final fuelList = fuelAsync.value ?? [];
    final maintenanceList = maintenanceAsync.value ?? [];

    const overviewUsecase = GetMonthlyOverviewUsecase();
    final monthly = overviewUsecase.monthlyBreakdown(
      fuel: fuelList,
      maintenance: maintenanceList,
      monthsBack: 6,
    );
    final monthTotal = overviewUsecase.currentMonthTotal(
      fuel: fuelList,
      maintenance: maintenanceList,
    );
    final yearTotal = overviewUsecase.currentYearTotal(
      fuel: fuelList,
      maintenance: maintenanceList,
    );

    final now = DateTime.now();
    final currentMonthFuel = fuelList
        .where((f) => f.date.year == now.year && f.date.month == now.month)
        .fold<double>(0, (sum, f) => sum + f.totalValue);
    final currentMonthMaintenance = maintenanceList
        .where((m) => m.date.year == now.year && m.date.month == now.month)
        .fold<double>(0, (sum, m) => sum + m.cost);

    final consumption = const CalculateAvgConsumptionUsecase().call(fuelList);
    final consumptionTrend = const GetConsumptionTrendUsecase().call(fuelList);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios')),
      body: ResponsiveCenter(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    label: 'Gasto no mês',
                    value: Formatters.currency(monthTotal),
                    icon: Icons.calendar_month,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    label: 'Gasto no ano',
                    value: Formatters.currency(yearTotal),
                    icon: Icons.event_note,
                    color: AppColors.upcoming,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _SectionTitle(
              title: 'Gastos por mês',
              subtitle: 'Combustível vs Manutenção — últimos 6 meses',
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    MonthlyExpenseChart(data: monthly),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _LegendDot(color: AppColors.fuel, label: 'Combustível'),
                        SizedBox(width: 16),
                        _LegendDot(
                          color: AppColors.maintenance,
                          label: 'Manutenção',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(
              title: 'Divisão do mês atual',
              subtitle: 'Para onde foi o dinheiro este mês',
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ExpenseBreakdownChart(
                  fuelTotal: currentMonthFuel,
                  maintenanceTotal: currentMonthMaintenance,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _SectionTitle(
              title: 'Evolução do consumo',
              subtitle: consumption.hasData
                  ? 'Média geral: ${consumption.averageKmPerLiter!.toStringAsFixed(1)} km/l'
                  : 'km/l por tanque cheio',
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ConsumptionTrendChart(points: consumptionTrend),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(label, style: theme.textTheme.bodySmall),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(subtitle, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
