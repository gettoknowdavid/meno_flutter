import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/routing/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePageButtons extends ConsumerWidget {
  const ProfilePageButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 32,
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: MenoPrimaryButton.icon(
              icon: const Icon(MIcons.edit_05),
              label: const Text('Edit profile'),
              onPressed: () {
                ref.read(editProfileFormProvider);
                const EditProfileRoute().push(context);
              },
            ),
          ),
          Expanded(
            child: Skeleton.unite(
              child: MenoOutlinedButton.icon(
                icon: const Icon(MIcons.share),
                label: const Text('Share profile'),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
