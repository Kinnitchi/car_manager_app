import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/fuel_repository_impl.dart';
import '../../domain/entities/fuel_entity.dart';
import '../../domain/repositories/fuel_repository.dart';
import '../../domain/usecases/fuel/add_fuel_usecase.dart';
import '../../domain/usecases/fuel/delete_fuel_usecase.dart';
import '../../domain/usecases/fuel/update_fuel_usecase.dart';
import '../../domain/usecases/fuel/watch_fuel_usecase.dart';
import 'vehicle_providers.dart';

final fuelRepositoryProvider = Provider<FuelRepository>(
  (ref) => FuelRepositoryImpl(ref.watch(isarProvider)),
);

final addFuelUsecaseProvider = Provider<AddFuelUsecase>(
  (ref) => AddFuelUsecase(ref.watch(fuelRepositoryProvider)),
);

final updateFuelUsecaseProvider = Provider<UpdateFuelUsecase>(
  (ref) => UpdateFuelUsecase(ref.watch(fuelRepositoryProvider)),
);

final deleteFuelUsecaseProvider = Provider<DeleteFuelUsecase>(
  (ref) => DeleteFuelUsecase(ref.watch(fuelRepositoryProvider)),
);

/// Histórico de abastecimentos de um veículo específico, em tempo real.
final fuelListProvider = StreamProvider.family<List<FuelEntity>, int>((
  ref,
  vehicleId,
) {
  final usecase = WatchFuelUsecase(ref.watch(fuelRepositoryProvider));
  return usecase(vehicleId);
});
