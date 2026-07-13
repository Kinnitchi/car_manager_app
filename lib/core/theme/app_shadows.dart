import 'package:flutter/material.dart';

/// Sombras suaves e discretas (em vez da elevação padrão do Material,
/// que fica "achatada"/cinza). No dark mode a sombra em si não ajuda
/// muito contra um fundo já escuro, então usamos algo bem sutil.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> card(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];
    }
    return [
      BoxShadow(
        color: const Color(0xFF1A2233).withValues(alpha: 0.06),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: const Color(0xFF1A2233).withValues(alpha: 0.04),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ];
  }

  /// Sombra mais pronunciada, usada em elementos "flutuantes" (FAB,
  /// destaques de tela) — reforça o efeito de profundidade premium.
  static List<BoxShadow> floating(Brightness brightness, Color tint) {
    return [
      BoxShadow(
        color: tint.withValues(
          alpha: brightness == Brightness.dark ? 0.35 : 0.28,
        ),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
    ];
  }
}
