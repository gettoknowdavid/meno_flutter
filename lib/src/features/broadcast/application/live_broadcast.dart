//
// ignore_for_file: avoid_redundant_argument_values

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/services/socket/socket.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_broadcast.g.dart';

final broadcastIDProvider = StateProvider<ID?>((ref) => null);

@Riverpod(keepAlive: true)
class LiveBroadcast extends _$LiveBroadcast {
  IBroadcastFacade get _facade => ref.read(broadcastFacadeProvider);
  ID? get broadcastID => ref.read(broadcastIDProvider);

  @override
  LiveBroadcastState build() {
    return LiveBroadcastState(broadcast: Broadcast.empty());
  }

  Future<void> initialize() async {
    if (broadcastID == null) {
      state = state.copyWith(
        exception: const BroadcastNotFoundException(),
        status: MenoLiveStatus.failure,
      );
    }

    state = state.copyWith(status: MenoLiveStatus.inProgress, exception: null);

    final result = await _facade.getBroadcasts(
      id: broadcastID,
      sortBy: 'title',
      orderBy: OrderBy.ASC,
      size: 1,
    );

    state = result.fold(
      (exception) =>
          state.copyWith(exception: exception, status: MenoLiveStatus.failure),
      (paginatedList) {
        final broadcast = paginatedList.items.first;

        if (broadcast == null) {
          return state.copyWith(
            exception: const BroadcastNotFoundException(),
            status: MenoLiveStatus.failure,
          );
        }

        return state.copyWith(
          broadcast: broadcast,
          status: MenoLiveStatus.initialized,
        );
      },
    );
  }

  Future<void> startBroadcast() async {
    if (broadcastID == null) {
      state = state.copyWith(
        exception: const BroadcastNotFoundException(),
        status: MenoLiveStatus.failure,
      );
    }

    state = state.copyWith(status: MenoLiveStatus.connecting, exception: null);

    final result = await _facade.startBroadcast(broadcastID!);

    state = result.fold(
      (exception) {
        return state.copyWith(
          exception: exception,
          status: MenoLiveStatus.failure,
        );
      },
      (broadcast) {
        return state.copyWith(
          broadcast: broadcast,
          status: MenoLiveStatus.started,
        );
      },
    );
  }

  Future<void> joinBroadcast() async {
    if (broadcastID == null) {
      state = state.copyWith(
        exception: const BroadcastNotFoundException(),
        status: MenoLiveStatus.failure,
      );
    }

    state = state.copyWith(status: MenoLiveStatus.connecting, exception: null);

    final result = await _facade.joinBroadcast(broadcastID!);

    state = result.fold(
      (exception) {
        return state.copyWith(
          exception: exception,
          status: MenoLiveStatus.failure,
        );
      },
      (broadcast) {
        return state.copyWith(
          broadcast: broadcast,
          status: MenoLiveStatus.joined,
        );
      },
    );
  }

  Future<void> endBroadcast() async {
    if (broadcastID == null) {
      state = state.copyWith(
        exception: const BroadcastNotFoundException(),
        status: MenoLiveStatus.failure,
      );
    }

    state = state.copyWith(status: MenoLiveStatus.inProgress, exception: null);

    final socket = ref.read(socketProvider.notifier);

    final result = await socket.emitWithAck('endBroadcast', {
      'broadcastId': broadcastID?.getOrCrash(),
    });

    final response = BaseResponse.fromJson(
      result as Map<String, dynamic>,
      (json) => json as dynamic,
    );

    if (response.error != null) {
      final error = switch (response.error) {
        final Map<String, dynamic> errors => SocketValidationException(errors),
        _ => SocketException(response.error),
      };

      state = state.copyWith(
        exception: BroadcastExceptionWithMessage(error.message as String),
        status: MenoLiveStatus.failure,
      );
    } else {
      state = state.copyWith(status: MenoLiveStatus.ended);
    }
  }

  Future<void> leaveBroadcast() async {
    if (broadcastID == null) {
      state = state.copyWith(
        exception: const BroadcastNotFoundException(),
        status: MenoLiveStatus.failure,
      );
    }

    state = state.copyWith(status: MenoLiveStatus.inProgress, exception: null);

    final socket = ref.read(socketProvider.notifier);

    final result = await socket.emitWithAck('leaveBroadcast', {
      'broadcastId': broadcastID?.getOrCrash(),
    });

    final response = BaseResponse.fromJson(
      result as Map<String, dynamic>,
      (json) => json as dynamic,
    );

    if (response.error != null) {
      final error = switch (response.error) {
        final Map<String, dynamic> errors => SocketValidationException(errors),
        _ => SocketException(response.error),
      };

      state = state.copyWith(
        exception: BroadcastExceptionWithMessage(error.message as String),
        status: MenoLiveStatus.failure,
      );
    } else {
      state = state.copyWith(status: MenoLiveStatus.left);
    }
  }
}

enum MenoLiveStatus {
  offAir,
  inProgress,
  initialized,
  success,
  started,
  joined,
  ended,
  left,
  connecting,
  live,
  reconnecting,
  failure,
  canceled,
}

final class LiveBroadcastState with EquatableMixin {
  const LiveBroadcastState({
    required this.broadcast,
    this.status = MenoLiveStatus.offAir,
    this.exception,
  });

  final Broadcast broadcast;
  final MenoLiveStatus status;
  final BroadcastException? exception;

  LiveBroadcastState copyWith({
    Broadcast? broadcast,
    MenoLiveStatus? status,
    BroadcastException? exception,
  }) {
    return LiveBroadcastState(
      broadcast: broadcast ?? this.broadcast,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [broadcast, status, exception];

  @override
  bool? get stringify => true;
}
