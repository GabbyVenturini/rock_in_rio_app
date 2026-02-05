import 'package:app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/app.dart';

void main() {
  testWidgets('App inicia corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const RockInRioApp());

    // Verifica se o app renderiza sem erro
    expect(find.byType(RockInRioApp), findsOneWidget);
  });
}
