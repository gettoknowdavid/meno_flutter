import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChatListWidget extends ConsumerWidget {
  const ChatListWidget({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatListProvider);
    return switch (chats) {
      AsyncError(:final error) => MenoErrorWidget(
        (error as ChatException).message,
      ),
      AsyncData(:final value) => _ListWidget(
        key: const Key('ChatListWidget'),
        chats: value,
        scrollController: scrollController,
      ),
      _ => _ListWidget(
        key: const Key('ChatListWidgetSkeleton'),
        chats: fakeChats,
        isLoading: true,
        scrollController: scrollController,
      ),
    };
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    required this.chats,
    this.scrollController,
    this.isLoading = false,
    super.key,
  });

  final List<Chat?> chats;
  final ScrollController? scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) return const SizedBox.shrink();
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: Insets.lg),
        controller: scrollController,
        reverse: true,
        shrinkWrap: true,
        separatorBuilder: (context, _) => const MenoSpacer.v(Insets.lg),
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatBubble(chats[index]!),
      ),
    );
  }
}
