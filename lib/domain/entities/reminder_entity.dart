import '../../core/constants/reminder_types.dart';

class ReminderEntity {
  final int? id;
  final int vehicleId;
  final ReminderType type;
  final String title;
  final DateTime dueDate;
  final String? notes;

  const ReminderEntity({
    this.id,
    required this.vehicleId,
    required this.type,
    required this.title,
    required this.dueDate,
    this.notes,
  });

  ReminderEntity copyWith({
    int? id,
    int? vehicleId,
    ReminderType? type,
    String? title,
    DateTime? dueDate,
    String? notes,
  }) {
    return ReminderEntity(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      notes: notes ?? this.notes,
    );
  }
}
