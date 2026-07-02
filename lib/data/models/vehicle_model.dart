import 'package:isar_community/isar.dart';

part 'vehicle_model.g.dart';

@collection
class VehicleModel {
  Id id = Isar.autoIncrement;

  late String brand;
  late String model;
  late int year;

  @Index(unique: true, replace: false)
  late String plate;

  late String color;
  late double currentMileage;
  String? photoPath;
  late DateTime createdAt;
}
