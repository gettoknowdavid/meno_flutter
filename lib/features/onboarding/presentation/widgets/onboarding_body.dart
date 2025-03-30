import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/onboarding/data/data_sources/onboarding_items.dart';
import 'package:meno_flutter/features/onboarding/presentation/widgets/widgets.dart';

class OnboardingBody extends HookWidget {
  const OnboardingBody({super.key});
  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);
    final items = onboardingItems;
    final itemCount = items.length;

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        currentIndex.value = (currentIndex.value + 1) % itemCount;
      });

      return timer.cancel;
    }, [currentIndex]);

    void onHorizontalDragEnd(DragEndDetails details) {
      if (details.primaryVelocity == null) return;

      if (details.primaryVelocity! < 0) {
        currentIndex.value = (currentIndex.value + 1) % itemCount;
      } else {
        currentIndex.value = (currentIndex.value - 1 + itemCount) % itemCount;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onHorizontalDragEnd: onHorizontalDragEnd,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: OnboardingWidget(
              key: ValueKey(currentIndex.value),
              onboarding: items[currentIndex.value],
            ),
          ),
        ),
        const MenoSpacer.v(48),
        LimitedBox(
          maxHeight: 8,
          child: OnboardingIndicators(
            key: const Key('Onboarding_indicator_Key'),
            currentIndex: currentIndex.value,
            itemCount: itemCount,
          ),
        ),
      ],
    );
  }
}
