import 'package:isar_community/isar.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../models/vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final Isar isar;
  VehicleRepositoryImpl(this.isar);

  @override
  Future<Result<List<VehicleEntity>>> getAll() async {
    try {
      final models = await isar.vehicleModels.where().sortByBrand().findAll();
      return Result.success(models.map(_toEntity).toList());
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao buscar veículos: $e'));
    }
  }

  @override
  Future<Result<VehicleEntity?>> getById(int id) async {
    try {
      final model = await isar.vehicleModels.get(id);
      return Result.success(model != null ? _toEntity(model) : null);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao buscar veículo: $e'));
    }
  }

  @override
  Future<Result<int>> add(VehicleEntity vehicle) async {
    try {
      final model = _toModel(vehicle);
      final id = await isar.writeTxn(() => isar.vehicleModels.put(model));
      return Result.success(id);
    } on IsarUniqueViolationError {
      return Result.failure(
        const ValidationFailure(
          'Já existe um veículo cadastrado com essa placa.',
        ),
      );
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao salvar veículo: $e'));
    }
  }

  @override
  Future<Result<void>> update(VehicleEntity vehicle) async {
    try {
      final model = _toModel(vehicle);
      await isar.writeTxn(() => isar.vehicleModels.put(model));
      return Result.success(null);
    } on IsarUniqueViolationError {
      return Result.failure(
        const ValidationFailure(
          'Já existe um veículo cadastrado com essa placa.',
        ),
      );
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao atualizar veículo: $e'));
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      await isar.writeTxn(() => isar.vehicleModels.delete(id));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao excluir veículo: $e'));
    }
  }

  @override
  Stream<List<VehicleEntity>> watchAll() {
    return isar.vehicleModels
        .where()
        .sortByBrand()
        .watch(fireImmediately: true)
        .map((models) => models.map(_toEntity).toList());
  }

  VehicleEntity _toEntity(VehicleModel m) => VehicleEntity(
    id: m.id,
    brand: m.brand,
    model: m.model,
    year: m.year,
    plate: m.plate,
    color: m.color,
    currentMileage: m.currentMileage,
    photoPath: m.photoPath,
    createdAt: m.createdAt,
  );

  VehicleModel _toModel(VehicleEntity e) {
    final model = VehicleModel()
      ..brand = e.brand
      ..model = e.model
      ..year = e.year
      ..plate = e.plate
      ..color = e.color
      ..currentMileage = e.currentMileage
      ..photoPath = e.photoPath
      ..createdAt = e.createdAt;
    if (e.id != null) {
      model.id = e.id!;
    }
    return model;
  }
}
