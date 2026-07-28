import 'package:flutter_test/flutter_test.dart';
import 'package:smart_cafe/main.dart';

void main() {
  testWidgets('Smart Cafe opens', (tester) async {
    await tester.pumpWidget(const CafeApp());
    expect(find.text('Smart Café'), findsOneWidget);
  });
}
