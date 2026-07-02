import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/vehicle_entity.dart';
import '../../repositories/vehicle_repository.dart';

class UpdateVehicleUsecase {
  final VehicleRepository repository;
  UpdateVehicleUsecase(this.repository);

  Future<Result<void>> call(VehicleEntity vehicle) async {
    if (vehicle.id == null) {
      return Result.failure(
        const ValidationFailure('Veículo sem ID para atualização'),
      );
    }
    final validationError = _validate(vehicle);
    if (validationError != null) {
      return Result.failure(ValidationFailure(validationError));
    }
    return repository.update(vehicle);
  }

  String? _validate(VehicleEntity v) {
    if (v.brand.trim().isEmpty) return 'Marca é obrigatória';
    if (v.model.trim().isEmpty) return 'Modelo é obrigatório';
    if (v.plate.trim().isEmpty) return 'Placa é obrigatória';
    if (v.year < 1950 || v.year > DateTime.now().year + 1) {
      return 'Ano inválido';
    }
    if (v.currentMileage < 0) return 'Quilometragem não pode ser negativa';
    return null;
  }
}
