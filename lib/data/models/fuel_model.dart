import 'package:isar_community/isar.dart';

part 'fuel_model.g.dart';

@collection
class FuelModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int vehicleId;

  @Index()
  late DateTime date;

  /// Nome do enum FuelType (ex: "gasoline") salvo como String,
  /// pelo mesmo motivo do MaintenanceModel: robustez contra
  /// reordenação futura do enum.
  late String fuelTypeName;

  late double liters;
  late double totalValue;
  late double pricePerLiter;
  late double mileage;
  late bool fullTank;
}
