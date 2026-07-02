import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/route_names.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const _destinations = [
    _NavItem(
      RouteNames.dashboard,
      Icons.dashboard_outlined,
      Icons.dashboard,
      'Início',
    ),
    _NavItem(
      RouteNames.maintenanceList,
      Icons.build_outlined,
      Icons.build,
      'Manutenção',
    ),
    _NavItem(
      RouteNames.fuelList,
      Icons.local_gas_station_outlined,
      Icons.local_gas_station,
      'Abastecimento',
    ),
    _NavItem(
      RouteNames.reports,
      Icons.bar_chart_outlined,
      Icons.bar_chart,
      'Relatórios',
    ),
    _NavItem(
      RouteNames.settings,
      Icons.settings_outlined,
      Icons.settings,
      'Config.',
    ),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _destinations.indexWhere((d) => d.path == location);
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          context.go(_destinations[index].path);
        },
        destinations: _destinations
            .map(
              (d) => NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _NavItem {
  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavItem(this.path, this.icon, this.selectedIcon, this.label);
}
