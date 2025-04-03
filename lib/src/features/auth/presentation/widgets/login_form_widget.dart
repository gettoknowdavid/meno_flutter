import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/onboarding/data/data.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class LoginFormWidget extends HookConsumerWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);

    ref.listen(loginFormProvider, (previous, next) async {
      switch (next.status) {
        case MenoFormStatus.canceled:
        case MenoFormStatus.inProgress:
        case MenoFormStatus.initial:
          return;
        case MenoFormStatus.failure:
          final message = next.exception!.message;
          MenoSnackBar.error(
            message,
            size: message.contains('\n') ? MenoSize.md : MenoSize.sm,
          );
        case MenoFormStatus.success:
          if (!ref.read(onboardingFacadeProvider).onboardingComplete) {
            await ref.read(onboardingFacadeProvider).completeOnboarding();
          }
      }
    });

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MenoSpacer.v(24),
          LoginEmailField(),
          MenoSpacer.v(24),
          LoginPasswordField(),
          MenoSpacer.v(8),
          Align(
            alignment: Alignment.centerRight,
            child: ForgotPasswordButton(),
          ),
          MenoSpacer.v(32),
          LoginButton(),
        ],
      ),
    );
  }
}

class LoginEmailField extends HookConsumerWidget {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(loginFormProvider.select((s) => s.email));
    final status = ref.watch(loginFormProvider.select((s) => s.status));
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('login_form_email_input'),
      placeholder: 'example@gmail.com',
      label: 'Email address',
      prefixIcon: MIcons.mail,
      size: MenoSize.lg,
      required: false,
      enabled: status != MenoFormStatus.inProgress,
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      onChanged: ref.read(loginFormProvider.notifier).onEmailChanged,
      validator: (value) => email.validator(value ?? '')?.text,
    );
  }
}

class LoginPasswordField extends HookConsumerWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(loginFormProvider.select((s) => s.password));
    final status = ref.watch(loginFormProvider.select((s) => s.status));
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('login_form_password_input'),
      placeholder: 'Must be at least 8 characters',
      label: 'Be secure',
      isPassword: true,
      prefixIcon: MIcons.key,
      size: MenoSize.lg,
      required: false,
      enabled: status != MenoFormStatus.inProgress,
      focusNode: focusNode,
      onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
      validator: (value) => password.validator(value ?? '')?.text,
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(loginFormProvider.select((s) => s.status));

    return MenoPrimaryButton(
      size: MenoSize.lg,
      isLoading: status == MenoFormStatus.inProgress,
      disabled: ref.watch(loginFormProvider.select((s) => s.isNotValid)),
      onPressed: () {
        if (Form.of(context).validate()) {
          ref.read(loginFormProvider.notifier).submit();
        }
      },
      child: const Text('Log in'),
    );
  }
}
