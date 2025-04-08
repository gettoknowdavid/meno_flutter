import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_design_system/meno_design_system.dart';

class ResetPasswordFormWidget extends HookWidget {
  const ResetPasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          MenoTextfield(
            key: const Key('reset_password_form_email_input'),
            placeholder: 'example@gmail.com',
            label: 'Email address',
            prefixIcon: MIcons.mail,
            size: MenoSize.lg,
            keyboardType: TextInputType.emailAddress,
          ),
          const MenoSpacer.v(20),
          MenoPrimaryButton(
            size: MenoSize.lg,
            onPressed: () {},
            child: const Text('Send instructions'),
          ),
        ],
      ),
    );
  }
}
