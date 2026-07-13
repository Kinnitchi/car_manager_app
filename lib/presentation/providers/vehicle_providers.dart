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
///
/// Mantém-se sincronizado com o banco: se o veículo for editado em
/// qualquer tela (formulário, sync de km ao registrar abastecimento ou
/// manutenção), a instância selecionada é atualizada automaticamente;
/// se for excluído, volta a null e o router redireciona ao seletor.
final selectedVehicleProvider =
    NotifierProvider<SelectedVehicleNotifier, VehicleEntity?>(
      SelectedVehicleNotifier.new,
    );

class SelectedVehicleNotifier extends Notifier<VehicleEntity?> {
  @override
  VehicleEntity? build() {
    ref.listen(vehicleListProvider, (_, next) {
      final selectedId = state?.id;
      if (selectedId == null) return;
      next.whenData((vehicles) {
        for (final v in vehicles) {
          if (v.id == selectedId) {
            state = v;
            return;
          }
        }
        state = null; // veículo excluído
      });
    });
    return null;
  }

  void select(VehicleEntity? vehicle) => state = vehicle;
}
