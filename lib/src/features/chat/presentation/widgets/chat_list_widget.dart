import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Insets.lg),
      controller: scrollController,
      reverse: true,
      shrinkWrap: true,
      separatorBuilder: (context, _) => const MenoSpacer.v(Insets.lg),
      itemCount: fakeChats.length,
      itemBuilder: (context, index) => ChatBubble(fakeChats[index]),
    );
  }
}
