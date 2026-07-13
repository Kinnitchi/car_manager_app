import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_dimens.dart';

/// Atalhos de ações rápidas do dashboard — botões "tonais" com ícone,
/// em vez do [OutlinedButton] padrão do Flutter.
class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.local_gas_station_rounded,
            label: 'Abastecer',
            color: theme.colorScheme.primary,
            onTap: () => context.go(RouteNames.fuelList),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.build_rounded,
            label: 'Manutenção',
            color: theme.colorScheme.secondary,
            onTap: () => context.go(RouteNames.maintenanceList),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 350.ms, delay: 480.ms);
  }
}

class _QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: () {
        HapticFeedback.selectionClick();
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color),
              const SizedBox(height: AppSpacing.xs),
              Text(
                widget.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
