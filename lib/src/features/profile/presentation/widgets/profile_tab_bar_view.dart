import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class ProfileTabBarView extends StatelessWidget {
  const ProfileTabBarView({required this.tabController, super.key});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: TabBarView(
        controller: tabController,
        children: [
          Container(
            padding: const EdgeInsets.all(Insets.xxlg),
            child: const MenoText.body('Recent Broadcasts'),
          ),
          Container(
            padding: const EdgeInsets.all(Insets.xxlg),
            child: const MenoText.body('All Broadcasts'),
          ),
          Container(
            padding: const EdgeInsets.all(Insets.xxlg),
            child: const MenoText.body('Favorites'),
          ),
          Container(
            padding: const EdgeInsets.all(Insets.xxlg),
            child: const MenoText.body('Recordings'),
          ),
        ],
      ),
    );
  }
}
