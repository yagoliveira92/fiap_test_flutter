import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fiap_test_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validação do fluxo inicial do aplicativo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Placeholder para os testes E2E executados em aula
    expect(find.byType(app.MyApp), findsOneWidget);
  });
}
