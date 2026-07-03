import '../../../core/constants/maintenance_types.dart';
import '../../entities/maintenance_entity.dart';

class NextMaintenancePrediction {
  final MaintenanceType type;
  final int dueAtMileage;
  final double kmRemaining; // negativo = já venceu

  const NextMaintenancePrediction({
    required this.type,
    required this.dueAtMileage,
    required this.kmRemaining,
  });

  bool get isOverdue => kmRemaining < 0;
}

/// Analisa o histórico de manutenções e prevê qual é a próxima a vencer,
/// com base no último registro de cada tipo + intervalo sugerido.
class PredictNextMaintenanceUsecase {
  const PredictNextMaintenanceUsecase();

  NextMaintenancePrediction? call(
    List<MaintenanceEntity> history,
    double currentMileage,
  ) {
    if (history.isEmpty) return null;

    // Pega o registro mais recente de cada tipo que tem intervalo previsível.
    final latestByType = <MaintenanceType, MaintenanceEntity>{};
    for (final m in history) {
      if (m.type.suggestedIntervalKm == null) continue;
      if (m.nextMaintenanceMileage == null) continue;

      final current = latestByType[m.type];
      if (current == null || m.date.isAfter(current.date)) {
        latestByType[m.type] = m;
      }
    }

    if (latestByType.isEmpty) return null;

    // Entre os tipos, escolhe o que vence primeiro (menor km restante).
    MaintenanceEntity? soonest;
    for (final entry in latestByType.values) {
      if (soonest == null ||
          entry.nextMaintenanceMileage! < soonest.nextMaintenanceMileage!) {
        soonest = entry;
      }
    }

    return NextMaintenancePrediction(
      type: soonest!.type,
      dueAtMileage: soonest.nextMaintenanceMileage!,
      kmRemaining: soonest.nextMaintenanceMileage! - currentMileage,
    );
  }
}
