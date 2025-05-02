//
// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/routing/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ParticipantListWidget extends ConsumerWidget {
  const ParticipantListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participants = ref.watch(participantsProvider);

    final liveBroadcastStatus = ref.watch(
      liveBroadcastProvider.select((s) => s.status),
    );

    final isLiveBroadcastLoading = [
      MenoLiveStatus.connecting,
      MenoLiveStatus.inProgress,
    ].contains(liveBroadcastStatus);

    final isLoading = isLiveBroadcastLoading || participants.isLoading;

    return switch (participants) {
      AsyncData(:final value) => _ListWidget(participants: value),
      AsyncError(:final error) => MenoErrorWidget(
        (error as BroadcastException).message,
      ),
      _ => _ListWidget(participants: fakeParticipants, isLoading: isLoading),
    };
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    required this.participants,
    this.isLoading = false,
    this.padding,
  });

  final List<Participant?> participants;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (participants.isEmpty) {
      return const MenoEmptyWidget(
        description: 'No listerners on this broadcast',
      );
    }

    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: Insets.lg),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: Insets.sm,
          mainAxisSpacing: Insets.lg,
          childAspectRatio: 80 / 88,
        ),
        itemCount: participants.length,
        itemBuilder: (context, index) {
          final participant = participants[index]!;
          return ParticipantWidget(
            key: ValueKey(participant.id),
            participant: participant,
            onTap: () {
              final id = participant.id.getOrCrash();
              final role = participant.role;
              ParticipantInfoRoute(id, role: role).push(context);
            },
          );
        },
      ),
    );
  }
}
