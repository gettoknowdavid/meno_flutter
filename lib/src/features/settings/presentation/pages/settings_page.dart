import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenoTopBar.primary(title: 'Settings'),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(Insets.lg),
        child: Column(
          spacing: Insets.xxlg,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _GeneralSettings(),
            _AccountAndSecuritySettings(),
            _OtherSettings(),
            MenoSpacer.v(Insets.xxlg),
          ],
        ),
      ),
    );
  }
}

class _OtherSettings extends StatelessWidget {
  const _OtherSettings();

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return SettingsListSectionWidget(
      title: 'Other',
      children: [
        SettingsListTile(
          title: 'About Meno',
          leading: const Icon(MIcons.users),
          onTap: () {},
        ),
        SettingsListTile(
          title: 'FAQs',
          leading: const Icon(MIcons.help_circle),
          onTap: () {},
        ),
        SettingsListTile(
          title: 'Share with friends & family',
          leading: const Icon(MIcons.share),
          onTap: () {},
        ),
        SettingsListTile(
          title: 'Logout',
          leading: const Icon(MIcons.log_out),
          onTap: () {},
        ),
        SettingsListTile(
          title: 'Delete Account',
          leading: const Icon(MIcons.trash),
          onTap: () {},
          titleColor: colors.errorBase,
          iconColor: colors.errorBase,
        ),
      ],
    );
  }
}

class _AccountAndSecuritySettings extends StatelessWidget {
  const _AccountAndSecuritySettings();

  @override
  Widget build(BuildContext context) {
    return SettingsListSectionWidget(
      title: 'Account & Security',
      children: [
        SettingsListTile(
          title: 'Subscriptions',
          leading: const Icon(MIcons.layers_three_01),
          onTap: () {},
          enabled: false,
        ),
        SettingsListTile(
          title: 'Security',
          leading: const Icon(MIcons.shield),
          onTap: () {},
        ),
      ],
    );
  }
}

class _GeneralSettings extends StatelessWidget {
  const _GeneralSettings();

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return SettingsListSectionWidget(
      title: 'General',
      children: [
        SettingsListTile(
          title: 'Language',
          leading: const Icon(MIcons.translate_02),
          onTap: () {},
          trailing: MenoTertiaryButton.icon(
            label: const Text('English'),
            icon: Icon(
              MIcons.chevron_right,
              size: 18,
              color: colors.labelPlaceholder,
            ),
            iconAlignment: IconAlignment.end,
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: colors.labelPlaceholder,
            ),
          ),
        ),
        SettingsListTile(
          title: 'Notifications',
          leading: const Icon(MIcons.bell),
          onTap: () {},
        ),
        SettingsListTile(
          title: 'Dark Mode',
          leading: const Icon(MIcons.moon_01),
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
        SettingsListTile(
          title: 'Location',
          leading: const Icon(MIcons.marker_pin_01),
          trailing: Switch(value: false, onChanged: (value) {}),
        ),
      ],
    );
  }
}
