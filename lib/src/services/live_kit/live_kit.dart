//
// ignore_for_file: use_setters_to_change_properties

import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:meno_flutter/src/config/env/env.dart';
import 'package:meno_flutter/src/services/live_kit/audio_enabled.dart';
import 'package:meno_flutter/src/services/live_kit/audio_track.dart';
import 'package:meno_flutter/src/services/live_kit/microphone.dart';
import 'package:meno_flutter/src/services/live_kit/selected_audio_device.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'live_kit.g.dart';

@Riverpod(keepAlive: true)
Stream<RoomEvent> liveKitEvent(Ref ref) {
  final room = ref.watch(liveKitProvider).value;
  if (room == null) return const Stream.empty();

  final listener = room.createListener();
  final controller = BehaviorSubject<RoomEvent>();

  ref.onDispose(() {
    listener.cancelAll();
    controller.close();
  });

  listener.listen(controller.add);

  return controller.stream;
}

@Riverpod(
  keepAlive: true,
  dependencies: [AudioEnabled, MenoAudioTrack, SelectedAudioDevice],
)
class LiveKit extends _$LiveKit {
  @override
  FutureOr<Room?> build() async {
    ref.onDispose(_dispose);
    return null;
  }

  Future<void> broadcast(String token) async {
    return _connect(token: token, isHost: true);
  }

  Future<void> stream(String token) async {
    return _connect(token: token);
  }

  Future<void> _connect({required String token, bool isHost = false}) async {
    if (state.isLoading || _isConnected) {
      log('LiveKit: Already connected or connecting.');
      return;
    }

    state = const AsyncLoading();

    final url = ref.read(livekitUrlProvider);
    final audioTrack = isHost ? ref.read(menoAudioTrackProvider).value : null;

    log('Attempting connect. AudioTrack: ${audioTrack?.sid}');

    final room = Room(
      roomOptions: const RoomOptions(
        defaultAudioPublishOptions: AudioPublishOptions(
          name: 'microphone',
          audioBitrate: AudioPreset.speech,
        ),
      ),
    );

    try {
      if (state.hasValue && state.value != null) {
        log('STATE HAS VALUE => ${state.value}');
        await _disconnectInternal();
      }

      log('Preparing the connection...');
      await room.prepareConnection(url, token);

      log('Connection prepared.');

      // Connect using FastConnectOptions with prepared tracks
      log('Connecting...');
      await room.connect(
        url,
        token,
        fastConnectOptions: FastConnectOptions(
          microphone:
              isHost
                  ? TrackOption(track: audioTrack)
                  : const TrackOption(enabled: false),
        ),
      );

      log('LiveKit: Room connect successful.');
      // Update main state
      state = AsyncData(room);

      if (isHost) {
        ref.read(audioEnabledProvider.notifier).setEnabled(true);
        await ref.read(microphoneProvider.notifier).enableMic();
      }
    } on LiveKitException catch (error, stackTrace) {
      log('LiveKit: Connection failed.', error: error, stackTrace: stackTrace);
      // Ensure cleanup happens on failure
      await _cleanupRoom(room); // Clean up the room we tried to connect with
      // _cleanupListener(); // Clean up listener if manually managed
      state = AsyncError(error, stackTrace);
      // Reset dependent states on failure
      _invalidateDependencies();
    }
  }

  /// Disconnects from the current room.
  Future<void> disconnect() async {
    await _disconnectInternal();
  }

  Future<void> _disconnectInternal() async {
    final currentRoom = state.valueOrNull;
    if (currentRoom == null) {
      log('LiveKit: Already disconnected.');
      // Ensure state is AsyncData(null) if it wasn't already
      if (state is! AsyncData<Room?> || state.value != null) {
        state = const AsyncData(null);
      }
      return;
    }

    log('LiveKit: Disconnecting internal...');
    await _cleanupRoom(currentRoom);

    _invalidateDependencies();

    try {
      await state.value?.localParticipant?.setMicrophoneEnabled(false);
      await state.value?.disconnect();
      await state.value?.dispose();
      log('LiveKit: Room disconnected and disposed.');
    } on Exception catch (e) {
      log('LiveKit: Error during disconnect/dispose: $e');
    } finally {
      state = const AsyncData(null);
    }
  }

  /// Cleans up a specific Room instance.
  Future<void> _cleanupRoom(Room? room) async {
    if (room == null) return;
    log('LiveKit: Cleaning up Room SID: ${room.name}');
    try {
      // Remove listeners added directly to the room if any
      // room.removeListener(_handleRoomEvent); // Example
      await room.disconnect();
      await room.dispose();
      log('LiveKit: Room disconnected and disposed.');
    } on Exception catch (e, s) {
      log('LiveKit: Error during room cleanup', error: e, stackTrace: s);
    }
  }

  /// Invalidates providers that depend on the connection state.
  void _invalidateDependencies() {
    log('LiveKit: Invalidating dependent providers...');
    Future.microtask(() {
      ref.invalidate(audioEnabledProvider);
      ref.invalidate(menoAudioTrackProvider);
      ref.invalidate(selectedAudioDeviceProvider);
      // Add any other providers that should reset on disconnect
    });
    log('LiveKit: Dependent providers marked for invalidation.');
  }

  Future<void> _dispose() async {
    log('LiveKit: Disposing Notifier...');
    await _disconnectInternal();
  }

  bool get _isConnected {
    final room = state.value;
    final hasValue = state.hasValue;
    final connected = room?.connectionState == ConnectionState.connected;
    final reconnecting = room?.connectionState == ConnectionState.reconnecting;
    return hasValue && (connected || reconnecting);
  }
}

extension RoomStateX on Room {
  bool get isConnected => connectionState == ConnectionState.connected;
  bool get isReconnecting => connectionState == ConnectionState.reconnecting;
  bool get isDisconnected => connectionState == ConnectionState.disconnected;
}
