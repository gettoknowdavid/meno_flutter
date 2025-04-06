import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePageButtons extends StatelessWidget {
  const ProfilePageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: MenoPrimaryButton.icon(
              icon: const Icon(MIcons.edit_05),
              label: const Text('Edit profile'),
              onPressed: () {},
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
