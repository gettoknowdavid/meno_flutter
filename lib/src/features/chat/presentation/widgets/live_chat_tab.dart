import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';

class LiveChatTab extends HookConsumerWidget {
  const LiveChatTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ChatListWidget(scrollController: scrollController),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ChatWelcomeWidget(),
              //const EditingMessageWidget(),
              ChatInputWidget(scrollController: scrollController),
            ],
          ),
        ),
      ],
    );
  }
}
