import '../../entities/vehicle_entity.dart';
import '../../repositories/vehicle_repository.dart';

class WatchVehiclesUsecase {
  final VehicleRepository repository;
  WatchVehiclesUsecase(this.repository);

  Stream<List<VehicleEntity>> call() => repository.watchAll();
}
