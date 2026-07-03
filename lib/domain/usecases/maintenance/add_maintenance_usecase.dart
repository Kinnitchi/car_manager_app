import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/maintenance_entity.dart';
import '../../repositories/maintenance_repository.dart';

class AddMaintenanceUsecase {
  final MaintenanceRepository repository;
  AddMaintenanceUsecase(this.repository);

  Future<Result<int>> call(MaintenanceEntity maintenance) async {
    final error = _validate(maintenance);
    if (error != null) {
      return Result.failure(ValidationFailure(error));
    }

    final withPrediction = maintenance.copyWith(
      nextMaintenanceMileage: _calculateNextMileage(maintenance),
    );

    return repository.add(withPrediction);
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
