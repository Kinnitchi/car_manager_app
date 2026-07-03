import 'package:isar_community/isar.dart';
import '../../core/constants/fuel_types.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/fuel_entity.dart';
import '../../domain/repositories/fuel_repository.dart';
import '../models/fuel_model.dart';

class FuelRepositoryImpl implements FuelRepository {
  final Isar isar;
  FuelRepositoryImpl(this.isar);

  @override
  Future<Result<List<FuelEntity>>> getAllByVehicle(int vehicleId) async {
    try {
      final models = await isar.fuelModels
          .filter()
          .vehicleIdEqualTo(vehicleId)
          .sortByDateDesc()
          .findAll();
      return Result.success(models.map(_toEntity).toList());
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao buscar abastecimentos: $e'));
    }
  }

  @override
  Future<Result<int>> add(FuelEntity fuel) async {
    try {
      final model = _toModel(fuel);
      final id = await isar.writeTxn(() => isar.fuelModels.put(model));
      return Result.success(id);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao salvar abastecimento: $e'));
    }
  }

  @override
  Future<Result<void>> update(FuelEntity fuel) async {
    try {
      final model = _toModel(fuel);
      await isar.writeTxn(() => isar.fuelModels.put(model));
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        CacheFailure('Erro ao atualizar abastecimento: $e'),
      );
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      await isar.writeTxn(() => isar.fuelModels.delete(id));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao excluir abastecimento: $e'));
    }
  }

  @override
  Stream<List<FuelEntity>> watchByVehicle(int vehicleId) {
    return isar.fuelModels
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .sortByDateDesc()
        .watch(fireImmediately: true)
        .map((models) => models.map(_toEntity).toList());
  }

  FuelEntity _toEntity(FuelModel m) => FuelEntity(
    id: m.id,
    vehicleId: m.vehicleId,
    date: m.date,
    fuelType: _typeFromName(m.fuelTypeName),
    liters: m.liters,
    totalValue: m.totalValue,
    pricePerLiter: m.pricePerLiter,
    mileage: m.mileage,
    fullTank: m.fullTank,
  );

  FuelModel _toModel(FuelEntity e) {
    final model = FuelModel()
      ..vehicleId = e.vehicleId
      ..date = e.date
      ..fuelTypeName = e.fuelType.name
      ..liters = e.liters
      ..totalValue = e.totalValue
      ..pricePerLiter = e.pricePerLiter
      ..mileage = e.mileage
      ..fullTank = e.fullTank;
    if (e.id != null) {
      model.id = e.id!;
    }
    return model;
  }

  FuelType _typeFromName(String name) {
    return FuelType.values.firstWhere(
      (t) => t.name == name,
      orElse: () => FuelType.flex,
    );
  }
}
