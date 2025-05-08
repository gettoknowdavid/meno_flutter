import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/chat/chat.dart' show Chat, ChatStatus;
import 'package:meno_flutter/src/shared/shared.dart' show MenoDot;

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.chat, {super.key});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final effectiveImageUrl = chat.imageUrl ?? chat.sender?.imageUrl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: Insets.sm,
        children: [
          LimitedBox(
            maxHeight: 24,
            maxWidth: 24,
            child: MenoAvatar(radius: 12, url: effectiveImageUrl),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Insets.xs,
              children: [
                _SenderDetails(key: const Key('ChatSenderDetails'), chat: chat),
                _ChatContent(key: const Key('ChatContent'), chat: chat),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SenderDetails extends ConsumerWidget {
  const _SenderDetails({required this.chat, super.key});
  final Chat chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);

    final name = (chat.fullName ?? chat.sender?.fullName)!.getOrCrash();

    final time = GetTimeAgo.parse(chat.updatedAt ?? chat.createdAt);
    final formattedTimestamp = chat.updatedAt != null ? 'Edited $time' : time;

    final user = ref.watch(sessionProvider).value?.user;
    final isHost = (chat.senderId ?? chat.sender?.id) == user?.id;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: Insets.xs,
      children: [
        InkWell(
          onTap: () {},
          child: MenoText.micro(
            name,
            color: colors.labelDisabled,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const MenoDot(),
        if (isHost) ...[
          MenoText.micro(
            'Host',
            color: colors.labelDisabled,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const MenoDot(),
        ],
        if (chat.status == ChatStatus.sent)
          MenoText.micro(
            formattedTimestamp,
            color: colors.labelDisabled,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        else
          MenoText.micro(
            'Pending delivery',
            color: colors.errorBase,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}

class _ChatContent extends StatelessWidget {
  const _ChatContent({required this.chat, super.key});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: ShapeDecoration(
        color: colors.brandPrimaryLighter,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      child: MenoText.caption(
        chat.content.getOrCrash(),
        weight: MenoFontWeight.regular,
      ),
    );
  }
}
