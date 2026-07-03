import '../../entities/fuel_entity.dart';
import '../../entities/maintenance_entity.dart';
import '../../entities/report_entities.dart';

/// Combina Abastecimentos + Manutenções em uma visão mensal —
/// usado tanto no Dashboard (mês atual) quanto nos Relatórios
/// (histórico dos últimos N meses).
class GetMonthlyOverviewUsecase {
  const GetMonthlyOverviewUsecase();

  /// Retorna os últimos [monthsBack] meses (incluindo o atual),
  /// em ordem cronológica crescente — pronto para plotar num gráfico.
  List<MonthlyExpenseEntry> monthlyBreakdown({
    required List<FuelEntity> fuel,
    required List<MaintenanceEntity> maintenance,
    int monthsBack = 6,
  }) {
    final now = DateTime.now();
    final months = List.generate(monthsBack, (i) {
      final target = DateTime(now.year, now.month - (monthsBack - 1 - i));
      return DateTime(target.year, target.month);
    });

    return months.map((month) {
      final fuelTotal = fuel
          .where(
            (f) => f.date.year == month.year && f.date.month == month.month,
          )
          .fold<double>(0, (sum, f) => sum + f.totalValue);

      final maintenanceTotal = maintenance
          .where(
            (m) => m.date.year == month.year && m.date.month == month.month,
          )
          .fold<double>(0, (sum, m) => sum + m.cost);

      return MonthlyExpenseEntry(
        month: month,
        fuelTotal: fuelTotal,
        maintenanceTotal: maintenanceTotal,
      );
    }).toList();
  }

  /// Total combinado (Fuel + Maintenance) do mês corrente.
  /// Usado pelo card "Gastos do mês" no Dashboard.
  double currentMonthTotal({
    required List<FuelEntity> fuel,
    required List<MaintenanceEntity> maintenance,
  }) {
    final now = DateTime.now();
    final fuelTotal = fuel
        .where((f) => f.date.year == now.year && f.date.month == now.month)
        .fold<double>(0, (sum, f) => sum + f.totalValue);
    final maintenanceTotal = maintenance
        .where((m) => m.date.year == now.year && m.date.month == now.month)
        .fold<double>(0, (sum, m) => sum + m.cost);
    return fuelTotal + maintenanceTotal;
  }

  /// Total combinado do ano corrente — usado no card de resumo anual.
  double currentYearTotal({
    required List<FuelEntity> fuel,
    required List<MaintenanceEntity> maintenance,
  }) {
    final now = DateTime.now();
    final fuelTotal = fuel
        .where((f) => f.date.year == now.year)
        .fold<double>(0, (sum, f) => sum + f.totalValue);
    final maintenanceTotal = maintenance
        .where((m) => m.date.year == now.year)
        .fold<double>(0, (sum, m) => sum + m.cost);
    return fuelTotal + maintenanceTotal;
  }
}
