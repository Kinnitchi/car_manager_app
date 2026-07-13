import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/vehicle_entity.dart';

/// Card de destaque do dashboard — fundo em gradiente da marca, com a
/// foto/ícone do veículo e seus dados principais.
class VehicleSummaryHeader extends StatelessWidget {
  final VehicleEntity vehicle;
  final VoidCallback onSwapVehicle;

  const VehicleSummaryHeader({
    super.key,
    required this.vehicle,
    required this.onSwapVehicle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPhoto =
        vehicle.photoPath != null && File(vehicle.photoPath!).existsSync();

    return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.floating(theme.brightness, AppColors.primary),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                backgroundImage: hasPhoto
                    ? FileImage(File(vehicle.photoPath!))
                    : null,
                child: !hasPhoto
                    ? const Icon(
                        Icons.directions_car_rounded,
                        size: 32,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicle.brand} ${vehicle.model}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${vehicle.plate} • ${vehicle.year}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.82),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        Formatters.km(vehicle.currentMileage),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.white.withValues(alpha: 0.16),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onSwapVehicle();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(AppSpacing.sm),
                    child: Icon(Icons.swap_horiz_rounded, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.08, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }
}
