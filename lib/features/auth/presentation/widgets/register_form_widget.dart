import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';

class RegisterFormWidget extends HookConsumerWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);

    ref.listen(authFacadeProvider, (previous, next) {
      if (next.hasError) {
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
          RegisterFullNameField(),
          MenoSpacer.v(24),
          RegisterEmailField(),
          MenoSpacer.v(24),
          RegisterPasswordField(),
          MenoSpacer.v(24),
          TermsOfServiceCheckbox(),
          MenoSpacer.v(32),
          RegisterButton(),
        ],
      ),
    );
  }
}

class RegisterFullNameField extends HookConsumerWidget {
  const RegisterFullNameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('register_form_full_name_input'),
      placeholder: 'John Doe',
      label: 'Full name',
      prefixIcon: MIcons.user,
      size: MenoSize.lg,
      required: false,
      enabled: !ref.watch(authFacadeProvider).isLoading,
      focusNode: focusNode,
      onChanged: ref.read(registerFormProvider.notifier).onFullNameChanged,
      validator: ref.read(registerFormProvider.notifier).fullNameValidator,
    );
  }
}

class RegisterEmailField extends HookConsumerWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('register_form_email_input'),
      placeholder: 'example@gmail.com',
      label: 'Email address',
      prefixIcon: MIcons.mail,
      size: MenoSize.lg,
      required: false,
      enabled: !ref.watch(authFacadeProvider).isLoading,
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      onChanged: ref.read(registerFormProvider.notifier).onEmailChanged,
      validator: ref.read(registerFormProvider.notifier).emailValidator,
    );
  }
}

class RegisterPasswordField extends HookConsumerWidget {
  const RegisterPasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        MenoTextfield(
          key: const Key('register_form_password_input'),
          placeholder: 'Must be at least 8 characters',
          label: 'Be secure',
          isPassword: true,
          prefixIcon: MIcons.key,
          size: MenoSize.lg,
          required: false,
          onChanged: ref.read(registerFormProvider.notifier).onPasswordChanged,
          enabled: !ref.watch(authFacadeProvider).isLoading,
          focusNode: focusNode,
        ),
        const MenoSpacer.v(Insets.sm),
        const PasswordRulesWidgetTracker(),
      ],
    );
  }
}

class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenoPrimaryButton(
      size: MenoSize.lg,
      isLoading: ref.watch(authFacadeProvider).isLoading,
      disabled: ref.watch(registerFormProvider).isNotValid,
      onPressed: () async {
        if (!Form.of(context).validate()) return;
        final form = ref.read(registerFormProvider);
        return ref
            .read(authFacadeProvider.notifier)
            .register(
              email: form.email,
              fullName: form.fullName,
              password: form.password,
            );
      },
      child: const Text('Create your account'),
    );
  }
}
