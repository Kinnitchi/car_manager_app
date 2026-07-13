import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_shadows.dart';

/// Card com sombra suave (em vez da elevação padrão do Material) e um
/// leve efeito de "afundar" ao toque — usado no lugar de [Card] em
/// telas que devem ter aparência premium.
class PremiumCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? color;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.radius = AppRadius.md,
    this.color,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = AnimatedScale(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      scale: _pressed ? 0.98 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: widget.color ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: _pressed ? [] : AppShadows.card(theme.brightness),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );

    if (widget.onTap == null) return content;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapCancel: () => _setPressed(false),
      onTapUp: (_) => _setPressed(false),
      onTap: () {
        HapticFeedback.selectionClick();
        widget.onTap!();
      },
      child: content,
    );
  }
}
