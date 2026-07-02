import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/vehicle_entity.dart';

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

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.15,
              ),
              backgroundImage: hasPhoto
                  ? FileImage(File(vehicle.photoPath!))
                  : null,
              child: !hasPhoto
                  ? Icon(
                      Icons.directions_car,
                      size: 32,
                      color: theme.colorScheme.onPrimaryContainer,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${vehicle.brand} ${vehicle.model}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${vehicle.plate} • ${vehicle.year}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    Formatters.km(vehicle.currentMileage),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Trocar veículo',
              onPressed: onSwapVehicle,
              icon: Icon(
                Icons.swap_horiz,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
