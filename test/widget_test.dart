import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tenis/main.dart';

void main() {
  testWidgets('App renders LoginScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KineticApp());
    expect(find.text('KINETIC'), findsOneWidget);
  });
}
