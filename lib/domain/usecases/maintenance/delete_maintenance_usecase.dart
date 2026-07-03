import '../../../core/utils/result.dart';
import '../../repositories/maintenance_repository.dart';

class DeleteMaintenanceUsecase {
  final MaintenanceRepository repository;
  DeleteMaintenanceUsecase(this.repository);

  Future<Result<void>> call(int id) => repository.delete(id);
}
