class MonthlyExpenseEntry {
  final DateTime month; // sempre dia 1 do mês, para facilitar comparação
  final double fuelTotal;
  final double maintenanceTotal;

  const MonthlyExpenseEntry({
    required this.month,
    required this.fuelTotal,
    required this.maintenanceTotal,
  });

  double get total => fuelTotal + maintenanceTotal;
}

class ConsumptionPoint {
  final DateTime date;
  final double mileage;
  final double kmPerLiter;

  const ConsumptionPoint({
    required this.date,
    required this.mileage,
    required this.kmPerLiter,
  });
}
