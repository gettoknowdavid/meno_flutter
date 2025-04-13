import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/profile/profile.dart' show Profile;
import 'package:meno_flutter/src/routing/routing.dart';

class CohostWidget extends StatelessWidget {
  const CohostWidget({required this.user, super.key, this.onRemove});
  final Profile? user;
  final ValueChanged<Profile?>? onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    final hasUser = user != null;

    return InkWell(
      onTap: hasUser ? null : () => const AddCohostRoute().push(context),
      child: Stack(
        children: [
          SizedBox(
            height: 72,
            width: 80,
            child: Column(
              children: [
                MenoAvatar(radius: 24, url: user?.imageUrl),
                const MenoSpacer.v(Insets.sm),
                MenoText.micro(
                  user?.fullName.getOrCrash() ?? 'Add Co-host',
                  color: colors.labelHelp,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (hasUser)
            Positioned(
              right: 10,
              child: SizedBox.square(
                dimension: 18,
                child: MenoIconButton.filled(
                  MIcons.x_close,
                  iconSize: 16,
                  fillColor: colors.errorBase,
                  color: colors.staticWhite,
                  onPressed: () => onRemove?.call(user),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CoHostListWidget extends ConsumerWidget {
  const CoHostListWidget({required this.cohosts, super.key, this.onRemove});

  final List<Profile> cohosts;
  final ValueChanged<Profile?>? onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: cohosts.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      primary: false,
      separatorBuilder: (context, index) => const MenoSpacer.h(Insets.lg),
      itemBuilder: (_, i) => CohostWidget(user: cohosts[i], onRemove: onRemove),
    );
  }
}
