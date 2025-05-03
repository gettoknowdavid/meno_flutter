import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_notifier.g.dart';

@Riverpod(keepAlive: true)
class LiveNotifier extends _$LiveNotifier {
  @override
  LiveState build() {
    log('LiveStatusNotifier: build() called. Setting up listeners.');

    ref.listen<AsyncValue<Room?>>(liveKitProvider, (_, next) {
      switch (next) {
        case AsyncLoading():
          state = const MenoConnecting();
        case AsyncError():
          state = const MenoFailure();
        case AsyncData(:final value):
          if (value == null) state = const MenoOffAir();
        default:
      }
    });

    ref.listen<AsyncValue<RoomEvent>>(liveKitEventProvider, (_, next) {
      if (next.value != null) {
        switch (next.value) {
          case RoomConnectedEvent():
          case RoomReconnectedEvent():
            state = const MenoLive();
          case RoomReconnectingEvent():
          case RoomAttemptReconnectEvent():
            state = const MenoReconnecting();
          case RoomDisconnectedEvent():
            state = const MenoOffAir();
          default:
        }
      }
    });

    ref.listen(startedBroadcastEventProvider, (previous, next) {
      switch (next) {
        case AsyncLoading():
          state = const MenoStartingBroadcast();
        case AsyncError():
          state = const MenoFailure();
        case AsyncData(:final value):
          if (value) state = const MenoLive();
        default:
      }
    });

    return const MenoOffAir();
  }
}

sealed class LiveState with EquatableMixin {
  const LiveState();

  @override
  List<Object?> get props => [];
}

final class MenoOffAir extends LiveState {
  const MenoOffAir();
}

final class MenoStartingBroadcast extends LiveState {
  const MenoStartingBroadcast();
}

final class MenoJoiningBroadcast extends LiveState {
  const MenoJoiningBroadcast();
}

final class MenoEndingBroadcast extends LiveState {
  const MenoEndingBroadcast();
}

final class MenoLeavingBroadcast extends LiveState {
  const MenoLeavingBroadcast();
}

final class MenoConnecting extends LiveState {
  const MenoConnecting();
}

final class MenoLive extends LiveState {
  const MenoLive();
}

final class MenoReconnecting extends LiveState {
  const MenoReconnecting();
}

final class MenoFailure extends LiveState {
  const MenoFailure();
  // final Object? error;
  // final StackTrace? stackTrace;

  // @override
  // List<Object?> get props => [error, stackTrace];
}
