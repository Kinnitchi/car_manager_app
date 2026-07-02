import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/vehicle_entity.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/vehicle_card.dart';

class VehicleSelectorScreen extends ConsumerWidget {
  const VehicleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehicleListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Veículos')),
      body: vehiclesAsync.when(
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return _EmptyState(
              onAdd: () => context.push(RouteNames.vehicleForm),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return VehicleCard(
                vehicle: vehicle,
                onTap: () {
                  ref.read(selectedVehicleProvider.notifier).state = vehicle;
                  context.go(RouteNames.dashboard);
                },
                onEdit: () =>
                    context.push(RouteNames.vehicleForm, extra: vehicle),
                onDelete: () => _confirmDelete(context, ref, vehicle),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Erro ao carregar veículos: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RouteNames.vehicleForm),
        icon: const Icon(Icons.add),
        label: const Text('Novo Veículo'),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    VehicleEntity vehicle,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir veículo'),
        content: Text(
          'Deseja excluir ${vehicle.brand} ${vehicle.model} (${vehicle.plate})? '
          'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              final usecase = ref.read(deleteVehicleUsecaseProvider);
              final result = await usecase(vehicle.id!);

              if (!context.mounted) return;

              result.when(
                success: (_) {
                  if (ref.read(selectedVehicleProvider)?.id == vehicle.id) {
                    ref.read(selectedVehicleProvider.notifier).state = null;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Veículo excluído com sucesso'),
                    ),
                  );
                },
                failure: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao excluir: $error')),
                  );
                },
              );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.directions_car_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum veículo cadastrado',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione seu primeiro veículo para começar a controlar '
              'manutenções e abastecimentos.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Veículo'),
            ),
          ],
        ),
      ),
    );
  }
}
