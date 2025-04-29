import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart'
    show ParticipantRole;
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/domain/domain.dart' show ID;
import 'package:skeletonizer/skeletonizer.dart';

class ParticipantInfoModal extends HookConsumerWidget {
  const ParticipantInfoModal(this.id, {this.role, super.key});
  final String id;
  final ParticipantRole? role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    final idFromString = ID.fromString(id);
    final profileAsync = ref.watch(profileNotifierProvider(idFromString));

    final isLoading = profileAsync.isLoading;
    final profile = profileAsync.valueOrNull;

    final isHost = role == ParticipantRole.HOST || role == ParticipantRole.host;
    final isCohost =
        role == ParticipantRole.COHOST || role == ParticipantRole.cohost;

    if (profileAsync.hasError) {
      final error = profileAsync.error;
      return Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, bottom),
        constraints: const BoxConstraints(maxHeight: 300),
        child: MenoErrorWidget(switch (error) {
          ProfileException() => error.message,
          _ => error.toString(),
        }),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottom),
      child: Skeletonizer(
        enabled: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: MenoAvatar(
                radius: 36,
                url: profile?.imageUrl,
                isLoading: isLoading,
              ),
            ),
            const MenoSpacer.v(Insets.lg),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenoText.heading3(
                    profile?.fullName.getOrNull() ?? BoneMock.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isHost) ...[
                    const MenoSpacer.h(Insets.sm),
                    const MenoTag.disabled('HOST', size: MenoSize.md),
                  ],
                  if (isCohost) ...[
                    const MenoSpacer.h(Insets.sm),
                    const MenoTag.disabled('CO-HOST', size: MenoSize.md),
                  ],
                ],
              ),
            ),
            const MenoSpacer.v(Insets.xs),
            Center(
              child: MenoText.subheading(
                profile?.bio?.getOrNull() ?? BoneMock.paragraph,
                color: colors.labelDisabled,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                weight: MenoFontWeight.regular,
                textAlign: TextAlign.center,
              ),
            ),
            const MenoSpacer.v(Insets.lg),
            if (profile?.isSubscribedToUser ?? false) ...[
              Skeleton.unite(
                child: MenoSecondaryButton.icon(
                  label: const Text('Subscribed'),
                  onPressed: () {},
                  icon: const Icon(MIcons.user_check),
                  size: MenoSize.lg,
                ),
              ),
            ] else ...[
              Skeleton.unite(
                child: MenoPrimaryButton.icon(
                  label: const Text('Subscribe'),
                  onPressed: () {},
                  icon: const Icon(MIcons.user),
                  size: MenoSize.lg,
                ),
              ),
            ],
            const MenoSpacer.v(Insets.lg),
            MenoTertiaryButton(
              onPressed: () {},
              size: MenoSize.lg,
              style: TextButton.styleFrom(
                foregroundColor: isCohost ? colors.errorBase : null,
              ),
              child:
                  isCohost
                      ? const Text('Remove as co-host')
                      : const Text('Add as co-host'),
            ),
            const MenoSpacer.v(Insets.lg),
          ],
        ),
      ),
    );
  }
}
