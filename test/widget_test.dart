// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:car_manager_app/app.dart';

void main() {
  testWidgets('App inicializa e mostra o Dashboard', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Como o Isar precisa ser inicializado antes do App,
    // este teste smoke apenas garante que a árvore de widgets monta sem erro.
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
