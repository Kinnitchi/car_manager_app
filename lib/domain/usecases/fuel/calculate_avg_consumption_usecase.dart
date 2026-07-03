import '../../entities/fuel_entity.dart';

class AvgConsumptionResult {
  /// Consumo médio (km/l) considerando todo o histórico de tanque cheio.
  final double? averageKmPerLiter;

  /// Consumo do último intervalo completo (mais recente), útil para
  /// mostrar "seu último tanque rendeu X km/l" separado da média geral.
  final double? lastIntervalKmPerLiter;

  const AvgConsumptionResult({
    this.averageKmPerLiter,
    this.lastIntervalKmPerLiter,
  });

  bool get hasData => averageKmPerLiter != null;
}

/// Calcula consumo médio (km/l) de forma tecnicamente correta:
/// usa apenas intervalos entre abastecimentos de TANQUE CHEIO
/// consecutivos, somando os litros de todos os abastecimentos
/// (inclusive parciais) feitos dentro desse intervalo.
class CalculateAvgConsumptionUsecase {
  const CalculateAvgConsumptionUsecase();

  AvgConsumptionResult call(List<FuelEntity> history) {
    if (history.length < 2) return const AvgConsumptionResult();

    // Ordena por quilometragem crescente — é o que importa para o
    // cálculo, independentemente da ordem de cadastro.
    final sorted = [...history]..sort((a, b) => a.mileage.compareTo(b.mileage));

    final fullTankIndices = <int>[
      for (var i = 0; i < sorted.length; i++)
        if (sorted[i].fullTank) i,
    ];

    if (fullTankIndices.length < 2) return const AvgConsumptionResult();

    final consumptions = <double>[];

    for (var k = 1; k < fullTankIndices.length; k++) {
      final startIdx = fullTankIndices[k - 1];
      final endIdx = fullTankIndices[k];

      final kmDiff = sorted[endIdx].mileage - sorted[startIdx].mileage;
      if (kmDiff <= 0) continue;

      // Soma os litros de TODOS os abastecimentos entre o tanque cheio
      // anterior (exclusive) e o atual (inclusive) — inclui parciais.
      final litersSum = sorted
          .sublist(startIdx + 1, endIdx + 1)
          .fold<double>(0, (sum, f) => sum + f.liters);

      if (litersSum <= 0) continue;

      consumptions.add(kmDiff / litersSum);
    }

    if (consumptions.isEmpty) return const AvgConsumptionResult();

    final average = consumptions.reduce((a, b) => a + b) / consumptions.length;

    return AvgConsumptionResult(
      averageKmPerLiter: average,
      lastIntervalKmPerLiter: consumptions.last,
    );
  }
}
