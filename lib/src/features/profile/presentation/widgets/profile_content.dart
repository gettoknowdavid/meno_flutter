import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileContent extends HookConsumerWidget {
  const ProfileContent({
    this.profile,
    this.titleWidget,
    this.error,
    this.isLoading = false,
    super.key,
  });

  final Profile? profile;
  final Widget? titleWidget;
  final Object? error;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 4);

    if (error != null) return ProfileErrorWidget(error: error!);

    final effectiveProfile = profile ?? Profile.fake();

    final isBioCollapsed = useState(true);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(myProfileProvider.future),
      child: NestedScrollView(
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
              title:
                  titleWidget ??
                  MyProfileNameWidget(
                    isLoading: isLoading,
                    profile: effectiveProfile,
                  ),
              flexibleSpace: SafeArea(
                child: FlexibleSpaceBar(
                  background: ProfileDetailsWidget(
                    profile: effectiveProfile,
                    isBioCollapsed: isBioCollapsed,
                    isLoading: isLoading,
                  ),
                ),
              ),
              bottom: ProfileTabBar(
                isLoading: isLoading,
                tabController: tabController,
              ),
            ),
          ];
        },
        body: CustomScrollView(
          primary: false,
          slivers: [
            SliverFillRemaining(
              child: ProfileTabBarView(tabController: tabController),
            ),
          ],
        ),
      ),
    );
  }
}



class MyProfileNameWidget extends StatelessWidget {
  const MyProfileNameWidget({
    required this.profile,
    required this.isLoading,
    super.key,
  });

  final Profile profile;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Skeletonizer(
      enabled: isLoading,
      child: ColoredBox(
        color: colors.backgroundDefault,
        child: MenoHeader.secondary(
          title: Row(
            children: [
              MenoText.heading3(
                profile.fullName.value,
                weight: MenoFontWeight.bold,
              ),
              const MenoSpacer.h(Insets.sm),
              const Icon(MIcons.chevron_down, size: 22),
            ],
          ),
          actions: [
            SizedBox.square(
              dimension: 24,
              child: IconButton(
                onPressed: () {},
                color: colors.buttonFill,
                icon: const Icon(MIcons.settings, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
