import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileTabBar({
    required this.isLoading,
    required this.tabController,
    super.key,
  });

  final bool isLoading;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Skeletonizer(
        enabled: isLoading,
        child: MenoTabBar.normal(
          controller: tabController,
          tabs: const [
            MenoTab(text: 'Recent broadcasts'),
            MenoTab(text: 'All broadcasts'),
            MenoTab(text: 'Favorites'),
            MenoTab(text: 'Recordings'),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
