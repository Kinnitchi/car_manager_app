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
}
