import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../core/utils/formatters.dart';

class ExpenseBreakdownChart extends StatelessWidget {
  final double fuelTotal;
  final double maintenanceTotal;

  const ExpenseBreakdownChart({
    super.key,
    required this.fuelTotal,
    required this.maintenanceTotal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = fuelTotal + maintenanceTotal;

    if (total == 0) {
      return SizedBox(
        height: 160,
        child: Center(
          child: Text(
            'Sem gastos registrados neste mês',
            style: theme.textTheme.bodySmall,
          ),
        ),
      );
    }

    return SizedBox(
      height: 180,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 36,
                sections: [
                  if (fuelTotal > 0)
                    PieChartSectionData(
                      value: fuelTotal,
                      color: Colors.orange,
                      title: '${(fuelTotal / total * 100).toStringAsFixed(0)}%',
                      radius: 56,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  if (maintenanceTotal > 0)
                    PieChartSectionData(
                      value: maintenanceTotal,
                      color: Colors.green,
                      title:
                          '${(maintenanceTotal / total * 100).toStringAsFixed(0)}%',
                      radius: 56,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LegendItem(
                  color: Colors.orange,
                  label: 'Combustível',
                  value: Formatters.currency(fuelTotal),
                ),
                const SizedBox(height: 12),
                _LegendItem(
                  color: Colors.green,
                  label: 'Manutenção',
                  value: Formatters.currency(maintenanceTotal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
