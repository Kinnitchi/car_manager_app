import '../../core/utils/result.dart';
import '../entities/fuel_entity.dart';

abstract class FuelRepository {
  Future<Result<List<FuelEntity>>> getAllByVehicle(int vehicleId);
  Future<Result<int>> add(FuelEntity fuel);
  Future<Result<void>> update(FuelEntity fuel);
  Future<Result<void>> delete(int id);
  Stream<List<FuelEntity>> watchByVehicle(int vehicleId);
}
