import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/auth/presentation/pages/pages.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';
import 'package:meno_flutter/src/features/profile/application/edit_profile_form.dart';
import 'package:meno_flutter/src/features/profile/presentation/presentation.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _mainLayoutKey = GlobalKey<NavigatorState>(debugLabel: 'main-layout');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final menoRoute = ref.watch(menoRouteNotifierProvider);

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final isPathAllowed = menoRoute.value.allowedPaths.contains(state.fullPath);
    return !isPathAllowed ? menoRoute.value.redirectPath : null;
  }

  return GoRouter(
    initialLocation: const HomeRoute().location,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: menoRoute,
    redirect: redirect,
    routes: $appRoutes,
  );
}

@TypedGoRoute<SwitchAccountModalRoute>(
  path: '/switch-account',
  name: 'Switch Account',
)
class SwitchAccountModalRoute extends GoRouteData {
  const SwitchAccountModalRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalPage<void>(builder: (context) => const SwicthAccountModal());
  }
}

@TypedGoRoute<EditProfileRoute>(path: '/edit-profile', name: 'Edit Profile')
class EditProfileRoute extends GoRouteData {
  const EditProfileRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalPage<void>(builder: (context) => const EditProfileModal());
  }

  @override
  FutureOr<bool> onExit(BuildContext context, GoRouterState state) {
    ProviderScope.containerOf(context).invalidate(editProfileFormProvider);
    return super.onExit(context, state);
  }
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
    TypedStatefulShellBranch<MyProfileShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MyProfileRoute>(path: '/profile'),
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

class MyProfileShellBranchData extends StatefulShellBranchData {
  const MyProfileShellBranchData();
}

class MyProfileRoute extends GoRouteData {
  const MyProfileRoute();

  @override
  Widget build(context, state) => const MyProfilePage();
}
