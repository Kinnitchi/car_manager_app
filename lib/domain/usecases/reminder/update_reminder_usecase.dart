import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/reminder_entity.dart';
import '../../repositories/reminder_repository.dart';

class UpdateReminderUsecase {
  final ReminderRepository repository;
  UpdateReminderUsecase(this.repository);

  Future<Result<void>> call(ReminderEntity reminder) async {
    if (reminder.id == null) {
      return Result.failure(
        const ValidationFailure('Lembrete sem ID para atualização'),
      );
    }
    if (reminder.title.trim().isEmpty) {
      return Result.failure(const ValidationFailure('Título é obrigatório'));
    }
    return repository.update(reminder);
  }
}
