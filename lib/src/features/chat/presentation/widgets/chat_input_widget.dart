import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart'
    show liveBroadcastProvider;
import 'package:meno_flutter/src/features/chat/chat.dart';

class ChatInputWidget extends HookConsumerWidget {
  const ChatInputWidget({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasContent = ref.watch(
      chatFormProvider.select((s) => s.content?.isValid ?? false),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Row(
        children: [
          const Expanded(child: _ChatTextField()),
          const MenoSpacer.h(Insets.lg),
          const _ReactionsButton(key: Key('ChatReactionsButton')),
          if (hasContent) ...[
            const MenoSpacer.h(Insets.sm),
            _SendButton(
              key: const Key('ChatSendButton'),
              scrollController: scrollController,
            ),
          ],
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
    final notifier = ref.read(chatFormProvider.notifier);
    final formState = ref.watch(chatFormProvider);
    final controller = useTextEditingController(
      text: formState.content?.getOrNull(),
    );

    // Set initial text when editing starts
    ref.listen(chatFormProvider.select((s) => s.initialChat), (_, initialChat) {
      if (initialChat != null && formState.isEditing) {
        final newText = initialChat.content.getOrNull() ?? '';
        controller.text = newText;
        // Move cursor to end
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: newText.length),
        );
        focusNode.requestFocus();
      } else if (!formState.isEditing && initialChat == null) {
        // Clear text when stopping editing
        controller.clear();
      }
    });

    // Listen to notifier changes to update controller
    ref.listen(chatFormProvider.select((s) => s.content), (_, content) {
      // Only update if controller text differs from state
      final contentString = content?.getOrNull() ?? '';
      if (controller.text != contentString) {
        // Preserve the cursor position
        final selection = controller.selection;
        controller.text = contentString;

        // Try to restore cursor position
        final textLength = controller.text.length;
        if (selection.isValid && selection.baseOffset <= textLength) {
          controller.selection = selection;
        } else {
          // Move cursor to end if restoration isn't possible
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }
      }
    });

    // Update notifier state when editing finishes or perhaps debounced
    // Simple approach: Update on change (like original) but via controller
    useEffect(() {
      void listener() {
        final content = ref.read(chatFormProvider).content;
        if (content?.getOrNull() != controller.text) {
          notifier.contentChanged(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller, notifier]);

    return MenoTextbox(
      focusNode: focusNode,
      onChanged: notifier.contentChanged,
      controller: controller,
      maxLines: 5,
      minLines: 1,
      placeholder: 'Type your comment here...',
      keyboardType: TextInputType.multiline,
      showCounter: false,
      contentPadding: const EdgeInsets.symmetric(
        vertical: Insets.lg,
        horizontal: Insets.md,
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

    final input = ref.watch(chatFormProvider);
    final content = input.content;

    return MenoIconButton.filled(
      MIcons.send,
      fillColor: colors.brandPrimary,
      color: colors.buttonLabelPrimary,
      fixedSize: const Size.square(40),
      iconSize: 20,
      onPressed: () {
        if (content?.isValid == false) return;
        final id = ref.read(liveBroadcastProvider).broadcast.id;
        ref.read(sendChatMessageProvider(broadcastId: id, content: content!));
      },
    );
  }
}
