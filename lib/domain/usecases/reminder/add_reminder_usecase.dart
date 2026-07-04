import '../../../core/errors/failures.dart';
import '../../../core/utils/result.dart';
import '../../entities/reminder_entity.dart';
import '../../repositories/reminder_repository.dart';

class AddReminderUsecase {
  final ReminderRepository repository;
  AddReminderUsecase(this.repository);

  Future<Result<int>> call(ReminderEntity reminder) async {
    final error = _validate(reminder);
    if (error != null) return Result.failure(ValidationFailure(error));
    return repository.add(reminder);
  }

  String? _validate(ReminderEntity r) {
    if (r.title.trim().isEmpty) return 'Título é obrigatório';
    return null;
  }
}
