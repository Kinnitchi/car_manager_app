import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

/// Placeholder temporário até criarmos as telas reais.
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

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.dashboard,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (_, __) => const _PlaceholderScreen('Splash'),
      ),
      GoRoute(
        path: RouteNames.vehicleSelector,
        builder: (_, __) => const _PlaceholderScreen('Selecionar Veículo'),
      ),
      GoRoute(
        path: RouteNames.vehicleForm,
        builder: (_, __) => const _PlaceholderScreen('Cadastro de Veículo'),
      ),
      GoRoute(
        path: RouteNames.dashboard,
        builder: (_, __) => const _PlaceholderScreen('Dashboard'),
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
  );
});
