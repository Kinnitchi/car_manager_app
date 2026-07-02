import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/vehicle_form/vehicle_form_screen.dart';
import '../../presentation/screens/vehicle_selector/vehicle_selector_screen.dart';
import '../../presentation/providers/vehicle_providers.dart';
import '../../presentation/widgets/main_shell.dart';
import 'route_names.dart';

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title — em construção')),
    );
  }
}

/// Rotas que exigem um veículo selecionado (vivem dentro do Shell/bottom nav).
const _shellRoutes = {
  RouteNames.dashboard,
  RouteNames.maintenanceList,
  RouteNames.fuelList,
  RouteNames.reports,
  RouteNames.settings,
};

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.vehicleSelector,
    redirect: (context, state) {
      final hasSelectedVehicle = ref.read(selectedVehicleProvider) != null;
      final isGoingToShellRoute = _shellRoutes.contains(state.matchedLocation);

      // Sem veículo selecionado tentando acessar Dashboard/Manutenção/etc
      // → manda de volta pra seleção de veículo.
      if (isGoingToShellRoute && !hasSelectedVehicle) {
        return RouteNames.vehicleSelector;
      }
      return null; // sem redirecionamento
    },
    refreshListenable: _RouterRefreshNotifier(ref),
    routes: [
      GoRoute(
        path: RouteNames.vehicleSelector,
        builder: (_, __) => const VehicleSelectorScreen(),
      ),
      GoRoute(
        path: RouteNames.vehicleForm,
        builder: (context, state) {
          final vehicle = state.extra as VehicleEntity?;
          return VehicleFormScreen(vehicle: vehicle);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: RouteNames.maintenanceList,
            builder: (_, __) => const _PlaceholderScreen('Manutenções'),
          ),
          GoRoute(
            path: RouteNames.fuelList,
            builder: (_, __) => const _PlaceholderScreen('Abastecimentos'),
          ),
          GoRoute(
            path: RouteNames.reports,
            builder: (_, __) => const _PlaceholderScreen('Relatórios'),
          ),
          GoRoute(
            path: RouteNames.settings,
            builder: (_, __) => const _PlaceholderScreen('Configurações'),
          ),
        ],
      ),
    ],
  );
});

/// Faz o GoRouter reavaliar o `redirect` sempre que o veículo
/// selecionado mudar (ex: usuário troca ou exclui o veículo ativo).
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(selectedVehicleProvider, (_, __) => notifyListeners());
  }
}
