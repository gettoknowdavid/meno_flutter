import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class OnboardingTitle extends StatelessWidget {
  const 
  OnboardingTitle({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    final textTheme = MenoTextTheme.of(context);

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            title,
            style: textTheme.heading1Bold,
            textAlign: TextAlign.center,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -4,
            height: 8,
            child: ColoredBox(color: colors.brandSecondaryLighter),
          ),
        ],
      ),
    );
  }
}
