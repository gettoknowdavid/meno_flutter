import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class MenoSection extends StatelessWidget {
  const MenoSection({
    required this.title,
    required this.child,
    super.key,
    this.emoji,
    this.onSeeAll,
    this.sectionContentHeight = 224,
  });

  final String title;
  final Widget child;
  final Widget? emoji;
  final VoidCallback? onSeeAll;

  /// The height of the section. This is used to limit the height of the
  /// section. This includes the bottom padding to be added to the list view.
  ///
  /// The default height is 176.
  ///
  /// The default bottom padding is 48.
  ///
  /// The default total value is 224.
  ///
  final double sectionContentHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenoHeader.secondary(
          title: Row(
            spacing: Insets.sm,
            children: [
              MenoText.heading3(title),
              SizedBox.square(dimension: 24, child: emoji),
            ],
          ),
          actions: [
            if (onSeeAll != null)
              MenoTertiaryButton(
                onPressed: onSeeAll,
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const MenoText.caption('See all'),
              ),
          ],
          size: MenoSize.sm,
        ),
        const MenoSpacer.v(24),
        LimitedBox(maxHeight: sectionContentHeight, child: child),
      ],
    );
  }
}
