import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_notifier.g.dart';

@Riverpod(keepAlive: true)
class Accounts extends _$Accounts {
  @override
  AsyncValue<Map<String, UserCredential>> build() {
    state = const AsyncLoading();

    ref.listen(allAccountsProvider, (previous, next) {
      state = switch (next) {
        AsyncError(:final error) => AsyncError(error, StackTrace.current),
        AsyncData(:final value) => AsyncData(value),
        _ => const AsyncLoading(),
      };
    }, fireImmediately: true);

    return state;
  }

  Future<void> switchAccount(UserCredential credential) async {
    final result = await ref.read(authFacadeProvider).switchAccount(credential);
    result.fold((exception) => state, (success) => null);
  }
}
