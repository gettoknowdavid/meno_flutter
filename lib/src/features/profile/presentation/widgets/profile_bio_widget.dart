import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:readmore/readmore.dart';

class ProfileBioWidget extends StatelessWidget {
  const ProfileBioWidget({
    required this.bio,
    super.key,
    this.isLoading = false,
    this.isCollapsed,
  });

  final Bio? bio;
  final bool isLoading;
  final ValueNotifier<bool>? isCollapsed;

  @override
  Widget build(BuildContext context) {
    final textTheme = MenoTextTheme.of(context);
    final actionColor = MenoColorScheme.of(context).labelPlaceholder;
    final actionStyle = textTheme.captionMedium.copyWith(color: actionColor);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: (isCollapsed?.value ?? false) ? 54 : 100,
        constraints: const BoxConstraints(maxHeight: 100, minHeight: 54),
        child: ReadMoreText(
          bio?.value ?? 'No bio',
          style: textTheme.captionRegular,
          isCollapsed: isCollapsed,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimExpandedText: '\nless',
          trimCollapsedText: '\nmore',
          moreStyle: actionStyle,
          lessStyle: actionStyle,
        ),
      ),
    );
  }
}
