//
// ignore_for_file: use_setters_to_change_properties

import 'dart:async';
import 'dart:developer';

import 'package:livekit_client/livekit_client.dart';
import 'package:meno_flutter/src/config/env/env.dart';
import 'package:meno_flutter/src/services/live_kit/audio_enabled.dart';
import 'package:meno_flutter/src/services/live_kit/audio_track.dart';
import 'package:meno_flutter/src/services/live_kit/microphone.dart';
import 'package:meno_flutter/src/services/live_kit/selected_audio_device.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'live_kit.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [AudioEnabled, MenoAudioTrack, SelectedAudioDevice],
)
class LiveKit extends _$LiveKit {
  late EventsListener<RoomEvent> listener;

  BehaviorSubject<RoomEvent>? _events;
  Stream<RoomEvent>? get eventsStream => _events?.stream.asBroadcastStream();

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

    final audioTrack = isHost ? ref.read(menoAudioTrackProvider).value : null;
    final audioIsEnabled = ref.read(audioEnabledProvider);

    log('Attempting connect. AudioTrack: ${audioTrack?.sid}');
    log('AudioEnabled: $audioIsEnabled');

    final room = Room();

    listener = room.createListener();
    _setupListener();

    try {
      if (state.hasValue && state.value != null) {
        log('STATE HAS VALUE => ${state.value}');
        await _disconnect();
      }

      final url = ref.read(livekitUrlProvider);

      log('Preparing the connection...');
      await room.prepareConnection(url, token);

      log('Connection prepared.');

      // Connect using FastConnectOptions with prepared tracks
      log('Connecting...');
      await room.connect(
        url,
        token,
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(track: audioTrack),
        ),
      );

      log('LiveKit: Room connect successful.');
      // Update main state
      state = AsyncData(room);

      ref.read(audioEnabledProvider.notifier).setEnabled(true);
      await ref.read(microphoneProvider.notifier).enableMic();
    } on LiveKitException catch (error, stackTrace) {
      log('LiveKit: Connection failed: $error');
      await _disconnect();
      state = AsyncError(error, stackTrace);
    }
  }

  /// Disconnects from the current room.
  Future<void> disconnect() async {
    await _disconnect();
  }

  Future<void> _disconnect() async {
    log('LiveKit: Disconnecting...');

    _cleanupListeners();

    log('INVALIDATING OTHER CONNECTED PROVIDERS');
    await Future.microtask(() {
      ref.invalidate(audioEnabledProvider);
      ref.invalidate(menoAudioTrackProvider);
      ref.invalidate(selectedAudioDeviceProvider);
    });
    log('DONE INVALIDATING ✅');

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

  void _setupListener() {
    _events = BehaviorSubject<RoomEvent>();
    listener.listen(_events!.add);
    log('LiveKit: Room listeners set up.');
  }

  void _cleanupListeners() {
    _events?.close();
    _events = null;
    listener.cancelAll();
    state.value?.removeListener(_setupListener);
    log('LiveKit: Room listeners cleaned up.');
  }

  Future<void> _dispose() async {
    log('LiveKit: Disposing Notifier...');
    await _disconnect();
  }

  bool get _isConnected {
    final room = state.value;
    final hasValue = state.hasValue;
    final isConnected = room?.connectionState == ConnectionState.connected;
    return hasValue && isConnected;
  }
}

extension LiveKitServiceX on Room {
  bool get isConnected => connectionState == ConnectionState.connected;
}
