import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MenoOutlinedButton.icon(
      label: const Text('Create your account'),
      size: MenoSize.lg,
      icon: SizedBox.square(
        dimension: 18,
        child: MenoAssets.images.brandLogos.google.svg(),
      ),
      onPressed: () {},
    );
  }
}
