import 'package:flutter/services.dart';
import 'formatters.dart';

/// Aplica máscara numérica em tempo real (separador de milhar e,
/// opcionalmente, casas decimais) — ex: "120300" -> "120.300" (km);
/// "123456" com 2 casas -> "1.234,56" (valores/litros). Os dígitos são
/// tratados como um inteiro contínuo, deslocando as casas decimais a
/// cada tecla — o mesmo padrão usado em campos de valor de apps
/// bancários.
class MaskedNumberInputFormatter extends TextInputFormatter {
  final int decimalDigits;

  const MaskedNumberInputFormatter({this.decimalDigits = 0});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue();
    }

    final divisor = decimalDigits > 0 ? _pow10(decimalDigits) : 1;
    final value = int.parse(digits) / divisor;
    final formatted = Formatters.maskedNumber(
      value,
      decimalDigits: decimalDigits,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  static int _pow10(int exponent) {
    var result = 1;
    for (var i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }
}
