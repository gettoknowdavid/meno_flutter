import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/session/session.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/routing/router.dart';

class SwicthAccountModal extends HookConsumerWidget {
  const SwicthAccountModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);

    final session = ref.watch(sessionProvider);

    ref.listen(sessionProvider.select((s) => s.credential), (previous, next) {
      if (previous?.user.id != next.user.id) const MyProfileRoute().go(context);
    });

    final accounts = session.accounts;
    final credential = session.credential;

    return MenoModal(
      title: 'Switch account',
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (session.accounts.length > 1) ...[
              ...accounts.entries.map((entry) {
                final user = entry.value.user;
                final selected = credential.user.id.getOrNull() == entry.key;

                return MenoRadioListTile<UserCredential>(
                  key: ValueKey(entry.key),
                  headline: user.fullName.value,
                  value: entry.value,
                  groupValue: credential,
                  selected: selected,
                  leading: MenoAvatar(
                    url: user.imageUrl,
                    menoRadius: MenoAvatarRadius.md,
                  ),
                  onChanged: (cred) {
                    if (selected) return;
                    ref.read(sessionProvider.notifier).switchAccount(cred!);
                  },
                );
              }),
              MenoListTile.small(
                headline: 'Add account',
                leading: const Icon(MIcons.plus_circle, size: 24),
                headlineColor: colors.buttonLabelSecondary,
              ),
              MenoListTile.small(
                headline: 'Logout',
                headlineColor: colors.errorBase,
                iconColor: colors.errorBase,
                leading: const Icon(MIcons.log_out, size: 24),
              ),
            ] else ...[
              MenoPrimaryButton(
                size: MenoSize.lg,
                child: const Text('Log in to existing account'),
                onPressed: () {
                  ref.read(sessionProvider.notifier).logout();
                  const LoginRoute().go(context);
                },
              ),
              const MenoSpacer.v(4),
              MenoTertiaryButton(
                size: MenoSize.lg,
                child: const Text('Create new account'),
                onPressed: () {
                  ref.read(sessionProvider.notifier).logout();
                  const RegisterRoute().go(context);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
