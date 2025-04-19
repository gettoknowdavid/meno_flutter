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
  const MenoRouteAuthenticated();
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
        const EditProfileRoute().location,
        const SettingsRoute().location,
        const PermissionsRequestRoute().location,
        const SettingsRoute().location,
        const CreateBroadcastRoute().location,
        const AddCohostRoute().location,
        '/broadcasts',
      },
      _ => {const LoadingRoute().location},
    };
  }
}

/**
 * 
  /// Executes the callback corresponding to the current route state.
  ///
  /// Ensures all possible states are handled.
  ///
  /// Parameters:
  ///   - `loadInProgress`: Callback for [MenoRouteLoadInProgress].
  ///   - `onboarding`: Callback for [MenoRouteOnboarding].
  ///   - `unauthenticated`: Callback for [MenoRouteUnauthenticated].
  ///   - `authenticated`: Callback for [MenoRouteAuthenticated].
  ///
  /// Returns:
  ///   The result of the executed callback.
  TResult when<TResult>({
    required TResult Function(MenoRouteLoadInProgress state) loadInProgress,
    required TResult Function(MenoRouteOnboarding state) onboarding,
    required TResult Function(MenoRouteUnauthenticated state) unauthenticated,
    required TResult Function(MenoRouteAuthenticated state) authenticated,
  }) {
    final self = this;
    return switch (self) {
      MenoRouteLoadInProgress() => loadInProgress(self),
      MenoRouteOnboarding() => onboarding(self),
      MenoRouteUnauthenticated() => unauthenticated(self),
      MenoRouteAuthenticated() => authenticated(self),
    };
  }

  // Optional: Add maybeWhen if you sometimes only want to handle a few cases
  // and provide a default handler for the rest.

  /// Optionally executes a callback based on the current state,
  /// or a default action if the specific state callback is not provided.
  TResult maybeWhen<TResult>({
    required TResult Function() orElse,
    TResult Function(MenoRouteLoadInProgress state)? loadInProgress,
    TResult Function(MenoRouteOnboarding state)? onboarding,
    TResult Function(MenoRouteUnauthenticated state)? unauthenticated,
    TResult Function(MenoRouteAuthenticated state)? authenticated,
  }) {
    final self = this;
    switch (self) {
      case final MenoRouteLoadInProgress s when loadInProgress != null:
        return loadInProgress(s);
      case final MenoRouteOnboarding s when onboarding != null:
        return onboarding(s);
      case final MenoRouteUnauthenticated s when unauthenticated != null:
        return unauthenticated(s);
      case final MenoRouteAuthenticated s when authenticated != null:
        return authenticated(s);
      default:
        return orElse();
    }
  }
 */
