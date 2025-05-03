import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/constants/constants.dart';
import 'package:meno_flutter/src/features/auth/presentation/presentation.dart';
import 'package:meno_flutter/src/features/broadcast/domain/entities/participant_role.dart';
import 'package:meno_flutter/src/features/broadcast/presentation/presentation.dart';
import 'package:meno_flutter/src/features/onboarding/onboarding.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/features/settings/presentation/presentation.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final menoRoute = ref.watch(menoRouteNotifierProvider);

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final isPathAllowed = menoRoute.value.allowedPaths.contains(state.fullPath);
    return !isPathAllowed ? menoRoute.value.redirectPath : null;
  }

  return GoRouter(
    initialLocation: const HomeRoute().location,
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

/*
  ###########################
  ##                       ##
  ##        DIALOGS        ##
  ##                       ##
  ###########################
*/

@TypedGoRoute<PermissionsRequestRoute>(
  path: '/permissions-settings-redirect',
  name: 'Permissions Required',
)
class PermissionsRequestRoute extends GoRouteData {
  const PermissionsRequestRoute({this.permission = 'Microphone'});
  final String permission;

  @override
  Page<bool> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage<bool>(
      title: 'Permissions Required',
      description:
          '''You need to enable $permission permissions in Settings to use this feature. Would you like to open Settings now?''',
      primaryActionText: 'Open Settings',
      onPrimaryAction: () => context.pop(true),
      onSecondaryAction: () => context.pop(false),
    );
  }
}

/*
  ###########################
  ##                       ##
  ##        MODALS         ##
  ##                       ##
  ###########################
*/
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

@TypedGoRoute<AddCohostRoute>(path: '/add-cohost', name: 'Add Co-host')
class AddCohostRoute extends GoRouteData {
  const AddCohostRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalPage<void>(builder: (context) => const AddCoHostModal());
  }

  @override
  FutureOr<bool> onExit(BuildContext context, GoRouterState state) {
    ProviderScope.containerOf(context).invalidate(editProfileFormProvider);
    return super.onExit(context, state);
  }
}

@TypedGoRoute<ParticipantInfoRoute>(
  path: '/particpants/:id',
  name: 'Participant Info',
)
class ParticipantInfoRoute extends GoRouteData {
  const ParticipantInfoRoute(this.id, {this.role});
  final String id;
  final ParticipantRole? role;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalPage<void>(
      builder: (context) => ParticipantInfoModal(id, role: role),
    );
  }

  @override
  FutureOr<bool> onExit(BuildContext context, GoRouterState state) {
    ProviderScope.containerOf(context).invalidate(editProfileFormProvider);
    return super.onExit(context, state);
  }
}

/*
  ###########################
  ##                       ##
  ##        PAGES          ##
  ##                       ##
  ###########################
*/
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

@TypedGoRoute<SettingsRoute>(path: '/settings', name: 'Settings')
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(context, state) => const SettingsPage();
}

@TypedGoRoute<CreateBroadcastRoute>(
  path: '/create-broadcast',
  name: 'Create Broadcast',
)
class CreateBroadcastRoute extends GoRouteData {
  const CreateBroadcastRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: const CreateBroadcastPage(),
      opaque: false,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        );

        // Apply a curve for the bounce effect on entry
        // Curves.bounceOut or Curves.elasticOut are good choices
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.elasticIn,
          reverseCurve: Curves.easeOut,
        );

        // Create the animation using the tween and the curved animation
        final customAnimation = tween.animate(curvedAnimation);

        // Use SlideTransition with FadeTransition
        return SlideTransition(position: customAnimation, child: child);
      },
    );
  }
}

@TypedGoRoute<BroadcastsRoute>(path: '/broadcasts', name: 'Broadcasts')
class BroadcastsRoute extends GoRouteData {
  const BroadcastsRoute({
    required this.type,
    required this.sortBy,
    required this.orderBy,
    this.page = 1,
    this.size = kPageSize,
    this.startTimeExists,
    this.endTimeExists,
    this.include,
    this.status,
  });

  final BroadcastsPageType type;
  final int page;
  final int size;
  final String sortBy;
  final OrderBy orderBy;
  final bool? startTimeExists;
  final bool? endTimeExists;
  final String? include;
  final String? status;

  @override
  Widget build(context, state) {
    return BroadcastsPage(
      type: type,
      page: page,
      size: size,
      sortBy: sortBy,
      orderBy: orderBy,
      startTimeExists: startTimeExists,
      endTimeExists: endTimeExists,
      include: include,
      status: status,
    );
  }
}

/*
  ###########################
  ##                       ##
  ##      MAIN LAYOUT      ##
  ##                       ##
  ###########################
*/
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
    return MenoLayout(navigationShell: navigationShell);
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

/*
  #################################
  ##                             ##
  ##      LIVE SESSION PAGE      ##
  ##                             ##
  #################################
*/
@TypedGoRoute<LiveSessionRoute>(path: '/broadcasts/live/:id')
class LiveSessionRoute extends GoRouteData {
  const LiveSessionRoute(this.id);
  final String id;

  @override
  Widget build(context, state) => const LiveSessionPage();
}
