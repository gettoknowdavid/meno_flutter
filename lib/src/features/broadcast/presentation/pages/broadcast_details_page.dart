import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class BroadcastDetailsPage extends ConsumerWidget {
  const BroadcastDetailsPage({required this.id, super.key});
  final ID id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MenoHeader.secondary(title: const Text('Broadcast Details')),
    );
  }
}
