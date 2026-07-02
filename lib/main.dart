import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'data/datasources/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await IsarService.init(); // temporariamente desativado — sem collections ainda

  runApp(const ProviderScope(child: App()));
}
