import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService.instance,
);

/// Evita alertar o usuário mais de uma vez por sessão sobre a mesma
/// manutenção atrasada — sem isso, toda vez que o Dashboard rebuild-a
/// (ex: troca de aba e volta) dispararia uma notificação nova.
/// MVP simples: guarda em memória, reseta ao reabrir o app. Uma
/// evolução futura seria persistir isso no banco por veículo.
final notifiedMaintenanceKeysProvider = StateProvider<Set<String>>((_) => {});
