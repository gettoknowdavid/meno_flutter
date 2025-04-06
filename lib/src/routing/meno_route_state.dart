import 'package:meno_flutter/src/features/auth/auth.dart' show Token, User;
import 'package:meno_flutter/src/routing/router.dart';

sealed class MenoRouteState {
  const MenoRouteState();
}

final class MenoRouteLoadInProgress extends MenoRouteState {
  const MenoRouteLoadInProgress();
}

final class MenoRouteOnboarding extends MenoRouteState {
  const MenoRouteOnboarding();
}

final class MenoRouteUnauthenticated extends MenoRouteState {
  const MenoRouteUnauthenticated();
}

final class MenoRouteAuthenticated extends MenoRouteState {
  const MenoRouteAuthenticated(this.user, this.token);
  final User user;
  final Token token;
}

extension MenoRouteX on MenoRouteState {
  String get redirectPath {
    return switch (this) {
      MenoRouteOnboarding() => const OnboardingRoute().location,
      MenoRouteUnauthenticated() => const LoginRoute().location,
      MenoRouteAuthenticated() => const HomeRoute().location,
      MenoRouteLoadInProgress() => const LoadingRoute().location,
    };
  }

  Set<String> get allowedPaths {
    return switch (this) {
      MenoRouteOnboarding() => {
        const OnboardingRoute().location,
        const LoginRoute().location,
        const RegisterRoute().location,
        const VerifyEmailRoute().location,
        const ResetPasswordRoute().location,
        const PasswordRecoveryRoute().location,
      },
      MenoRouteUnauthenticated() => {
        const LoginRoute().location,
        const RegisterRoute().location,
        const VerifyEmailRoute().location,
        const ResetPasswordRoute().location,
        const PasswordRecoveryRoute().location,
        const SwitchAccountModalRoute().location,
      },
      MenoRouteAuthenticated() => {
        const HomeRoute().location,
        const DiscoverRoute().location,
        const NotesRoute().location,
        const MyProfileRoute().location,
        const SwitchAccountModalRoute().location,
      },
      _ => {const LoadingRoute().location},
    };
  }
}
