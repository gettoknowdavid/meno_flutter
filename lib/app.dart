import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MenoApp extends ConsumerWidget {
  const MenoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..watch(authFacadeProvider)
      ..watch(menoRouteProvider)
      ..watch(sessionProvider)
      ..watch(myProfileProvider);
    final routerConfig = ref.watch(routerProvider);
    return MenoAppView(routerConfig: routerConfig);
  }
}

class MenoAppView extends StatelessWidget {
  const MenoAppView({required this.routerConfig, super.key});
  final GoRouter routerConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Meno',
      theme: MenoTheme.light,
      darkTheme: MenoTheme.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: MenoSnackBar.key,
      routerConfig: routerConfig,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
