import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/fuel_entity.dart';
import '../../repositories/fuel_repository.dart';

class AddFuelUsecase {
  final FuelRepository repository;
  AddFuelUsecase(this.repository);

  Future<Result<int>> call(FuelEntity fuel) async {
    final error = _validate(fuel);
    if (error != null) {
      return Result.failure(ValidationFailure(error));
    }
    return repository.add(fuel);
  }

  String? _validate(FuelEntity f) {
    if (f.liters <= 0) return 'Litros deve ser maior que zero';
    if (f.totalValue <= 0) return 'Valor total deve ser maior que zero';
    if (f.mileage < 0) return 'Quilometragem não pode ser negativa';
    if (f.date.isAfter(DateTime.now())) return 'Data não pode ser no futuro';
    return null;
  }
}
