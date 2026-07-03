import '../../entities/fuel_entity.dart';
import '../../repositories/fuel_repository.dart';

class WatchFuelUsecase {
  final FuelRepository repository;
  WatchFuelUsecase(this.repository);

  Stream<List<FuelEntity>> call(int vehicleId) =>
      repository.watchByVehicle(vehicleId);
}
