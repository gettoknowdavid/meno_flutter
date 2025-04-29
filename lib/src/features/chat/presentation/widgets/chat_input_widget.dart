import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';

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

class _ChatTextField extends HookWidget {
  const _ChatTextField();

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController(text: '');

    return MenoTextfield(
      focusNode: focusNode,
      controller: controller,
      keyboardType: TextInputType.multiline,
      placeholder: 'Type your comment here...',
      size: MenoSize.lg,
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
