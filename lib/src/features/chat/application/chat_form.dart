//
// ignore_for_file: avoid_redundant_argument_values

import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_form.g.dart';

@riverpod
class ChatForm extends _$ChatForm {
  @override
  ChatFormState build() => const ChatFormState();

  void contentChanged(String value) {
    final content = MultiLineString(value);
    state = state.copyWith(content: content);
  }

  void startEditing(Chat chat) {
    state = state.copyWith(
      isEditing: true,
      initialChat: chat,
      content: chat.content,
    );
  }

  void stopEditing() {
    state = state.copyWith(isEditing: false, initialChat: null, content: null);
  }

  void clearContent() => state = state.copyWith(content: null);

  void hideWelcomeNote() => state = state.copyWith(hideWelcomeNote: true);
}

class ChatFormState with EquatableMixin {
  const ChatFormState({
    this.initialChat,
    this.content,
    this.isEditing = false,
    this.hideWelcomeNote = false,
  });

  final Chat? initialChat;
  final MultiLineString? content;
  final bool isEditing;
  final bool hideWelcomeNote;

  ChatFormState copyWith({
    Chat? initialChat,
    MultiLineString? content,
    bool? isEditing,
    bool? hideWelcomeNote,
  }) {
    return ChatFormState(
      initialChat: initialChat ?? this.initialChat,
      content: content ?? this.content,
      isEditing: isEditing ?? this.isEditing,
      hideWelcomeNote: hideWelcomeNote ?? this.hideWelcomeNote,
    );
  }

  @override
  List<Object?> get props => [initialChat, content, isEditing, hideWelcomeNote];
}
