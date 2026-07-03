import '../../core/constants/maintenance_types.dart';

class MaintenanceEntity {
  final int? id;
  final int vehicleId;
  final MaintenanceType type;
  final String description;
  final DateTime date;
  final double mileage;
  final double cost;
  final String? workshop;
  final String? notes;
  final int? nextMaintenanceMileage;

  const MaintenanceEntity({
    this.id,
    required this.vehicleId,
    required this.type,
    required this.description,
    required this.date,
    required this.mileage,
    required this.cost,
    this.workshop,
    this.notes,
    this.nextMaintenanceMileage,
  });

  MaintenanceEntity copyWith({
    int? id,
    int? vehicleId,
    MaintenanceType? type,
    String? description,
    DateTime? date,
    double? mileage,
    double? cost,
    String? workshop,
    String? notes,
    int? nextMaintenanceMileage,
  }) {
    return MaintenanceEntity(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
      mileage: mileage ?? this.mileage,
      cost: cost ?? this.cost,
      workshop: workshop ?? this.workshop,
      notes: notes ?? this.notes,
      nextMaintenanceMileage:
          nextMaintenanceMileage ?? this.nextMaintenanceMileage,
    );
  }
}
