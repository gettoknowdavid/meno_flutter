// 
// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // if (!verified) return const VerifyEmailFormWidget();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MenoAssets.images.success.image(height: 240, width: 240),
              const MenoSpacer.v(48),
              const MenoText.heading2(
                'Welcome to Meno!',
                weight: MenoFontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const MenoSpacer.v(8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 64),
                child: MenoText.body(
                  'Explore the meno universe. We are super glad to have you here!',
                  weight: MenoFontWeight.regular,
                  textAlign: TextAlign.center,
                ),
              ),
              const MenoSpacer.v(48),
              MenoPrimaryButton(
                onPressed: () {},
                size: MenoSize.lg,
                child: const Text('Explore Meno'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
