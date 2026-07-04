enum ReminderType {
  documentation,
  insurance,
  licensing,
  other;

  String get label {
    switch (this) {
      case ReminderType.documentation:
        return 'Documentação';
      case ReminderType.insurance:
        return 'Seguro';
      case ReminderType.licensing:
        return 'Licenciamento';
      case ReminderType.other:
        return 'Outro';
    }
  }
}
