import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/reminder_repository_impl.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../../domain/usecases/reminder/add_reminder_usecase.dart';
import '../../domain/usecases/reminder/delete_reminder_usecase.dart';
import '../../domain/usecases/reminder/update_reminder_usecase.dart';
import '../../domain/usecases/reminder/watch_reminders_usecase.dart';
import 'vehicle_providers.dart';

final reminderRepositoryProvider = Provider<ReminderRepository>(
  (ref) => ReminderRepositoryImpl(ref.watch(isarProvider)),
);

final addReminderUsecaseProvider = Provider<AddReminderUsecase>(
  (ref) => AddReminderUsecase(ref.watch(reminderRepositoryProvider)),
);

final updateReminderUsecaseProvider = Provider<UpdateReminderUsecase>(
  (ref) => UpdateReminderUsecase(ref.watch(reminderRepositoryProvider)),
);

final deleteReminderUsecaseProvider = Provider<DeleteReminderUsecase>(
  (ref) => DeleteReminderUsecase(ref.watch(reminderRepositoryProvider)),
);

final reminderListProvider = StreamProvider.family<List<ReminderEntity>, int>((
  ref,
  vehicleId,
) {
  final usecase = WatchRemindersUsecase(ref.watch(reminderRepositoryProvider));
  return usecase(vehicleId);
});
