import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    required this.profile,
    required this.isBioCollapsed,
    this.isLoading = false,
    super.key,
  });

  final Profile profile;
  final ValueNotifier<bool> isBioCollapsed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MenoAvatar(url: profile.imageUrl, isLoading: isLoading),
                const MenoSpacer.h(24),
                Expanded(child: ProfileStatsWidget(stats: profile.stats)),
              ],
            ),
            const MenoSpacer.v(Insets.lg),
            const AccountStatusWidget(),
            const MenoSpacer.v(Insets.lg),
            ProfileBioWidget(bio: profile.bio, isCollapsed: isBioCollapsed),
            const MenoSpacer.v(Insets.lg),
            const ProfilePageButtons(),
          ],
        ),
      ),
    );
  }
}
