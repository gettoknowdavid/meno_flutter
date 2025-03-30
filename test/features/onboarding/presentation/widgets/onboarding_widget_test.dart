import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';

void main() {
  testWidgets('Should display correct image, title and description', (
    tester,
  ) async {
    final onboarding = Onboarding(
      title: 'Welcome',
      desc: 'This to Meno',
      imagePath: 'image/path',
    );

    final widget = OnboardingWidget(onboarding: onboarding);
    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.byType(Image), findsOneWidget);
    expect(find.text(onboarding.title), findsOneWidget);
    expect(find.text(onboarding.desc), findsOneWidget);
  });
}
