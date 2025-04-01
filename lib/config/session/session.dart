//
// ignore_for_file: avoid_catches_without_on_clauses

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  ValueNotifier<SessionState> build() {
    state = ValueNotifier(const SessionLoading());

    ref.listen(authStateChangesProvider, (previous, next) async {
      final onboarding = ref.read(onboardingNotifierProvider);
      if (onboarding.value ?? false) {
        state.value = _setState(next);
      } else {
        state.value = const SessionNotOnboarded();
      }
    });

    return state;
  }

  Future<void> logout() => ref.read(authLocalProvider).removeAccount();
}

SessionState _setState(AsyncValue<UserCredential?> value) {
  switch (value) {
    case AsyncError(:final error):
      return SessionError(error);
    case AsyncData(:final value):
      if (value == null) return const Unauthenticated();
      return Authenticated(value.user, value.token);
    default:
      return const SessionLoading();
  }
}

@freezed
abstract class SessionState with _$SessionState {
  const factory SessionState.loading() = SessionLoading;
  const factory SessionState.notOnboarded() = SessionNotOnboarded;
  const factory SessionState.error(dynamic error) = SessionError;
  const factory SessionState.unauthenticated() = Unauthenticated;
  const factory SessionState.authenticated(User user, Token token) =
      Authenticated;
}
