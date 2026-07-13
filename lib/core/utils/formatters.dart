import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static final _kmFormat = NumberFormat.decimalPattern('pt_BR');
  static String km(double value) => '${_kmFormat.format(value)} km';

  static final _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  static String currency(double value) => _currencyFormat.format(value);

  static final _dateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');
  static String date(DateTime date) => _dateFormat.format(date);

  /// Formata um número no padrão pt_BR (ponto como separador de milhar,
  /// vírgula como decimal) — usado tanto pela máscara de campos de
  /// formulário (km, litros, valores) quanto para popular o valor
  /// inicial ao editar um registro existente.
  static String maskedNumber(double value, {int decimalDigits = 0}) {
    final format = NumberFormat.decimalPattern('pt_BR')
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return format.format(value);
  }

  /// Converte de volta um texto no padrão pt_BR (com máscara) para
  /// double — remove o separador de milhar (.) e troca a vírgula
  /// decimal por ponto.
  static double? parseMaskedNumber(String text) {
    final cleaned = text.trim().replaceAll('.', '').replaceAll(',', '.');
    if (cleaned.isEmpty) return null;
    return double.tryParse(cleaned);
  }
}
