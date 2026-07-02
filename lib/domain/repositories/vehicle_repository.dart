import '../../core/utils/result.dart';
import '../entities/vehicle_entity.dart';

abstract class VehicleRepository {
  Future<Result<List<VehicleEntity>>> getAll();
  Future<Result<VehicleEntity?>> getById(int id);
  Future<Result<int>> add(VehicleEntity vehicle);
  Future<Result<void>> update(VehicleEntity vehicle);
  Future<Result<void>> delete(int id);
  Stream<List<VehicleEntity>> watchAll();
}
