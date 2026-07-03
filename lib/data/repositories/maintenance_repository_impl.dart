import 'package:isar_community/isar.dart';
import '../../core/constants/maintenance_types.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/maintenance_entity.dart';
import '../../domain/repositories/maintenance_repository.dart';
import '../models/maintenance_model.dart';

class MaintenanceRepositoryImpl implements MaintenanceRepository {
  final Isar isar;
  MaintenanceRepositoryImpl(this.isar);

  @override
  Future<Result<List<MaintenanceEntity>>> getAllByVehicle(int vehicleId) async {
    try {
      final models = await isar.maintenanceModels
          .filter()
          .vehicleIdEqualTo(vehicleId)
          .sortByDateDesc()
          .findAll();
      return Result.success(models.map(_toEntity).toList());
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao buscar manutenções: $e'));
    }
  }

  @override
  Future<Result<int>> add(MaintenanceEntity maintenance) async {
    try {
      final model = _toModel(maintenance);
      final id = await isar.writeTxn(() => isar.maintenanceModels.put(model));
      return Result.success(id);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao salvar manutenção: $e'));
    }
  }

  @override
  Future<Result<void>> update(MaintenanceEntity maintenance) async {
    try {
      final model = _toModel(maintenance);
      await isar.writeTxn(() => isar.maintenanceModels.put(model));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao atualizar manutenção: $e'));
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      await isar.writeTxn(() => isar.maintenanceModels.delete(id));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao excluir manutenção: $e'));
    }
  }

  @override
  Stream<List<MaintenanceEntity>> watchByVehicle(int vehicleId) {
    return isar.maintenanceModels
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .sortByDateDesc()
        .watch(fireImmediately: true)
        .map((models) => models.map(_toEntity).toList());
  }

  MaintenanceEntity _toEntity(MaintenanceModel m) => MaintenanceEntity(
    id: m.id,
    vehicleId: m.vehicleId,
    type: _typeFromName(m.typeName),
    description: m.description,
    date: m.date,
    mileage: m.mileage,
    cost: m.cost,
    workshop: m.workshop,
    notes: m.notes,
    nextMaintenanceMileage: m.nextMaintenanceMileage,
  );

  MaintenanceModel _toModel(MaintenanceEntity e) {
    final model = MaintenanceModel()
      ..vehicleId = e.vehicleId
      ..typeName = e.type.name
      ..description = e.description
      ..date = e.date
      ..mileage = e.mileage
      ..cost = e.cost
      ..workshop = e.workshop
      ..notes = e.notes
      ..nextMaintenanceMileage = e.nextMaintenanceMileage;
    if (e.id != null) {
      model.id = e.id!;
    }
    return model;
  }

  MaintenanceType _typeFromName(String name) {
    return MaintenanceType.values.firstWhere(
      (t) => t.name == name,
      orElse: () => MaintenanceType.other,
    );
  }
}
