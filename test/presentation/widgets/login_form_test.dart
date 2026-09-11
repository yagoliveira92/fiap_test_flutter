import 'package:fiap_test_flutter/presentation/pages/dashboard_page.dart';
import 'package:fiap_test_flutter/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }

  group('LoginForm Widget Tests', () {

    testWidgets('deve renderizar os campos de email, senha e botão de login', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byKey(Key('input_email')), findsOneWidget);
      expect(find.byKey(Key('input_password')), findsOneWidget);
      expect(find.byKey(Key('btn_login')), findsOneWidget);
      expect(find.text('Entrar'), findsOneWidget);
    });

    testWidgets(
      'deve alternar a visibilidade da senha ao clicar no ícone de visualização',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        // Inicialmente a senha é obscurecida (obscureText = true)
        var passwordField = tester.widget<TextField>(
          find.descendant(
            of: find.byKey(const Key('input_password')),
            matching: find.byType(TextField),
          ),
        );
        expect(passwordField.obscureText, isTrue);
        expect(find.byIcon(Icons.visibility), findsOneWidget);

        // Toca no ícone para revelar a senha
        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        passwordField = tester.widget<TextField>(
          find.descendant(
            of: find.byKey(const Key('input_password')),
            matching: find.byType(TextField),
          ),
        );
        expect(passwordField.obscureText, isFalse);
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);

        // Toca novamente para ocultar a senha
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pump();

        passwordField = tester.widget<TextField>(
          find.descendant(
            of: find.byKey(const Key('input_password')),
            matching: find.byType(TextField),
          ),
        );
        expect(passwordField.obscureText, isTrue);
      },
    );

    testWidgets(
      'deve exibir erro "E-mail incorreto" quando o e-mail não contiver @',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byKey(const Key('input_email')),
          'emailinvalido.com',
        );
        await tester.enterText(
          find.byKey(const Key('input_password')),
          '123456',
        );

        await tester.tap(find.byKey(const Key('btn_login')));
        await tester.pump();

        expect(find.text('E-mail incorreto'), findsOneWidget);
        expect(find.byKey(const Key('general_error')), findsNothing);
      },
    );

    testWidgets(
      'deve exibir erro "Credenciais inválidas" quando credenciais estiverem incorretas',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byKey(const Key('input_email')),
          'outro@fiap.com.br',
        );
        await tester.enterText(
          find.byKey(const Key('input_password')),
          'senha_errada',
        );

        await tester.tap(find.byKey(const Key('btn_login')));
        await tester.pump();

        expect(find.byKey(const Key('general_error')), findsOneWidget);
        expect(find.text('Credenciais inválidas'), findsOneWidget);
        expect(find.text('E-mail incorreto'), findsNothing);
      },
    );

    testWidgets(
      'deve navegar para DashboardPage quando as credenciais forem válidas',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byKey(const Key('input_email')),
          'pos@fiap.com.br',
        );
        await tester.enterText(
          find.byKey(const Key('input_password')),
          '123456',
        );

        await tester.tap(find.byKey(const Key('btn_login')));
        await tester.pumpAndSettle();

        expect(find.byType(DashboardPage), findsOneWidget);
        expect(find.text('Dashboard de Cursos'), findsOneWidget);
      },
    );
  });
}
