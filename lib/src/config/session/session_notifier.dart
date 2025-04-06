import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_notifier.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  SessionState build() {
    state = SessionState.empty();

    ref.listen(authStateChangesProvider, (previous, next) {
      state = state.copyWith(credential: next.valueOrNull);
    }, fireImmediately: true);

    ref.listen(allAccountsProvider, (previous, next) {
      state = state.copyWith(accounts: next.valueOrNull);
    }, fireImmediately: true);

    return state;
  }

  Future<void> logout() => ref.read(authFacadeProvider).logout();

  Future<void> switchAccount(UserCredential credential) async {
    final result = await ref.read(authFacadeProvider).switchAccount(credential);
    result.fold((exception) => state, (success) => null);
  }
}

final class SessionState with EquatableMixin {
  const SessionState({required this.credential, required this.accounts});

  factory SessionState.empty() {
    return SessionState(credential: UserCredential.empty(), accounts: {});
  }

  final UserCredential credential;
  final Map<String, UserCredential> accounts;

  SessionState copyWith({
    UserCredential? credential,
    Map<String, UserCredential>? accounts,
  }) {
    return SessionState(
      accounts: accounts ?? this.accounts,
      credential: credential ?? this.credential,
    );
  }

  @override
  List<Object?> get props => [credential, accounts];
}
