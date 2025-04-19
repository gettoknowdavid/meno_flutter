import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/session/session_notifier.dart';
import 'package:meno_flutter/src/routing/routing.dart';

class CurrentUserAvatar extends ConsumerWidget {
  const CurrentUserAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credential = ref.watch(sessionProvider);
    return switch (credential) {
      AsyncData(:final value) => MenoAvatar(
        radius: Insets.lg,
        url: value?.user.imageUrl,
        onTap: () => const MyProfileRoute().go(context),
      ),
      AsyncError() => const MenoAvatar(radius: Insets.lg),
      _ => const MenoAvatar(radius: Insets.lg, isLoading: true),
    };
  }
}
