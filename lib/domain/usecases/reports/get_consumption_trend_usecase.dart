import '../../entities/fuel_entity.dart';
import '../../entities/report_entities.dart';

/// Gera a série histórica de consumo (km/l) para plotar num gráfico
/// de linha — um ponto para cada intervalo entre dois tanques cheios
/// consecutivos. Reaproveita a mesma lógica de
/// CalculateAvgConsumptionUsecase, mas retorna os pontos individuais
/// em vez da média agregada.
class GetConsumptionTrendUsecase {
  const GetConsumptionTrendUsecase();

  List<ConsumptionPoint> call(List<FuelEntity> history) {
    if (history.length < 2) return const [];

    final sorted = [...history]..sort((a, b) => a.mileage.compareTo(b.mileage));

    final fullTankIndices = <int>[
      for (var i = 0; i < sorted.length; i++)
        if (sorted[i].fullTank) i,
    ];

    if (fullTankIndices.length < 2) return const [];

    final points = <ConsumptionPoint>[];

    for (var k = 1; k < fullTankIndices.length; k++) {
      final startIdx = fullTankIndices[k - 1];
      final endIdx = fullTankIndices[k];

      final kmDiff = sorted[endIdx].mileage - sorted[startIdx].mileage;
      if (kmDiff <= 0) continue;

      final litersSum = sorted
          .sublist(startIdx + 1, endIdx + 1)
          .fold<double>(0, (sum, f) => sum + f.liters);

      if (litersSum <= 0) continue;

      points.add(
        ConsumptionPoint(
          date: sorted[endIdx].date,
          mileage: sorted[endIdx].mileage,
          kmPerLiter: kmDiff / litersSum,
        ),
      );
    }

    return points;
  }
}
