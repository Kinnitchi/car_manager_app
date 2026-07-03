import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/fuel_entity.dart';
import '../../repositories/fuel_repository.dart';

class UpdateFuelUsecase {
  final FuelRepository repository;
  UpdateFuelUsecase(this.repository);

  Future<Result<void>> call(FuelEntity fuel) async {
    if (fuel.id == null) {
      return Result.failure(
        const ValidationFailure('Abastecimento sem ID para atualização'),
      );
    }
    final error = _validate(fuel);
    if (error != null) {
      return Result.failure(ValidationFailure(error));
    }
    return repository.update(fuel);
  }

  String? _validate(FuelEntity f) {
    if (f.liters <= 0) return 'Litros deve ser maior que zero';
    if (f.totalValue <= 0) return 'Valor total deve ser maior que zero';
    if (f.mileage < 0) return 'Quilometragem não pode ser negativa';
    if (f.date.isAfter(DateTime.now())) return 'Data não pode ser no futuro';
    return null;
  }
}
