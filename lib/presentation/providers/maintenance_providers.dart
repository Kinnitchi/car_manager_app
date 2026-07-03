// lib/presentation/providers/maintenance_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/maintenance_repository_impl.dart';
import '../../domain/entities/maintenance_entity.dart';
import '../../domain/repositories/maintenance_repository.dart';
import '../../domain/usecases/maintenance/add_maintenance_usecase.dart';
import '../../domain/usecases/maintenance/delete_maintenance_usecase.dart';
import '../../domain/usecases/maintenance/update_maintenance_usecase.dart';
import '../../domain/usecases/maintenance/watch_maintenance_usecase.dart';
import 'vehicle_providers.dart';

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>(
  (ref) => MaintenanceRepositoryImpl(ref.watch(isarProvider)),
);

final addMaintenanceUsecaseProvider = Provider<AddMaintenanceUsecase>(
  (ref) => AddMaintenanceUsecase(ref.watch(maintenanceRepositoryProvider)),
);

final updateMaintenanceUsecaseProvider = Provider<UpdateMaintenanceUsecase>(
  (ref) => UpdateMaintenanceUsecase(ref.watch(maintenanceRepositoryProvider)),
);

final deleteMaintenanceUsecaseProvider = Provider<DeleteMaintenanceUsecase>(
  (ref) => DeleteMaintenanceUsecase(ref.watch(maintenanceRepositoryProvider)),
);

final maintenanceListProvider =
    StreamProvider.family<List<MaintenanceEntity>, int>((ref, vehicleId) {
      final usecase = WatchMaintenanceUsecase(
        ref.watch(maintenanceRepositoryProvider),
      );
      return usecase(vehicleId);
    });
