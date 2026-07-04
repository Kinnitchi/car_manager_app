import '../../../core/utils/result.dart';
import '../../repositories/reminder_repository.dart';

class DeleteReminderUsecase {
  final ReminderRepository repository;
  DeleteReminderUsecase(this.repository);

  Future<Result<void>> call(int id) => repository.delete(id);
}
