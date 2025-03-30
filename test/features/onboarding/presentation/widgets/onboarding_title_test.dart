import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';

void main() {
  testWidgets('Should display title with bottom border', (tester) async {
    const fakeTitle = 'Welcome';
    const widget = OnboardingTitle(title: fakeTitle);
    await tester.pumpWidget(const MaterialApp(home: widget));
    expect(find.text(fakeTitle), findsOneWidget);
    expect(find.byType(ColoredBox), findsOneWidget);
  });
}
