import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class RegisterFormWidget extends HookConsumerWidget {
  const RegisterFormWidget({super.key});

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
    final fullName = ref.read(registerFormProvider.select((s) => s.fullName));
    final status = ref.watch(registerFormProvider.select((s) => s.status));
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('register_form_full_name_input'),
      placeholder: 'John Doe',
      label: 'Full name',
      prefixIcon: MIcons.user,
      size: MenoSize.lg,
      required: false,
      enabled: status != MenoFormStatus.inProgress,
      focusNode: focusNode,
      onChanged: ref.read(registerFormProvider.notifier).onFullNameChanged,
      validator: (value) => fullName.validator(value ?? '')?.text,
    );
  }
}

class RegisterEmailField extends HookConsumerWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(registerFormProvider.select((s) => s.email));
    final status = ref.watch(registerFormProvider.select((s) => s.status));
    final focusNode = useFocusNode();
    return MenoTextfield(
      key: const Key('register_form_email_input'),
      placeholder: 'example@gmail.com',
      label: 'Email address',
      prefixIcon: MIcons.mail,
      size: MenoSize.lg,
      required: false,
      enabled: status != MenoFormStatus.inProgress,
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      onChanged: ref.read(registerFormProvider.notifier).onEmailChanged,
      validator: (value) => email.validator(value ?? '')?.text,
    );
  }
}

class RegisterPasswordField extends HookConsumerWidget {
  const RegisterPasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final status = ref.watch(registerFormProvider.select((s) => s.status));
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
          enabled: status != MenoFormStatus.inProgress,
          focusNode: focusNode,
        ),
        const MenoSpacer.v(Insets.sm),
        const PasswordRulesWidgetTracker(),
      ],
    );
  }
}

class TermsOfServiceCheckbox extends HookConsumerWidget {
  const TermsOfServiceCheckbox({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final terms = ref.watch(registerFormProvider.select((s) => s.terms));
    final colors = MenoColorScheme.of(context);
    final focusNode = useFocusNode();

    return MenoCheckbox(
      value: terms.value ?? false,
      focusNode: focusNode,
      validator: (value) => terms.validator(value ?? false)?.text,
      onChanged: ref.read(registerFormProvider.notifier).onTermsChanged,
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MenoText.caption('By continuing you agree to our '),
          InkWell(
            onTap: () {},
            child: MenoText.micro('Terms of Service', color: colors.infoBase),
          ),
        ],
      ),
    );
  }
}

class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(registerFormProvider.select((s) => s.status));
    return MenoPrimaryButton(
      size: MenoSize.lg,
      isLoading: status == MenoFormStatus.inProgress,
      disabled: ref.watch(registerFormProvider).isNotValid,
      onPressed: () async {
        if (!Form.of(context).validate()) return;
        return ref.read(registerFormProvider.notifier).submit();
      },
      child: const Text('Create your account'),
    );
  }
}
