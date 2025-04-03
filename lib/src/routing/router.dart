import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/session/session.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _mainLayoutKey = GlobalKey<NavigatorState>(debugLabel: 'main-layout');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final session = ref.watch(sessionProvider);

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final isAllowedPath = session.value.allowedPaths.contains(state.fullPath);
    if (!isAllowedPath) return session.value.redirectPath;
    return null;
  }

  return GoRouter(
    initialLocation: const HomeRoute().location,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: session,
    redirect: redirect,
    routes: $appRoutes,
  );
}

@TypedGoRoute<LoadingRoute>(path: '/loading', name: 'Loading')
class LoadingRoute extends GoRouteData {
  const LoadingRoute();

  @override
  Widget build(context, state) {
    return const Scaffold(
      body: Center(child: MenoLoadingIndicator.lg(isBox: true)),
    );
  }
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(context, state) => const OnboardingPage();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(context, state) => const LoginPage();
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(context, state) => const RegisterPage();
}

@TypedGoRoute<VerifyEmailRoute>(path: '/verify-email')
class VerifyEmailRoute extends GoRouteData {
  const VerifyEmailRoute();

  @override
  Widget build(context, state) => const VerifyEmailPage();
}

@TypedGoRoute<ResetPasswordRoute>(path: '/reset-password')
class ResetPasswordRoute extends GoRouteData {
  const ResetPasswordRoute();

  @override
  Widget build(context, state) => const ResetPasswordPage();
}

@TypedGoRoute<PasswordRecoveryRoute>(path: '/password-recovery')
class PasswordRecoveryRoute extends GoRouteData {
  const PasswordRecoveryRoute();

  @override
  Widget build(context, state) => const PasswordRecoveryPage();
}

@TypedStatefulShellRoute<MenoLayoutRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<HomeRoute>(path: '/')],
    ),
    TypedStatefulShellBranch<DiscoverShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DiscoverRoute>(path: '/discover'),
      ],
    ),
    TypedStatefulShellBranch<NotesShellBranchData>(
      routes: <TypedRoute<RouteData>>[TypedGoRoute<NotesRoute>(path: '/notes')],
    ),
    TypedStatefulShellBranch<ProfileShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileRoute>(path: '/profile'),
      ],
    ),
  ],
)
class MenoLayoutRouteData extends StatefulShellRouteData {
  const MenoLayoutRouteData();

  @override
  Widget builder(context, state, navigationShell) {
    return MenoLayout(
      key: _mainLayoutKey,
      navigationShell: navigationShell,
      currentRoute: state.fullPath,
    );
  }
}

class HomeShellBranchData extends StatefulShellBranchData {
  const HomeShellBranchData();
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(context, state) => const HomePage();
}

class DiscoverShellBranchData extends StatefulShellBranchData {
  const DiscoverShellBranchData();
}

class DiscoverRoute extends GoRouteData {
  const DiscoverRoute();

  @override
  Widget build(context, state) => const HomePage(title: 'Discover');
}

class NotesShellBranchData extends StatefulShellBranchData {
  const NotesShellBranchData();
}

class NotesRoute extends GoRouteData {
  const NotesRoute();

  @override
  Widget build(context, state) => const HomePage(title: 'Notes');
}

class ProfileShellBranchData extends StatefulShellBranchData {
  const ProfileShellBranchData();
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(context, state) => const HomePage(title: 'Profile');
}

extension SessionX on SessionState {
  String get redirectPath {
    return switch (this) {
      SessionOnboarding() => const OnboardingRoute().location,
      SessionUnauthenticated() => const LoginRoute().location,
      SessionAuthenticated() => const HomeRoute().location,
      SessionLoadInProgress() => const LoadingRoute().location,
    };
  }

  Set<String> get allowedPaths {
    return switch (this) {
      SessionOnboarding() => {
        const OnboardingRoute().location,
        const LoginRoute().location,
        const RegisterRoute().location,
        const VerifyEmailRoute().location,
        const ResetPasswordRoute().location,
        const PasswordRecoveryRoute().location,
      },
      SessionUnauthenticated() => {
        const LoginRoute().location,
        const RegisterRoute().location,
        const VerifyEmailRoute().location,
        const ResetPasswordRoute().location,
        const PasswordRecoveryRoute().location,
      },
      SessionAuthenticated() => {
        const HomeRoute().location,
        const DiscoverRoute().location,
        const NotesRoute().location,
        const ProfileRoute().location,
      },
      _ => {const LoadingRoute().location},
    };
  }
}
