import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/routing/routes.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return SizedBox(
      height: 16,
      child: MenoTertiaryButton(
        onPressed: () => context.push(MenoRoute.resetPassword.path),
        style: ButtonStyle(
          padding: Internal.all(EdgeInsets.zero),
          foregroundColor: Internal.resolveWith(colors.labelPrimary),
        ),
        child: const Text('Forgot password?'),
      ),
    );
  }
}
