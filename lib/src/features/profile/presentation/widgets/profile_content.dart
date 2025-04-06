import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';

class ProfileContent extends HookWidget {
  const ProfileContent({
    required this.profile,
    required this.titleWidget,
    required this.bottomWidget,
    required this.bodyWidget,
    this.isLoading = false,
    super.key,
  });

  final Profile profile;
  final Widget titleWidget;
  final bool isLoading;
  final PreferredSizeWidget bottomWidget;
  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    final isBioCollapsed = useState(true);
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: isBioCollapsed.value ? 360 : 390,
            pinned: true,
            scrolledUnderElevation: 0,
            elevation: 0,
            clipBehavior: Clip.none,
            stretch: true,
            titleSpacing: 4,
            toolbarHeight: 32,
            title: titleWidget,
            flexibleSpace: SafeArea(
              child: FlexibleSpaceBar(
                background: ProfileDetailsWidget(
                  profile: profile,
                  isBioCollapsed: isBioCollapsed,
                  isLoading: isLoading,
                ),
              ),
            ),
            bottom: bottomWidget,
          ),
        ];
      },
      body: CustomScrollView(
        primary: false,
        slivers: [SliverFillRemaining(child: bodyWidget)],
      ),
    );
  }
}
