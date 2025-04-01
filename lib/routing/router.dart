//
// ignore_for_file: type_annotate_public_apis

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/config/session/session.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/features/broadcast/broadcast.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';
import 'package:meno_flutter/routing/routes.dart' show MenoRoute;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final session = ref.watch(sessionProvider);

  return GoRouter(
    initialLocation: MenoRoute.onboarding.path,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: session,
    // redirect: (context, state) {
    //   return switch (session.value) {
    //     AsyncError(:final error) => MenoRoute.error.path,
    //     SessionLoading() => MenoRoute.loading.path,
    //     Unauthenticated() => MenoRoute.login.path,
    //     SessionError() => MenoRoute.error.path,
    //     _ => null,
    //   };
    // },
    redirect: (context, state) {
      // return switch (session.value) {
      //   // SessionNotOnboarded() => MenoRoute.onboarding.path,
      //   // SessionLoading() => MenoRoute.loading.path,
      //   // SessionError() => MenoRoute.error.path,
      //   Unauthenticated() => MenoRoute.unprotected[state.name],
      //   Authenticated() => MenoRoute.protected[state.name],
      //   _ => null,
      // };
    },
    routes: [
      GoRoute(
        path: MenoRoute.loading.path,
        name: MenoRoute.loading.name,
        builder: (context, state) {
          return const Scaffold(
            body: Center(child: MenoLoadingIndicator.lg(isBox: true)),
          );
        },
      ),
      GoRoute(
        path: MenoRoute.error.path,
        name: MenoRoute.error.name,
        builder: (context, state) {
          return const Scaffold(
            body: Center(child: MenoText.body('Unknown error')),
          );
        },
      ),
      GoRoute(
        path: MenoRoute.onboarding.path,
        name: MenoRoute.onboarding.name,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: MenoRoute.login.path,
        name: MenoRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: MenoRoute.register.path,
        name: MenoRoute.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: MenoRoute.verifyEmail.path,
        name: MenoRoute.verifyEmail.name,
        builder: (context, state) => const VerifyEmailPage(),
      ),
      GoRoute(
        path: MenoRoute.resetPassword.path,
        name: MenoRoute.resetPassword.name,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: MenoRoute.passwordRecovery.path,
        name: MenoRoute.passwordRecovery.name,
        builder: (context, state) => const PasswordRecoveryPage(),
      ),
    ],
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

@TypedGoRoute<OnboardingRoute>(path: '/onboarding', name: 'Onboarding')
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(context, state) => const OnboardingPage();
}

@TypedGoRoute<LoginRoute>(path: '/login', name: 'LogIn')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(context, state) => const LoginPage();
}

@TypedGoRoute<RegisterRoute>(path: '/register', name: 'Register')
class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(context, state) => const RegisterPage();
}

@TypedGoRoute<VerifyEmailRoute>(path: '/verify-email', name: 'VerifyEmail')
class VerifyEmailRoute extends GoRouteData {
  const VerifyEmailRoute();

  @override
  Widget build(context, state) => const VerifyEmailPage();
}

@TypedGoRoute<ResetPasswordRoute>(
  path: '/reset-password',
  name: 'ResetPassword',
)
class ResetPasswordRoute extends GoRouteData {
  const ResetPasswordRoute();

  @override
  Widget build(context, state) => const ResetPasswordPage();
}

@TypedGoRoute<PasswordRecoveryRoute>(
  path: '/password-recovery',
  name: 'PasswordRecovery',
)
class PasswordRecoveryRoute extends GoRouteData {
  const PasswordRecoveryRoute();

  @override
  Widget build(context, state) => const PasswordRecoveryPage();
}

@TypedGoRoute<HomeRoute>(path: '/', name: 'Home')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(context, state) => const HomePage();
}
