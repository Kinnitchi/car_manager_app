import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Cores de categoria — mesmo significado visual (combustível,
  // manutenção etc.) em stat cards, gráficos e legendas, em todas as
  // telas e nos dois temas.
  static const Color fuel = warning;
  static const Color maintenance = secondary;
  static const Color upcoming = Color(0xFF8B5CF6);
  static const Color consumption = Color(0xFF14B8A6);

  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color darkBackground = Color(0xFF0F172A);
}
