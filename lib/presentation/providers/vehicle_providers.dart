import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../../data/datasources/isar_service.dart';
import '../../data/repositories/vehicle_repository_impl.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../../domain/usecases/vehicle/add_vehicle_usecase.dart';
import '../../domain/usecases/vehicle/delete_vehicle_usecase.dart';
import '../../domain/usecases/vehicle/update_vehicle_usecase.dart';
import '../../domain/usecases/vehicle/watch_vehicles_usecase.dart';

final isarProvider = Provider<Isar>((ref) => IsarService.instance);

final vehicleRepositoryProvider = Provider<VehicleRepository>(
  (ref) => VehicleRepositoryImpl(ref.watch(isarProvider)),
);

final addVehicleUsecaseProvider = Provider<AddVehicleUsecase>(
  (ref) => AddVehicleUsecase(ref.watch(vehicleRepositoryProvider)),
);

final updateVehicleUsecaseProvider = Provider<UpdateVehicleUsecase>(
  (ref) => UpdateVehicleUsecase(ref.watch(vehicleRepositoryProvider)),
);

final deleteVehicleUsecaseProvider = Provider<DeleteVehicleUsecase>(
  (ref) => DeleteVehicleUsecase(ref.watch(vehicleRepositoryProvider)),
);

final vehicleListProvider = StreamProvider<List<VehicleEntity>>((ref) {
  final usecase = WatchVehiclesUsecase(ref.watch(vehicleRepositoryProvider));
  return usecase();
});

/// Veículo atualmente selecionado (usado no Dashboard e demais telas).
final selectedVehicleProvider = StateProvider<VehicleEntity?>((ref) => null);
