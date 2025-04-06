import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_notifier.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  UserCredential build() {
    state = UserCredential.empty();
    ref.listen(authStateChangesProvider, (previous, next) {
      switch (next) {
        case AsyncLoading():
        case AsyncError():
          state = UserCredential.empty();
        case AsyncData(:final value):
          state = value ?? UserCredential.empty();
      }
    });

    return state;
  }

  Future<void> logout() => ref.read(authFacadeProvider).logout();
}
