// This is a basic Flutter widget test.
import 'package:flutter_test/flutter_test.dart';
import 'package:MatchIn/app.dart';

void main() {
  testWidgets('MatchIn widget smoke test', (WidgetTester tester) async {
    // Verify that MatchIn app widget can be instantiated
    const app = MatchIn();
    expect(app, isNotNull);
  });
}
