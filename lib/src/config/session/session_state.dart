part of 'session.dart';

sealed class SessionState {
  const SessionState();
}

final class SessionLoadInProgress extends SessionState {
  const SessionLoadInProgress();
}

final class SessionOnboarding extends SessionState {
  const SessionOnboarding();
}

final class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}

final class SessionAuthenticated extends SessionState {
  const SessionAuthenticated(this.user, this.token);
  final User user;
  final Token token;
}
