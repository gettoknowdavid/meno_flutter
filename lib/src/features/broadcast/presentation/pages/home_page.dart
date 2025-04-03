import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/session/session.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MenoTopBar.secondary(title: 'Home'),
      body: Center(
        child: MenoPrimaryButton(
          size: MenoSize.lg,
          onPressed: ref.read(sessionProvider.notifier).logout,
          child: const Text('Log out'),
        ),
      ),
    );
  }
}
