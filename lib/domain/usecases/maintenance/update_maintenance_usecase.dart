import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/maintenance_entity.dart';
import '../../repositories/maintenance_repository.dart';

class UpdateMaintenanceUsecase {
  final MaintenanceRepository repository;
  UpdateMaintenanceUsecase(this.repository);

  Future<Result<void>> call(MaintenanceEntity maintenance) async {
    if (maintenance.id == null) {
      return Result.failure(
        const ValidationFailure('Manutenção sem ID para atualização'),
      );
    }
    final error = _validate(maintenance);
    if (error != null) {
      return Result.failure(ValidationFailure(error));
    }

    final withPrediction = maintenance.copyWith(
      nextMaintenanceMileage: _calculateNextMileage(maintenance),
    );

    return repository.update(withPrediction);
  }

  int? _calculateNextMileage(MaintenanceEntity m) {
    final interval = m.type.suggestedIntervalKm;
    if (interval == null) return null;
    return m.mileage.round() + interval;
  }

  String? _validate(MaintenanceEntity m) {
    if (m.description.trim().isEmpty) return 'Descrição é obrigatória';
    if (m.mileage < 0) return 'Quilometragem não pode ser negativa';
    if (m.cost < 0) return 'Valor gasto não pode ser negativo';
    if (m.date.isAfter(DateTime.now())) {
      return 'Data não pode ser no futuro';
    }
    return null;
  }
}
