import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_notifier.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  AsyncValue<UserCredential?> build() {
    state = const AsyncLoading();

    ref.listen(authStateChangesProvider, (previous, next) {
      state = switch (next) {
        AsyncError(:final error) => AsyncError(error, StackTrace.current),
        AsyncData(:final value) => AsyncData(value),
        _ => const AsyncLoading(),
      };
    }, fireImmediately: true);

    return state;
  }

  Future<void> logout() => ref.read(authFacadeProvider).logout();
}
