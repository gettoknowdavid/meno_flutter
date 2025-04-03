import 'package:flutter/material.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/onboarding/data/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_state.dart';
part 'session.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  ValueNotifier<SessionState> build() {
    state = ValueNotifier(const SessionLoadInProgress());

    ref.listen(authStateChangesProvider, (previous, next) {
      final isOnboarded = ref.read(onboardingFacadeProvider).onboardingComplete;
      if (isOnboarded) {
        state.value = _setState(next);
      } else {
        state.value = const SessionOnboarding();
      }
    });

    return state;
  }

  Future<void> logout() => ref.read(authFacadeProvider).logout();
}

SessionState _setState(AsyncValue<UserCredential?> value) {
  switch (value) {
    case AsyncLoading():
      return const SessionLoadInProgress();
    case AsyncData(:final value):
      if (value == null) return const SessionUnauthenticated();
      return SessionAuthenticated(value.user, value.token);
    default:
      return const SessionUnauthenticated();
  }
}
