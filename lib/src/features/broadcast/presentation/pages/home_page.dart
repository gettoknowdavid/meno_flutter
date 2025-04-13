import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/session/session_notifier.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({this.title = 'Home', super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: _AppBar(key: Key('HomAppBar')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MenoSpacer.v(32),
            LiveForYouSection(),
            NowLiveSection(),
            RecentlyLiveSection(),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credential = ref.watch(sessionProvider);

    return MenoHeader.primary(
      label: 'Hello,',
      title: switch (credential) {
        AsyncData(:final value) => MenoText.subheading(
          value?.user.fullName.getOrNull() ?? '',
        ),
        AsyncError() => const MenoText.subheading('Error loading user data'),
        _ => const Skeletonizer(child: MenoText.subheading('Loading...')),
      },
      actions: [
        MenoIconButton(MIcons.bell_04, onPressed: () {}),
        switch (credential) {
          AsyncData(:final value) => MenoAvatar(
            radius: Insets.lg,
            url: value?.user.imageUrl,
            onTap: () => const MyProfileRoute().go(context),
          ),
          AsyncError() => const MenoAvatar(radius: Insets.lg),
          _ => const MenoAvatar(radius: Insets.lg, isLoading: true),
        },
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
