import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_dimens.dart';
import 'mini_progress_bar.dart';
import 'premium_card.dart';

/// Card de estatística do dashboard — ícone colorido, título, valor em
/// destaque e, opcionalmente, um subtítulo ou uma barra de progresso.
/// Entra em cena com fade + slide, com atraso escalonado por [index]
/// para criar um efeito de "cascata" quando a grade é montada.
class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double? progress;
  final int index;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    this.iconColor,
    this.onTap,
    this.progress,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = iconColor ?? theme.colorScheme.primary;

    return PremiumCard(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (progress != null) ...[
                const SizedBox(height: AppSpacing.sm),
                MiniProgressBar(value: progress!, color: color),
              ] else if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms, delay: (index * 60).ms, curve: Curves.easeOut)
        .slideY(
          begin: 0.12,
          end: 0,
          duration: 350.ms,
          delay: (index * 60).ms,
          curve: Curves.easeOut,
        );
  }
}
