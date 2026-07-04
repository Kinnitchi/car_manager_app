import 'package:isar_community/isar.dart';
import '../../core/constants/reminder_types.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../models/reminder_model.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final Isar isar;
  ReminderRepositoryImpl(this.isar);

  @override
  Future<Result<List<ReminderEntity>>> getAllByVehicle(int vehicleId) async {
    try {
      final models = await isar.reminderModels
          .filter()
          .vehicleIdEqualTo(vehicleId)
          .sortByDueDate()
          .findAll();
      return Result.success(models.map(_toEntity).toList());
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao buscar lembretes: $e'));
    }
  }

  @override
  Future<Result<int>> add(ReminderEntity reminder) async {
    try {
      final model = _toModel(reminder);
      final id = await isar.writeTxn(() => isar.reminderModels.put(model));
      return Result.success(id);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao salvar lembrete: $e'));
    }
  }

  @override
  Future<Result<void>> update(ReminderEntity reminder) async {
    try {
      final model = _toModel(reminder);
      await isar.writeTxn(() => isar.reminderModels.put(model));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao atualizar lembrete: $e'));
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      await isar.writeTxn(() => isar.reminderModels.delete(id));
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('Erro ao excluir lembrete: $e'));
    }
  }

  @override
  Stream<List<ReminderEntity>> watchByVehicle(int vehicleId) {
    return isar.reminderModels
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .sortByDueDate()
        .watch(fireImmediately: true)
        .map((models) => models.map(_toEntity).toList());
  }

  ReminderEntity _toEntity(ReminderModel m) => ReminderEntity(
    id: m.id,
    vehicleId: m.vehicleId,
    type: _typeFromName(m.typeName),
    title: m.title,
    dueDate: m.dueDate,
    notes: m.notes,
  );

  ReminderModel _toModel(ReminderEntity e) {
    final model = ReminderModel()
      ..vehicleId = e.vehicleId
      ..typeName = e.type.name
      ..title = e.title
      ..dueDate = e.dueDate
      ..notes = e.notes;
    if (e.id != null) model.id = e.id!;
    return model;
  }

  ReminderType _typeFromName(String name) {
    return ReminderType.values.firstWhere(
      (t) => t.name == name,
      orElse: () => ReminderType.other,
    );
  }
}
