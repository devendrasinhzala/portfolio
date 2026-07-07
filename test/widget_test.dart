import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio smoke test', (WidgetTester tester) async {
    // Set desktop screen size to ensure all sections lay out properly
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    // Build our app and trigger a frame, wrapping it with ProviderScope.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Allow animations and layouts to settle
    await tester.pumpAndSettle();

    // Verify that the title initials 'DZ.' or the developer's name is found
    expect(find.text('DZ.'), findsOneWidget);
    expect(find.text('Devendrasinh Zala'), findsOneWidget);
  });
}
