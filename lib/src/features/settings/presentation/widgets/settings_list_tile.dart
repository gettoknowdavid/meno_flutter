import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    required this.title,
    super.key,
    this.leading,
    this.trailing,
    this.onTap,
    this.titleColor,
    this.iconColor,
    this.enabled = true,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? iconColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);

    final effectiveTitleColor = resolveDisabled(
      titleColor ?? colors.labelPrimary,
      colors.labelPlaceholder,
    );

    final effectiveIconColor = resolveDisabledWithOpacity(
      iconColor ?? colors.brandPrimary,
    );

    return ListTile(
      title: MenoText.caption(title, color: effectiveTitleColor),
      horizontalTitleGap: Insets.sm,
      onTap: enabled ? onTap : null,
      minTileHeight: 56,
      trailing:
          trailing ??
          Icon(
            MIcons.chevron_right,
            size: 20,
            color: resolveDisabledWithOpacity(colors.labelPlaceholder),
          ),
      leading:
          leading == null
              ? null
              : IconTheme(
                data: IconThemeData(color: effectiveIconColor, size: 20),
                child: leading!,
              ),
    );
  }

  Color? resolveDisabled(Color? main, Color? disabled) {
    return enabled ? main : disabled;
  }

  Color? resolveDisabledWithOpacity(Color? color) {
    return enabled ? color : color?.withValues(alpha: 0.5);
  }
}
