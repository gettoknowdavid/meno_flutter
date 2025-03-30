import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenoTopBar.primary(title: 'Log in'),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginFormWidget(),
            MenoSpacer.v(24),
            AuthOrDivider(),
            MenoSpacer.v(24),
            GoogleButton(),
            MenoSpacer.v(146),
            AuthRedirectionPrompt(isLogin: true),
          ],
        ),
      ),
    );
  }
}
