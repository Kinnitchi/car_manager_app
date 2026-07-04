import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../services/notification_service.dart';
import '../../providers/notification_providers.dart';
import '../../providers/reminder_providers.dart';
import '../../providers/vehicle_providers.dart';
import '../../widgets/reminder_card.dart';
import '../../widgets/responsive_center.dart';
import 'reminder_form_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(selectedVehicleProvider);

    if (vehicle == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final remindersAsync = ref.watch(reminderListProvider(vehicle.id!));

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ResponsiveCenter(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Lembretes',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Documentação, seguro e licenciamento — '
              'troca de óleo e revisões já são previstas automaticamente.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            remindersAsync.when(
              data: (list) {
                if (list.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'Nenhum lembrete cadastrado',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }
                return Column(
                  children: list
                      .map(
                        (reminder) => ReminderCard(
                          reminder: reminder,
                          onTap: () => context.push(
                            RouteNames.reminderForm,
                            extra: ReminderFormArgs(
                              vehicleId: vehicle.id!,
                              reminder: reminder,
                            ),
                          ),
                          onDelete: () =>
                              _confirmDelete(context, ref, reminder.id!),
                        ),
                      )
                      .toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Erro ao carregar lembretes: $e'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => context.push(
                RouteNames.reminderForm,
                extra: ReminderFormArgs(vehicleId: vehicle.id!),
              ),
              icon: const Icon(Icons.add_alert),
              label: const Text('Novo Lembrete'),
            ),
            const Divider(height: 40),
            Text(
              'Sobre o app',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.directions_car),
              title: Text('Gestor Veicular'),
              subtitle: Text('Versão 1.0.0'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, int reminderId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir lembrete'),
        content: const Text('Deseja excluir este lembrete?'),
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
              final notificationId = NotificationService.notificationIdFor(
                reminderId,
              );
              await ref
                  .read(notificationServiceProvider)
                  .cancel(notificationId);
              await ref.read(deleteReminderUsecaseProvider).call(reminderId);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
