import '../../core/constants/fuel_types.dart';

class FuelEntity {
  final int? id;
  final int vehicleId;
  final DateTime date;
  final FuelType fuelType;
  final double liters;
  final double totalValue;
  final double pricePerLiter;
  final double mileage;

  /// Indica se o tanque foi enchido por completo. É essencial para o
  /// cálculo correto de consumo (km/l), que só pode ser feito com
  /// precisão entre dois abastecimentos de tanque cheio.
  final bool fullTank;

  const FuelEntity({
    this.id,
    required this.vehicleId,
    required this.date,
    required this.fuelType,
    required this.liters,
    required this.totalValue,
    required this.pricePerLiter,
    required this.mileage,
    this.fullTank = true,
  });

  FuelEntity copyWith({
    int? id,
    int? vehicleId,
    DateTime? date,
    FuelType? fuelType,
    double? liters,
    double? totalValue,
    double? pricePerLiter,
    double? mileage,
    bool? fullTank,
  }) {
    return FuelEntity(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      date: date ?? this.date,
      fuelType: fuelType ?? this.fuelType,
      liters: liters ?? this.liters,
      totalValue: totalValue ?? this.totalValue,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      mileage: mileage ?? this.mileage,
      fullTank: fullTank ?? this.fullTank,
    );
  }
}
