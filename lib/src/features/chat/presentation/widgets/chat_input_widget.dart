import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';

class ChatInputWidget extends HookConsumerWidget {
  const ChatInputWidget({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          const Expanded(child: _ChatTextField()),
          const MenoSpacer.h(Insets.lg),
          const _ReactionsButton(key: Key('ChatReactionsButton')),
          const MenoSpacer.h(Insets.sm),
          _SendButton(
            key: const Key('ChatSendButton'),
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}

class _ChatTextField extends HookConsumerWidget {
  const _ChatTextField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final notifier = ref.read(chatFormNotifierProvider.notifier);
    final initialChat = ref.watch(
      chatFormNotifierProvider.select((s) => s.initialChat),
    );

    return TextFormField(
      style: MenoTextTheme.of(context).captionRegular,
      focusNode: focusNode,
      onChanged: notifier.contentChanged,
      initialValue: initialChat?.content.getOrNull(),
      maxLines: 5,
      minLines: 1,
      maxLength: 244,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        hintText: 'Type your comment here...',
        counter: SizedBox(),
        contentPadding: EdgeInsets.symmetric(
          vertical: Insets.sm,
          horizontal: Insets.md,
        ),
      ),
    );
  }
}

class _ReactionsButton extends HookConsumerWidget {
  const _ReactionsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    return MenoIconButton.filled(
      Icons.face_outlined,
      fillColor: colors.componentSecondary,
      color: colors.labelPrimary,
      fixedSize: const Size.square(40),
      iconSize: 20,
      onPressed: () {},
    );
  }
}

class _SendButton extends HookConsumerWidget {
  const _SendButton({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);

    final input = ref.watch(chatFormNotifierProvider);
    final chats = ref.watch(chatListProvider);
    
    return MenoIconButton.filled(
      MIcons.send,
      fillColor: colors.brandPrimary,
      color: colors.buttonLabelPrimary,
      fixedSize: const Size.square(40),
      iconSize: 20,
      onPressed: () {},
    );
  }
}
