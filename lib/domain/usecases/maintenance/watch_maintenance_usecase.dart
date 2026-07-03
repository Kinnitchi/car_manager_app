// lib/domain/usecases/maintenance/watch_maintenance_usecase.dart
import '../../entities/maintenance_entity.dart';
import '../../repositories/maintenance_repository.dart';

class WatchMaintenanceUsecase {
  final MaintenanceRepository repository;
  WatchMaintenanceUsecase(this.repository);

  Stream<List<MaintenanceEntity>> call(int vehicleId) =>
      repository.watchByVehicle(vehicleId);
}
