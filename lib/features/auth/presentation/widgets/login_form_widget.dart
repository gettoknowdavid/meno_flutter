import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';

class LoginFormWidget extends HookConsumerWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);

    ref.listen(authFacadeProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        final exception = next.error! as AuthException;
        MenoSnackBar.error(
          exception.message,
          size: exception.message.contains('\n') ? MenoSize.md : MenoSize.sm,
        );
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
    final isLoading = ref.watch(authFacadeProvider).isLoading;
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('login_form_email_input'),
      placeholder: 'example@gmail.com',
      label: 'Email address',
      prefixIcon: MIcons.mail,
      size: MenoSize.lg,
      required: false,
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      onChanged: ref.read(loginFormProvider.notifier).onEmailChanged,
      validator: ref.read(loginFormProvider.notifier).emailValidator,
    );
  }
}

class LoginPasswordField extends HookConsumerWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authFacadeProvider).isLoading;
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('login_form_password_input'),
      placeholder: 'Must be at least 8 characters',
      label: 'Be secure',
      isPassword: true,
      prefixIcon: MIcons.key,
      size: MenoSize.lg,
      required: false,
      enabled: !isLoading,
      focusNode: focusNode,
      onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
      validator: ref.read(loginFormProvider.notifier).passwordValidator,
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenoPrimaryButton(
      size: MenoSize.lg,
      isLoading: ref.watch(authFacadeProvider).isLoading,
      disabled: !ref.watch(loginFormProvider).isValid,
      onPressed: () async {
        if (!Form.of(context).validate()) return;
        final form = ref.read(loginFormProvider);
        return ref
            .read(authFacadeProvider.notifier)
            .login(email: form.email, password: form.password);
      },
      child: const Text('Log in'),
    );
  }
}
