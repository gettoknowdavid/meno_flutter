enum RouteAccess { public, protected }

sealed class MenoRoute {
  const MenoRoute._(this.path, this.name);
  final String path;
  final String name;

  static const onboarding = _AppRoute('/onboarding', 'Onboarding');
  static const loading = _AppRoute('/loading', 'Loading');
  static const error = _AppRoute('/error', 'Error');
  static const login = _AppRoute('/login', 'Login');
  static const register = _AppRoute('/register', 'Register');
  static const verifyEmail = _AppRoute('/verify-email', 'Verify Email');
  static const resetPassword = _AppRoute('/reset-password', 'Reset Password');
  static const passwordRecovery = _AppRoute(
    '/password-recovery',
    'Password Receovery',
  );
  // static const home = _AppRoute('/', 'Home', isAuth: true);

  static final unprotected = {
    loading.name: loading.path,
    onboarding.name: onboarding.path,
    error.name: error.path,
    login.name: login.path,
    register.name: register.path,
    verifyEmail.name: verifyEmail.path,
    resetPassword.name: resetPassword.path,
    passwordRecovery.name: passwordRecovery.path,
  };
}

class _AppRoute extends MenoRoute {
  const _AppRoute(super.path, super.name) : super._();
}
