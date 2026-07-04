import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';
import 'data/datasources/isar_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);
  await IsarService.init();

  await NotificationService.instance.init();
  await NotificationService.instance.requestPermission();

  runApp(const ProviderScope(child: App()));
}
