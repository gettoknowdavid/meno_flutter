import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class OnboardingDescription extends StatelessWidget {
  const OnboardingDescription({required this.desc, super.key});
  final String desc;

  @override
  Widget build(BuildContext context) {
    final textTheme = MenoTextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Text(
        desc,
        style: textTheme.bodyRegular,
        textAlign: TextAlign.center,
      ),
    );
  }
}
