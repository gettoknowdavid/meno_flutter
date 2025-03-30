import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class OnboardingIndicators extends StatelessWidget {
  const OnboardingIndicators({
    required this.currentIndex,
    required this.itemCount,
    super.key,
  });

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (context, index) => const MenoSpacer.h(4),
      itemBuilder: (context, index) {
        final isCurrent = currentIndex == index;
        final diameter = isCurrent ? 8.0 : 4.0;
        return Container(
          height: diameter,
          width: diameter,
          decoration: BoxDecoration(
            color: isCurrent ? colors.buttonFill : colors.componentSecondary,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
