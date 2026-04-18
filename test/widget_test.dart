import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:primera_app/main.dart';

void main() {
  testWidgets('Shows app bar and welcome text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Contenedor Dinamico'), findsOneWidget);
    expect(find.text('Estado actual: Compacto'), findsOneWidget);
    expect(find.text('Cambios realizados: 0'), findsOneWidget);
    expect(find.text('Expandir contenedor'), findsOneWidget);
    expect(find.text('Reiniciar'), findsOneWidget);
  });
}
