import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_flutter/src/features/profile/profile.dart'
    show ProfileContent, myProfileProvider;

class MyProfilePage extends HookConsumerWidget {
  const MyProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider);

    return switch (profile) {
      AsyncError(:final error) => ProfileContent(error: error),
      AsyncData(:final valueOrNull) => ProfileContent(profile: valueOrNull),
      _ => const ProfileContent(isLoading: true),
    };
  }
}
