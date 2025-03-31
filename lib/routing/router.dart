import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/features/onboarding/onboarding.dart';
import 'package:meno_flutter/routing/routes.dart' show Routes;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // FutureOr<String?> handleRedirect(BuildContext context, GoRouterState state) {

  // }

  return GoRouter(
    initialLocation: Routes.onboarding.path,
    navigatorKey: _rootNavigatorKey,
    // redirect: handleRedirect,
    routes: [
      GoRoute(
        path: Routes.onboarding.path,
        name: Routes.onboarding.name,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.register.path,
        name: Routes.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: Routes.verifyEmail.path,
        name: Routes.verifyEmail.name,
        builder: (context, state) => const VerifyEmailPage(),
      ),
      GoRoute(
        path: Routes.resetPassword.path,
        name: Routes.resetPassword.name,
        builder: (context, state) => const ResetPasswordPage(),
      ),
    ],
  );
}
