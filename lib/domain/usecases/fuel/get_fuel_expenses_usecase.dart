import '../../entities/fuel_entity.dart';

class GetFuelExpensesUsecase {
  const GetFuelExpensesUsecase();

  double monthly(List<FuelEntity> history, {DateTime? reference}) {
    final ref = reference ?? DateTime.now();
    return history
        .where((f) => f.date.year == ref.year && f.date.month == ref.month)
        .fold<double>(0, (sum, f) => sum + f.totalValue);
  }

  double annual(List<FuelEntity> history, {int? year}) {
    final targetYear = year ?? DateTime.now().year;
    return history
        .where((f) => f.date.year == targetYear)
        .fold<double>(0, (sum, f) => sum + f.totalValue);
  }
}
