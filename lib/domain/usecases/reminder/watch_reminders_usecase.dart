import '../../entities/reminder_entity.dart';
import '../../repositories/reminder_repository.dart';

class WatchRemindersUsecase {
  final ReminderRepository repository;
  WatchRemindersUsecase(this.repository);

  Stream<List<ReminderEntity>> call(int vehicleId) =>
      repository.watchByVehicle(vehicleId);
}
