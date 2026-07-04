import '../../core/utils/result.dart';
import '../entities/reminder_entity.dart';

abstract class ReminderRepository {
  Future<Result<List<ReminderEntity>>> getAllByVehicle(int vehicleId);
  Future<Result<int>> add(ReminderEntity reminder);
  Future<Result<void>> update(ReminderEntity reminder);
  Future<Result<void>> delete(int id);
  Stream<List<ReminderEntity>> watchByVehicle(int vehicleId);
}
