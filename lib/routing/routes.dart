enum RouteAccess { public, protected }

sealed class Routes {
  const Routes._(this.path, this.name, {this.protected = false});
  final String path;
  final String name;
  final bool protected;

  static const onboarding = _AppRoute('/onboarding', 'Onboarding');
  static const login = _AppRoute('/login', 'Login');
  static const register = _AppRoute('/register', 'Register');
  static const home = _AppRoute('/', 'Home', protected: true);

  static const values = [onboarding, login, register, home];
}

class _AppRoute extends Routes {
  const _AppRoute(super.path, super.name, {super.protected = false})
    : super._();
}
