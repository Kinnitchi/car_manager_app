import 'package:isar_community/isar.dart';

part 'reminder_model.g.dart';

@collection
class ReminderModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int vehicleId;

  late String typeName;
  late String title;

  @Index()
  late DateTime dueDate;

  String? notes;
}
