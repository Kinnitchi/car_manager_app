import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/vehicle_entity.dart';
import '../../repositories/vehicle_repository.dart';

class AddVehicleUsecase {
  final VehicleRepository repository;
  AddVehicleUsecase(this.repository);

  Future<Result<int>> call(VehicleEntity vehicle) async {
    final validationError = _validate(vehicle);
    if (validationError != null) {
      return Result.failure(ValidationFailure(validationError));
    }
    return repository.add(vehicle);
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
