import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/session/session_notifier.dart';
import 'package:meno_flutter/src/features/broadcast/presentation/presentation.dart';

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
    final credential = ref.watch(sessionProvider.select((s) => s.credential));
    final user = credential.user;

    return MenoHeader.primary(
      label: 'Hello,',
      title: MenoText.subheading(user.fullName.getOrNull() ?? ''),
      actions: [
        MenoIconButton(MIcons.bell_04, onPressed: () {}),
        MenoAvatar(radius: Insets.lg, url: user.imageUrl),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
