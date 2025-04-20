import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';

class LiveSessionLoadingOverlay extends ConsumerWidget {
  const LiveSessionLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.8),
      child: const SizedBox.expand(
        child: Center(child: MenoLoadingIndicator.lg()),
      ),
    );
  }
}
