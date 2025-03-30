import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  SessionState build() {
    return const SessionLoading();
  }
}

@freezed
abstract class SessionState with _$SessionState {
 const factory SessionState.loading() = SessionLoading;
 const factory SessionState.unauthenticated() = SessionUnauthenticated;
 const factory SessionState.authenticated(User user) = SessionAuthenticated;
}
