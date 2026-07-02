import '../../../core/utils/result.dart';
import '../../repositories/vehicle_repository.dart';

class DeleteVehicleUsecase {
  final VehicleRepository repository;
  DeleteVehicleUsecase(this.repository);

  Future<Result<void>> call(int id) => repository.delete(id);
}
