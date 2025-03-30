import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenoTopBar.primary(title: 'New account'),
      body: const SingleChildScrollView(
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
      ),
    );
  }
}
