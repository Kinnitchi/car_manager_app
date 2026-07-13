import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../domain/entities/report_entities.dart';
import '../../../widgets/premium_card.dart';

/// "Resumo financeiro" do dashboard: valor do mês atual, variação em
/// relação ao mês anterior e uma mini tendência dos últimos meses.
class DashboardSpendingTrendCard extends StatelessWidget {
  final List<MonthlyExpenseEntry> months;

  const DashboardSpendingTrendCard({super.key, required this.months});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (months.isEmpty) return const SizedBox.shrink();

    final current = months.last.total;
    final previous = months.length > 1 ? months[months.length - 2].total : 0;
    final hasPrevious = previous > 0;
    final variation = hasPrevious ? (current - previous) / previous * 100 : 0;
    final isUp = variation > 0;
    final trendColor = isUp ? theme.colorScheme.error : Colors.green;

    final maxTotal = months
        .map((m) => m.total)
        .fold<double>(0, (max, v) => v > max ? v : max);
    final maxY = maxTotal == 0 ? 100.0 : maxTotal * 1.2;

    return PremiumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resumo financeiro',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          Formatters.currency(current),
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  if (hasPrevious)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: trendColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isUp
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 14,
                            color: trendColor,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${variation.abs().toStringAsFixed(0)}%',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: trendColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 64,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: maxY,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    lineTouchData: const LineTouchData(enabled: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (var i = 0; i < months.length; i++)
                            FlSpot(i.toDouble(), months[i].total),
                        ],
                        isCurved: true,
                        color: theme.colorScheme.primary,
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              theme.colorScheme.primary.withValues(alpha: 0.22),
                              theme.colorScheme.primary.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms, delay: 420.ms)
        .slideY(
          begin: 0.12,
          end: 0,
          duration: 350.ms,
          delay: 420.ms,
          curve: Curves.easeOut,
        );
  }
}
