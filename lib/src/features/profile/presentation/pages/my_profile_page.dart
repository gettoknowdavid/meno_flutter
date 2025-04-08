import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyProfilePage extends HookConsumerWidget {
  const MyProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider);

    return switch (profile) {
      AsyncError(:final error) => MyProfileContent(error: error),
      AsyncData(:final valueOrNull) => MyProfileContent(profile: valueOrNull),
      _ => MyProfileContent(isLoading: true, profile: Profile.fake()),
    };
  }
}

class MyProfileContent extends HookConsumerWidget {
  const MyProfileContent({
    this.profile,
    this.error,
    this.isLoading = false,
    super.key,
  });
  final Profile? profile;
  final Object? error;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 4);
    if (error != null) return ProfileErrorWidget(error: error!);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(myProfileProvider),
      child: ProfileContent(
        profile: profile!,
        titleWidget: _TitleWidget(isLoading: isLoading, profile: profile!),
        isLoading: isLoading,
        bottomWidget: ProfileTabBar(
          isLoading: isLoading,
          tabController: tabController,
        ),
        bodyWidget: ProfileTabBarView(tabController: tabController),
      ),
    );
  }
}

class _TitleWidget extends ConsumerWidget {
  const _TitleWidget({required this.profile, required this.isLoading});

  final Profile profile;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    return Skeletonizer(
      enabled: isLoading,
      child: ColoredBox(
        color: colors.backgroundDefault,
        child: MenoHeader.secondary(
          title: InkWell(
            onTap: () {
              ref.read(sessionProvider);
              const SwitchAccountModalRoute().push(context);
            },
            child: Row(
              children: [
                MenoText.heading3(
                  profile.fullName.value,
                  weight: MenoFontWeight.bold,
                ),
                const MenoSpacer.h(Insets.sm),
                const Icon(MIcons.chevron_down, size: 22),
              ],
            ),
          ),
          actions: [
            SizedBox.square(
              dimension: 24,
              child: IconButton(
                color: colors.buttonFill,
                icon: const Icon(MIcons.settings, size: 24),
                onPressed: () => const SettingsRoute().push(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
