import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/usecases/maintenance/predict_next_maintenance_usecase.dart';
import '../../../core/constants/maintenance_types.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/maintenance_entity.dart';
import '../../providers/maintenance_providers.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/maintenance_card.dart';
import '../../widgets/responsive_center.dart';
import 'maintenance_form_screen.dart';

class MaintenanceListScreen extends ConsumerStatefulWidget {
  const MaintenanceListScreen({super.key});

  @override
  ConsumerState<MaintenanceListScreen> createState() =>
      _MaintenanceListScreenState();
}

class _MaintenanceListScreenState extends ConsumerState<MaintenanceListScreen> {
  final _searchController = TextEditingController();
  MaintenanceType? _filterType;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MaintenanceEntity> _applyFilters(List<MaintenanceEntity> list) {
    final query = _searchController.text.trim().toLowerCase();
    return list.where((m) {
      final matchesType = _filterType == null || m.type == _filterType;
      final matchesQuery =
          query.isEmpty ||
          m.description.toLowerCase().contains(query) ||
          m.type.label.toLowerCase().contains(query) ||
          (m.workshop?.toLowerCase().contains(query) ?? false);
      return matchesType && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = ref.watch(selectedVehicleProvider);

    if (vehicle == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final maintenanceAsync = ref.watch(maintenanceListProvider(vehicle.id!));
    final prediction = maintenanceAsync.maybeWhen(
      data: (list) => const PredictNextMaintenanceUsecase().call(
        list,
        vehicle.currentMileage,
      ),
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Manutenções')),
      body: ResponsiveCenter(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                children: [
                  if (prediction != null)
                    _PredictionBanner(prediction: prediction),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por tipo, descrição ou oficina...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _FilterChip(
                          label: 'Todos',
                          selected: _filterType == null,
                          onTap: () => setState(() => _filterType = null),
                        ),
                        ...MaintenanceType.values.map(
                          (type) => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: _FilterChip(
                              label: type.label,
                              selected: _filterType == type,
                              onTap: () => setState(() => _filterType = type),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: maintenanceAsync.when(
                data: (list) {
                  final filtered = _applyFilters(list);
                  if (filtered.isEmpty) {
                    return _EmptyState(hasAnyRecord: list.isNotEmpty);
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final maintenance = filtered[index];
                      return MaintenanceCard(
                        maintenance: maintenance,
                        onTap: () => context.push(
                          RouteNames.maintenanceForm,
                          extra: MaintenanceFormArgs(
                            vehicleId: vehicle.id!,
                            maintenance: maintenance,
                          ),
                        ),
                        onDelete: () => _confirmDelete(context, maintenance),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) =>
                    Center(child: Text('Erro ao carregar manutenções: $error')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          RouteNames.maintenanceForm,
          extra: MaintenanceFormArgs(vehicleId: vehicle.id!),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Registrar'),
      ),
    );
  }

  void _confirmDelete(BuildContext context, MaintenanceEntity maintenance) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir manutenção'),
        content: Text(
          'Deseja excluir o registro de "${maintenance.type.label}" '
          'de ${maintenance.description}? Esta ação não pode ser desfeita.',
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
                  .read(deleteMaintenanceUsecaseProvider)
                  .call(maintenance.id!);

              if (!context.mounted) return;
              result.when(
                success: (_) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Manutenção excluída')),
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

class _PredictionBanner extends StatelessWidget {
  final dynamic prediction; // NextMaintenancePrediction
  const _PredictionBanner({required this.prediction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue = prediction.isOverdue as bool;
    final color = isOverdue
        ? theme.colorScheme.error
        : theme.colorScheme.tertiary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(
            isOverdue ? Icons.warning_amber : Icons.event_available,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isOverdue
                  ? '${prediction.type.label} está atrasada em '
                        '${(-prediction.kmRemaining).toStringAsFixed(0)} km'
                  : 'Próxima: ${prediction.type.label} em '
                        '${prediction.kmRemaining.toStringAsFixed(0)} km',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool hasAnyRecord;
  const _EmptyState({required this.hasAnyRecord});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.build_outlined,
              size: 72,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              hasAnyRecord
                  ? 'Nenhum resultado para esse filtro'
                  : 'Nenhuma manutenção registrada ainda',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
