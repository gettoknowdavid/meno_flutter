import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meno_flutter/src/features/auth/application/auth_providers.dart';
import 'package:meno_flutter/src/features/auth/auth.dart'
    show authStateChangesProvider;
import 'package:meno_flutter/src/features/onboarding/application/application.dart';
import 'package:meno_flutter/src/routing/meno_route_state.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meno_route_notifier.g.dart';

@Riverpod(keepAlive: true)
class MenoRouteNotifier extends _$MenoRouteNotifier {
  @override
  ValueNotifier<MenoRouteState> build() {
    state = ValueNotifier(const MenoRouteLoadInProgress());

    final onboarded = ref.watch(onboardingNotifierProvider);

    if (!onboarded) {
      if (Platform.isIOS) ref.read(secureStorageProvider).deleteAll();
      return ValueNotifier(const MenoRouteOnboarding());
    }

    ref.listen(authStateChangesProvider, (previous, next) {
      switch (next) {
        case AsyncLoading():
          state = ValueNotifier(const MenoRouteLoadInProgress());
        case AsyncData(:final value):
          if (value == null) {
            state = ValueNotifier(const MenoRouteUnauthenticated());
          } else {
            state = ValueNotifier(const MenoRouteAuthenticated());
          }
        default:
          state = ValueNotifier(const MenoRouteUnauthenticated());
      }
    }, fireImmediately: true);

    return state;
  }
}
