class VehicleEntity {
  final int? id;
  final String brand;
  final String model;
  final int year;
  final String plate;
  final String color;
  final double currentMileage;
  final String? photoPath;
  final DateTime createdAt;

  const VehicleEntity({
    this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.plate,
    required this.color,
    required this.currentMileage,
    this.photoPath,
    required this.createdAt,
  });

  VehicleEntity copyWith({
    int? id,
    String? brand,
    String? model,
    int? year,
    String? plate,
    String? color,
    double? currentMileage,
    String? photoPath,
    bool clearPhoto = false,
  }) {
    return VehicleEntity(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      color: color ?? this.color,
      currentMileage: currentMileage ?? this.currentMileage,
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      createdAt: createdAt,
    );
  }
}
