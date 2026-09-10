import 'package:fiap_test_flutter/presentation/pages/dashboard_page.dart';
import 'package:fiap_test_flutter/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: DashboardPage(),
    );
  }

  group('DashboardPage Widget Tests', () {
    testWidgets('deve renderizar todos os elementos visuais da Dashboard', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Dashboard de Cursos'), findsOneWidget);
      expect(find.byKey(const Key('btn_logout_icon')), findsOneWidget);
      expect(find.text('Bem-vindo à Pós-Graduação FIAP!'), findsOneWidget);
      expect(
        find.text('Ambiente de testes automatizados e integração contínua.'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('btn_logout')), findsOneWidget);
      expect(find.text('Sair'), findsOneWidget);
    });

    testWidgets(
      'deve redirecionar para LoginPage ao clicar no botão de logout principal',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.byKey(const Key('btn_logout')));
        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
        expect(find.text('FIAP Pós-Graduação'), findsOneWidget);
      },
    );

    testWidgets(
      'deve redirecionar para LoginPage ao clicar no ícone de logout na AppBar',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.byKey(const Key('btn_logout_icon')));
        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
        expect(find.text('FIAP Pós-Graduação'), findsOneWidget);
      },
    );
  });
}
