import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_design_system/meno_design_system.dart';

class SettingsListSectionWidget extends HookWidget {
  const SettingsListSectionWidget({
    required this.children,
    super.key,
    this.title,
    this.titleContainerHeight,
  });

  final String? title;
  final List<Widget> children;
  final double? titleContainerHeight;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);

    final childrenWithDividers = useMemoized(() {
      final result = <Widget>[];

      for (var i = 0; i < children.length; i++) {
        result.add(children[i]);
        if (i != children.length - 1) result.add(const Divider());
      }

      return result;
    }, [children]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          SizedBox(
            height: titleContainerHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MenoText.caption(title!, color: colors.labelDisabled),
                const MenoSpacer.v(Insets.sm),
              ],
            ),
          ),
        Material(
          color: colors.sectionPrimary,
          clipBehavior: Clip.hardEdge,
          borderRadius: MenoBorderRadius.lg,
          child: Column(children: childrenWithDividers),
        ),
      ],
    );
  }
}
