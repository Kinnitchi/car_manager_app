import 'formatters.dart';

class Validators {
  Validators._();

  static String? required(String? value, {String fieldName = 'Campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }

  static String? year(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ano é obrigatório';
    final year = int.tryParse(value.trim());
    if (year == null) return 'Ano inválido';
    final currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear + 1) {
      return 'Ano deve estar entre 1950 e ${currentYear + 1}';
    }
    return null;
  }

  static String? mileage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Quilometragem é obrigatória';
    }
    final km = Formatters.parseMaskedNumber(value);
    if (km == null) return 'Quilometragem inválida';
    if (km < 0) return 'Quilometragem não pode ser negativa';
    return null;
  }

  static final _oldPlateRegex = RegExp(r'^[A-Z]{3}[0-9]{4}$');
  static final _mercosulPlateRegex = RegExp(r'^[A-Z]{3}[0-9][A-Z][0-9]{2}$');

  static String? plate(String? value) {
    if (value == null || value.trim().isEmpty) return 'Placa é obrigatória';
    final normalized = value
        .trim()
        .toUpperCase()
        .replaceAll('-', '')
        .replaceAll(' ', '');
    if (!_oldPlateRegex.hasMatch(normalized) &&
        !_mercosulPlateRegex.hasMatch(normalized)) {
      return 'Placa inválida (use ABC1234 ou ABC1D23)';
    }
    return null;
  }
}
