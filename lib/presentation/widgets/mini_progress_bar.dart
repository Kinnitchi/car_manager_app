import 'package:flutter/material.dart';

/// Barra de progresso fina e arredondada, com animação suave de
/// preenchimento — usada para mostrar progresso em direção a um marco
/// (ex: km restantes até a próxima manutenção).
class MiniProgressBar extends StatelessWidget {
  /// 0.0 a 1.0.
  final double value;
  final Color color;
  final double height;

  const MiniProgressBar({
    super.key,
    required this.value,
    required this.color,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    final track = Theme.of(context).colorScheme.surfaceContainerHighest;
    final clamped = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        color: track,
        alignment: Alignment.centerLeft,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: clamped),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (context, animatedValue, _) {
            return FractionallySizedBox(
              widthFactor: animatedValue,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
