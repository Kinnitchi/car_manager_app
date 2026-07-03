import '../../../core/utils/result.dart';
import '../../repositories/fuel_repository.dart';

class DeleteFuelUsecase {
  final FuelRepository repository;
  DeleteFuelUsecase(this.repository);

  Future<Result<void>> call(int id) => repository.delete(id);
}
