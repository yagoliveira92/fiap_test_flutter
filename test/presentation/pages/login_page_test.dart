import 'package:fiap_test_flutter/presentation/pages/login_page.dart';
import 'package:fiap_test_flutter/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: LoginPage(),
    );
  }

  group('LoginPage Widget Tests', () {
    testWidgets(
      'deve renderizar o ícone de cabeçalho, título, subtítulo e o LoginForm',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byIcon(Icons.school), findsOneWidget);
        expect(find.text('FIAP Pós-Graduação'), findsOneWidget);
        expect(find.text('Plataforma de Avaliação e Testes'), findsOneWidget);
        expect(find.byType(LoginForm), findsOneWidget);
      },
    );
  });
}
