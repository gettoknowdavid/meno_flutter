import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/routing/routing.dart';

class PasswordRecoveryPage extends HookWidget {
  const PasswordRecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final complete = useState(true);
    return complete.value
        ? const _NewPasswordSuccess()
        : const _CreateNewPassword();
  }
}

class _CreateNewPassword extends StatelessWidget {
  const _CreateNewPassword();

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Scaffold(
      appBar: MenoTopBar.primary(title: 'Create new password'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MenoSpacer.v(24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MenoText.caption('Welcome back,'),
                      MenoText.heading3('New Birth Group'),
                    ],
                  ),
                ),
                CircleAvatar(radius: 24),
              ],
            ),
            const MenoSpacer.v(7),
            MenoText.caption(
              'Set up new password to continue \nyour experience',
              weight: MenoFontWeight.regular,
              color: colors.labelDisabled,
            ),
            const MenoSpacer.v(Insets.xxlg),
            const NewPasswordFormWidget(),
            const MenoSpacer.v(Insets.xxlg),
          ],
        ),
      ),
    );
  }
}

class _NewPasswordSuccess extends StatelessWidget {
  const _NewPasswordSuccess();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenoAssets.images.success.image(height: 240, width: 240),
            const MenoSpacer.v(48),
            const MenoText.heading2(
              'Success!',
              weight: MenoFontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const MenoSpacer.v(8),
            const LimitedBox(
              maxWidth: 250,
              child: MenoText.body(
                '''Your password has been reset, Jim. \nPhew! That was a close one.''',
                weight: MenoFontWeight.regular,
                textAlign: TextAlign.center,
              ),
            ),
            const MenoSpacer.v(48),
            MenoPrimaryButton(
              size: MenoSize.lg,
              onPressed: () => context.go(Routes.login.path),
              child: const Text('Go back to log in'),
            ),
          ],
        ),
      ),
    );
  }
}
