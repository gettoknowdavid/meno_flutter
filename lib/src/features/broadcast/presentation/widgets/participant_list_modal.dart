import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/constants/constants.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';

class ParticipantListModal extends HookConsumerWidget {
  const ParticipantListModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenoModal(
      title: 'Listening (23)',
      padding: EdgeInsets.zero,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: MenoSearchBar(hintText: 'Search for a listener...'),
              ),
              const MenoSpacer.v(Insets.lg),
              ParticipantListWidget(participants: fakeParticipants),
            ],
          ),
        );
      },
    );
  }
}

extension ParticipantListModalX on BuildContext {
  Future<void> showParticipantListModal() {
    final maxHeight = MediaQuery.sizeOf(this).height * 0.85;
    return showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      useRootNavigator: true,
      constraints: BoxConstraints(maxHeight: maxHeight),
      builder: (context) => const ParticipantListModal(),
    );
  }
}
