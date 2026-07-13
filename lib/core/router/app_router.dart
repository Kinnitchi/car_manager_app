import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/fuel/fuel_form_screen.dart';
import '../../presentation/screens/fuel/fuel_list_screen.dart';
import '../../presentation/screens/maintenance/maintenance_form_screen.dart';
import '../../presentation/screens/maintenance/maintenance_list_screen.dart';
import '../../presentation/screens/reports/reports_screen.dart';
import '../../presentation/screens/settings/reminder_form_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/vehicle_form/vehicle_form_screen.dart';
import '../../presentation/screens/vehicle_selector/vehicle_selector_screen.dart';
import '../../presentation/providers/vehicle_providers.dart';
import '../../presentation/widgets/main_shell.dart';
import 'route_names.dart';

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

      if (isGoingToShellRoute && !hasSelectedVehicle) {
        return RouteNames.vehicleSelector;
      }

      // `extra` só existe em memória — some após hot restart ou quando o
      // Android recria a tela na última rota (processo finalizado em
      // segundo plano). Sem ele o formulário não sabe o veículo, então
      // volta para a lista correspondente em vez de derrubar o app.
      switch (state.matchedLocation) {
        case RouteNames.maintenanceForm:
          if (state.extra is! MaintenanceFormArgs) {
            return RouteNames.maintenanceList;
          }
        case RouteNames.fuelForm:
          if (state.extra is! FuelFormArgs) {
            return RouteNames.fuelList;
          }
        case RouteNames.reminderForm:
          if (state.extra is! ReminderFormArgs) {
            return RouteNames.settings;
          }
      }
      return null;
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
      GoRoute(
        path: RouteNames.maintenanceForm,
        builder: (context, state) {
          final args = state.extra;
          if (args is! MaintenanceFormArgs) {
            return const _MissingArgsRedirect(RouteNames.maintenanceList);
          }
          return MaintenanceFormScreen(
            vehicleId: args.vehicleId,
            maintenance: args.maintenance,
          );
        },
      ),
      GoRoute(
        path: RouteNames.fuelForm,
        builder: (context, state) {
          final args = state.extra;
          if (args is! FuelFormArgs) {
            return const _MissingArgsRedirect(RouteNames.fuelList);
          }
          return FuelFormScreen(vehicleId: args.vehicleId, fuel: args.fuel);
        },
      ),
      GoRoute(
        path: RouteNames.reminderForm,
        builder: (context, state) {
          final args = state.extra;
          if (args is! ReminderFormArgs) {
            return const _MissingArgsRedirect(RouteNames.settings);
          }
          return ReminderFormScreen(
            vehicleId: args.vehicleId,
            reminder: args.reminder,
          );
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
            builder: (_, __) => const MaintenanceListScreen(),
          ),
          GoRoute(
            path: RouteNames.fuelList,
            builder: (_, __) => const FuelListScreen(),
          ),
          GoRoute(
            path: RouteNames.reports,
            builder: (_, __) => const ReportsScreen(),
          ),
          GoRoute(
            path: RouteNames.settings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});

class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(selectedVehicleProvider, (_, __) => notifyListeners());
  }
}

class _MissingArgsRedirect extends StatelessWidget {
  final String fallbackLocation;
  const _MissingArgsRedirect(this.fallbackLocation);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) context.go(fallbackLocation);
    });
    return const Scaffold(body: SizedBox.shrink());
  }
}
