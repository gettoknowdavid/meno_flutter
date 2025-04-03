import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';

final purpleLogo = MenoAssets.images.logo.menoPurple;
final whiteLogo = MenoAssets.images.logo.menoWhite;

void main() {
  group('Meno Logo', () {
    testWidgets('Should render `Meno Purple Logo` in Light theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(theme: MenoTheme.light, home: const MenoLogo()),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final imageWidget = tester.widget(imageFinder) as Image;
      final imageProvider = imageWidget.image as AssetImage;
      expect(imageProvider.keyName, purpleLogo.keyName);
    });

    testWidgets('Should render `Meno White Logo` in Dark theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(theme: MenoTheme.dark, home: const MenoLogo()),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final imageWidget = tester.widget(imageFinder) as Image;
      final imageProvider = imageWidget.image as AssetImage;
      expect(imageProvider.keyName, whiteLogo.keyName);
    });
  });
}
