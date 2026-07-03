import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/formatters.dart';
import '../../providers/maintenance_providers.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/vehicle_summary_header.dart';
import '../../../domain/usecases/maintenance/predict_next_maintenance_usecase.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(vehicleListProvider);
          ref.invalidate(maintenanceListProvider(vehicle.id!));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            VehicleSummaryHeader(
              vehicle: vehicle,
              onSwapVehicle: () => context.push(RouteNames.vehicleSelector),
            ),
            const SizedBox(height: 20),
            Text(
              'Resumo',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                StatCard(
                  icon: Icons.speed,
                  title: 'Quilometragem atual',
                  value: '${vehicle.currentMileage.toStringAsFixed(0)} km',
                  iconColor: Colors.blue,
                ),

                // TODO: substituir por dado real quando o CRUD de
                // Abastecimento existir.
                StatCard(
                  icon: Icons.local_gas_station,
                  title: 'Último abastecimento',
                  value: 'Sem registros',
                  subtitle: 'Nenhum abastecimento ainda',
                  iconColor: Colors.orange,
                  onTap: () => context.go(RouteNames.fuelList),
                ),

                // Agora com dado real do histórico de manutenções.
                maintenanceAsync.when(
                  data: (list) {
                    if (list.isEmpty) {
                      return StatCard(
                        icon: Icons.build,
                        title: 'Última manutenção',
                        value: 'Sem registros',
                        subtitle: 'Nenhuma manutenção ainda',
                        iconColor: Colors.green,
                        onTap: () => context.go(RouteNames.maintenanceList),
                      );
                    }
                    final last = list.first; // já vem ordenado desc
                    return StatCard(
                      icon: Icons.build,
                      title: 'Última manutenção',
                      value: last.type.label,
                      subtitle: Formatters.date(last.date),
                      iconColor: Colors.green,
                      onTap: () => context.go(RouteNames.maintenanceList),
                    );
                  },
                  loading: () => const StatCard(
                    icon: Icons.build,
                    title: 'Última manutenção',
                    value: '...',
                    iconColor: Colors.green,
                  ),
                  error: (_, __) => StatCard(
                    icon: Icons.build,
                    title: 'Última manutenção',
                    value: 'Erro',
                    iconColor: Colors.green,
                    onTap: () => context.go(RouteNames.maintenanceList),
                  ),
                ),

                // Previsão real, calculada pelo PredictNextMaintenanceUsecase.
                StatCard(
                  icon: prediction != null && prediction.isOverdue
                      ? Icons.warning_amber
                      : Icons.event_available,
                  title: 'Próxima manutenção',
                  value: prediction == null
                      ? 'Não prevista'
                      : prediction.type.label,
                  subtitle: prediction == null
                      ? 'Registre manutenções para prever'
                      : prediction.isOverdue
                      ? 'Atrasada em '
                            '${(-prediction.kmRemaining).toStringAsFixed(0)} km'
                      : 'Em ${prediction.kmRemaining.toStringAsFixed(0)} km',
                  iconColor: prediction != null && prediction.isOverdue
                      ? Colors.red
                      : Colors.purple,
                  onTap: () => context.go(RouteNames.maintenanceList),
                ),

                // TODO: substituir pelo gasto real do mês
                // (soma de Fuel + Maintenance do mês atual).
                StatCard(
                  icon: Icons.attach_money,
                  title: 'Gastos do mês',
                  value: 'R\$ 0,00',
                  iconColor: Colors.red,
                  onTap: () => context.go(RouteNames.reports),
                ),

                // TODO: substituir pelo calculate_avg_consumption_usecase.dart.
                StatCard(
                  icon: Icons.bar_chart,
                  title: 'Consumo médio',
                  value: '-- km/l',
                  iconColor: Colors.teal,
                  onTap: () => context.go(RouteNames.reports),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _QuickActions(),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ações rápidas',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.go(RouteNames.fuelList),
                icon: const Icon(Icons.local_gas_station),
                label: const Text('Abastecer'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.go(RouteNames.maintenanceList),
                icon: const Icon(Icons.build),
                label: const Text('Manutenção'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
