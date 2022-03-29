import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:spot/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Login', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      var textfields = find.byType(TextField);
      await tester.enterText(textfields.first, "shakirhuzaifa42@gmail.com");
      await tester.enterText(textfields.last, "abcde12345");
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("item 2")));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "Radioactive");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));
      // await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("song 0")));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));
      final NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("item 3")));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));
    });
  });
}
