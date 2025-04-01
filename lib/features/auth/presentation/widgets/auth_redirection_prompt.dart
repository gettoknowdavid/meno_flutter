import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/routing/routes.dart';

class AuthRedirectionPrompt extends ConsumerWidget {
  const AuthRedirectionPrompt({super.key, this.isLogin = false});
  final bool isLogin;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MenoText.body(
          isLogin ? 'Don’t have an account?' : 'Already have an account?',
          color: colors.disabledBase,
        ),
        const MenoSpacer.h(Insets.sm),
        MenoTertiaryButton(
          onPressed:
              () =>
                  isLogin
                      ? context.push(MenoRoute.register.path)
                      : context.push(MenoRoute.login.path),
          style: ButtonStyle(padding: Internal.all(EdgeInsets.zero)),
          child: isLogin ? const Text('Create one') : const Text('Log in'),
        ),
      ],
    );
  }
}
