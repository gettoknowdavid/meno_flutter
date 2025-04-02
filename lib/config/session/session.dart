//
// ignore_for_file: avoid_catches_without_on_clauses

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  ValueNotifier<SessionState> build() {
    state = ValueNotifier(const SessionLoading());

    ref.listen(authStateChangesProvider, (previous, next) async {
      state.value = _setState(next);
    });

    return state;
  }

  Future<void> logout() => ref.read(authFacadeProvider.notifier).logout();
}

SessionState _setState(AsyncValue<UserCredential?> value) {
  switch (value) {
    case AsyncLoading():
      return const SessionLoading();
    case AsyncData(:final value):
      if (value == null) return const SessionUnauthenticated();
      return SessionAuthenticated(value.user, value.token);
    default:
      return const SessionUnauthenticated();
  }
}

@freezed
abstract class SessionState with _$SessionState {
  const factory SessionState.loading() = SessionLoading;
  const factory SessionState.unauthenticated() = SessionUnauthenticated;
  const factory SessionState.authenticated(User user, Token token) =
      SessionAuthenticated;
}
