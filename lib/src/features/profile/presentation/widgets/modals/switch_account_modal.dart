import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class SwicthAccountModal extends StatelessWidget {
  const SwicthAccountModal({super.key});

  @override
  Widget build(BuildContext context) {
    return MenoModal(
      title: 'Switch account',
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenoPrimaryButton(
              size: MenoSize.lg,
              child: const Text('Log in to existing account'),
              onPressed: () {},
            ),
            const MenoSpacer.v(4),
            MenoTertiaryButton(
              size: MenoSize.lg,
              child: const Text('Create new account'),
              onPressed: () {},
            ),
            // MenoListTile.small(
            //   headline: 'Add account',
            //   leading: const Icon(MIcons.plus_circle, size: 24),
            //   headlineColor: colors.buttonLabelSecondary,
            // ),
            // MenoListTile.small(
            //   headline: 'Logout',
            //   headlineColor: colors.errorBase,
            //   iconColor: colors.errorBase,
            //   leading: const Icon(MIcons.log_out, size: 24),
            // ),
          ],
        );
      },
    );
  }
}
