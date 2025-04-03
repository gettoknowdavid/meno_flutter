import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Scaffold(
      appBar: isWeb ? null : MenoTopBar.primary(title: 'New account'),
      body: switch (isWeb) {
        true => const RegisterWebView(),
        false => const RegisterMobileView(),
      },
    );
  }
}

class RegisterWebView extends StatelessWidget {
  const RegisterWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MenoText.heading1('Create new account'),
        MenoSpacer.v(Insets.xs),
        MenoText.subheading(
          'Begin your meno streaming and broadcasting experience.',
          weight: MenoFontWeight.regular,
        ),
        MenoSpacer.v(32),
        RegisterFormWidget(),
        MenoSpacer.v(32),
        AuthOrDivider(),
        MenoSpacer.v(24),
        GoogleButton(),
        MenoSpacer.v(56),
        AuthRedirectionPrompt(),
      ],
    );
  }
}

class RegisterMobileView extends StatelessWidget {
  const RegisterMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RegisterFormWidget(),
          MenoSpacer.v(24),
          AuthOrDivider(),
          MenoSpacer.v(24),
          GoogleButton(),
          MenoSpacer.v(146),
          AuthRedirectionPrompt(),
        ],
      ),
    );
  }
}
