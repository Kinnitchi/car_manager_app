import 'package:flutter/material.dart';

/// Paleta "Meridian" — azul elétrico sobre quase-preto, inspirada em apps
/// fintech premium (Revolut, Tesla). Fonte única de verdade para cor em
/// todo o app: nada de `Colors.*` cru espalhado pelas telas.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2D5BFF);
  static const Color primaryDark = Color(0xFF1A3FCC);
  static const Color secondary = Color(0xFF00E0B8);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF5A524);
  static const Color error = Color(0xFFF31260);

  // Cores de categoria — mesmo significado visual (combustível,
  // manutenção etc.) em stat cards, gráficos e legendas, em todas as
  // telas e nos dois temas.
  static const Color fuel = warning;
  static const Color maintenance = secondary;
  static const Color upcoming = Color(0xFF8B7CF6);
  static const Color consumption = Color(0xFF22D3EE);

  static const Color lightBackground = Color(0xFFF9FAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF0B0E14);
  static const Color darkSurface = Color(0xFF161B26);

  /// Gradiente de marca — usado no header do dashboard e destaques.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );
}
