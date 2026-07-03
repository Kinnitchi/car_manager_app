import '../../core/utils/result.dart';
import '../entities/maintenance_entity.dart';

abstract class MaintenanceRepository {
  Future<Result<List<MaintenanceEntity>>> getAllByVehicle(int vehicleId);
  Future<Result<int>> add(MaintenanceEntity maintenance);
  Future<Result<void>> update(MaintenanceEntity maintenance);
  Future<Result<void>> delete(int id);
  Stream<List<MaintenanceEntity>> watchByVehicle(int vehicleId);
}
