// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:yes_twice/my_app.dart';
import 'package:yes_twice/feature/splash/view/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App loads splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the SplashScreen is present.
    expect(find.byType(SplashScreen), findsOneWidget);

    // Let the delayed future and animations complete to avoid pending timer errors
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
