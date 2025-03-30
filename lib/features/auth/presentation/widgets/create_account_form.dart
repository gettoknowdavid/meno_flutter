import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MenoTextfield(
          placeholder: 'John Doe',
          label: 'Full name',
          prefixIcon: MIcons.user,
          size: MenoSize.lg,
          required: false,
        ),
        const MenoSpacer.v(24),
        MenoTextfield(
          placeholder: 'example@gmail.com',
          label: 'Email address',
          prefixIcon: MIcons.mail,
          size: MenoSize.lg,
          required: false,
        ),
        const MenoSpacer.v(24),
        MenoTextfield(
          placeholder: 'Must be at least 8 characters',
          label: 'Password',
          prefixIcon: MIcons.key,
          size: MenoSize.lg,
          required: false,
        ),
        const MenoSpacer.v(16),
        const MenoSpacer.v(32),
        MenoPrimaryButton(
          child: const Text('Create your account'),
          onPressed: () {},
        ),
      ],
    );
  }
}
