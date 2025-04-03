import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';

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


class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({required this.onboarding, super.key});
  final Onboarding onboarding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox.square(
          dimension: 240,
          child: Image.asset(onboarding.imagePath),
        ),
        const MenoSpacer.v(24),
        OnboardingTitle(title: onboarding.title),
        const MenoSpacer.v(16),
        OnboardingDescription(desc: onboarding.desc),
      ],
    );
  }
}

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
