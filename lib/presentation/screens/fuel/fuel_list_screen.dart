import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/fuel_entity.dart';
import '../../../domain/usecases/fuel/calculate_avg_consumption_usecase.dart';
import '../../providers/fuel_providers.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/fuel_card.dart';
import 'fuel_form_screen.dart';

class FuelListScreen extends ConsumerWidget {
  const FuelListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(selectedVehicleProvider);

    if (vehicle == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final fuelAsync = ref.watch(fuelListProvider(vehicle.id!));

    return Scaffold(
      appBar: AppBar(title: const Text('Abastecimentos')),
      body: fuelAsync.when(
        data: (list) {
          final consumption = const CalculateAvgConsumptionUsecase().call(list);

          if (list.isEmpty) {
            return const _EmptyState();
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (consumption.hasData) _ConsumptionBanner(result: consumption),
              if (consumption.hasData) const SizedBox(height: 16),
              ...list.map(
                (fuel) => FuelCard(
                  fuel: fuel,
                  onTap: () => context.push(
                    RouteNames.fuelForm,
                    extra: FuelFormArgs(vehicleId: vehicle.id!, fuel: fuel),
                  ),
                  onDelete: () => _confirmDelete(context, ref, fuel),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Erro ao carregar abastecimentos: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          RouteNames.fuelForm,
          extra: FuelFormArgs(vehicleId: vehicle.id!),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Abastecer'),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, FuelEntity fuel) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir abastecimento'),
        content: Text(
          'Deseja excluir o abastecimento de ${fuel.fuelType.label} '
          'de ${fuel.date.day}/${fuel.date.month}/${fuel.date.year}? '
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
              final result = await ref
                  .read(deleteFuelUsecaseProvider)
                  .call(fuel.id!);

              if (!context.mounted) return;
              result.when(
                success: (_) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Abastecimento excluído')),
                ),
                failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao excluir: $error')),
                ),
              );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}

class _ConsumptionBanner extends StatelessWidget {
  final AvgConsumptionResult result;
  const _ConsumptionBanner({required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.bar_chart, color: theme.colorScheme.onPrimaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consumo médio: ${result.averageKmPerLiter!.toStringAsFixed(1)} km/l',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                if (result.lastIntervalKmPerLiter != null)
                  Text(
                    'Último tanque: '
                    '${result.lastIntervalKmPerLiter!.toStringAsFixed(1)} km/l',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_gas_station_outlined,
              size: 72,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum abastecimento registrado ainda',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Dica: marque "tanque cheio" sempre que possível — '
              'isso deixa o cálculo de consumo médio mais preciso.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
