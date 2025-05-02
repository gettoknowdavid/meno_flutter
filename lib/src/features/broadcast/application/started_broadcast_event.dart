import 'dart:async';

import 'package:meno_flutter/src/config/config.dart' show BaseResponse;
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/services/socket/socket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'started_broadcast_event.g.dart';

@riverpod
class StartedBroadcastEvent extends _$StartedBroadcastEvent {
  @override
  Future<void> build() async {}

  Future<void> emit() async {
    final id = ref.read(broadcastIDProvider);
    if (id == null) throw const BroadcastNotFoundException();

    state = const AsyncLoading();

    final socket = ref.read(socketProvider.notifier);

    final result = await socket.emitWithAck('startedBroadcast', {
      'broadcastId': id.getOrCrash(),
    });

    final response = BaseResponse.fromJson(
      result as Map<String, dynamic>,
      (json) => json as dynamic,
    );

    if (response.error == null) {
      state = const AsyncData(null);
    } else {
      final error = _getSocketError(response.error);
      state = AsyncError(error, StackTrace.current);
    }
  }
}

SocketException _getSocketError(dynamic error) {
  final result = switch (error) {
    final Map<String, dynamic> errors => SocketValidationException(errors),
    _ => SocketException(error),
  };
  return result;
}
