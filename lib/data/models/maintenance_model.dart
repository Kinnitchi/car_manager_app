import 'package:isar_community/isar.dart';

part 'maintenance_model.g.dart';

@collection
class MaintenanceModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int vehicleId;

  /// Nome do enum MaintenanceType (ex: "oilChange") — salvo como String
  /// para não depender da ordem dos valores no enum.
  late String typeName;

  late String description;

  @Index()
  late DateTime date;

  late double mileage;
  late double cost;
  String? workshop;
  String? notes;
  int? nextMaintenanceMileage;
}
