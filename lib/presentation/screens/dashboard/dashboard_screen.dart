import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/vehicle_summary_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(selectedVehicleProvider);

    // Guarda de segurança: o router já redireciona se não houver veículo
    // selecionado, mas isso evita um frame de erro caso o estado mude
    // no meio do rebuild (ex: veículo excluído em outra tela).
    if (vehicle == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: quando Fuel/Maintenance existirem, invalidar os
          // providers de resumo aqui para forçar recálculo.
          ref.invalidate(vehicleListProvider);
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
                // Dado real, já disponível hoje.
                StatCard(
                  icon: Icons.speed,
                  title: 'Quilometragem atual',
                  value: '${vehicle.currentMileage.toStringAsFixed(0)} km',
                  iconColor: Colors.blue,
                ),

                // TODO: substituir por dado real quando o CRUD de
                // Abastecimento existir (FuelRepository.getLast(vehicleId)).
                StatCard(
                  icon: Icons.local_gas_station,
                  title: 'Último abastecimento',
                  value: 'Sem registros',
                  subtitle: 'Nenhum abastecimento ainda',
                  iconColor: Colors.orange,
                  onTap: () => context.go(RouteNames.fuelList),
                ),

                // TODO: substituir por dado real quando o CRUD de
                // Manutenção existir (MaintenanceRepository.getLast(vehicleId)).
                StatCard(
                  icon: Icons.build,
                  title: 'Última manutenção',
                  value: 'Sem registros',
                  subtitle: 'Nenhuma manutenção ainda',
                  iconColor: Colors.green,
                  onTap: () => context.go(RouteNames.maintenanceList),
                ),

                // TODO: substituir pelo cálculo de
                // predict_next_maintenance_usecase.dart.
                const StatCard(
                  icon: Icons.event_available,
                  title: 'Próxima manutenção',
                  value: 'Não prevista',
                  subtitle: 'Registre manutenções para prever',
                  iconColor: Colors.purple,
                ),

                // TODO: substituir pelo cálculo de gasto mensal
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
