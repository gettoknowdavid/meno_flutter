import 'package:flutter/material.dart';
import 'package:meno_flutter/src/features/auth/application/application.dart'
    show authStateChangesProvider;
import 'package:meno_flutter/src/features/auth/auth.dart'
    show UserCredential;
import 'package:meno_flutter/src/features/onboarding/onboarding.dart'
    show onboardingFacadeProvider;
import 'package:meno_flutter/src/routing/meno_route_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meno_route_notifier.g.dart';

@Riverpod(keepAlive: true)
class MenoRoute extends _$MenoRoute {
  @override
  ValueNotifier<MenoRouteState> build() {
    state = ValueNotifier(const MenoRouteLoadInProgress());

    ref.listen(authStateChangesProvider, (previous, next) {
      final isOnboarded = ref.read(onboardingFacadeProvider).onboardingComplete;
      if (isOnboarded) {
        state.value = _setState(next);
      } else {
        state.value = const MenoRouteOnboarding();
      }
    });

    return state;
  }
}

MenoRouteState _setState(AsyncValue<UserCredential?> value) {
  switch (value) {
    case AsyncLoading():
      return const MenoRouteLoadInProgress();
    case AsyncData(:final value):
      if (value == null) return const MenoRouteUnauthenticated();
      return MenoRouteAuthenticated(value.user, value.token);
    default:
      return const MenoRouteUnauthenticated();
  }
}
