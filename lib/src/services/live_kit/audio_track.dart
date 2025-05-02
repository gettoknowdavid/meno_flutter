import 'dart:developer';

import 'package:livekit_client/livekit_client.dart';
import 'package:meno_flutter/src/services/live_kit/audio_enabled.dart';
import 'package:meno_flutter/src/services/live_kit/selected_audio_device.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_track.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [AudioEnabled, SelectedAudioDevice],
)
class MenoAudioTrack extends _$MenoAudioTrack {
  LocalAudioTrack? _currentTrack;

  @override
  FutureOr<LocalAudioTrack?> build() async {
    final isEnabled = ref.watch(audioEnabledProvider);
    final selectedDevice = ref.watch(selectedAudioDeviceProvider);

    ref.onDispose(() async {
      log('AudioTrackState disposed, stopping track.');
      await stopTrack(); // Ensure track is stopped on disposal
    });

    // Main logic to create/destroy the track based on dependencies
    await _updateTrack(isEnabled: isEnabled, device: selectedDevice);

    // Return the track managed internally
    return _currentTrack;
  }

  Future<void> _updateTrack({
    required bool isEnabled,
    required MediaDevice? device,
  }) async {
    final shouldHaveTrack = isEnabled && device != null;

    if (shouldHaveTrack) {
      // If we should have a track, check if we need to create a new one
      if (_currentTrack == null ||
          _currentTrack!.mediaStreamTrack.label != device.deviceId) {
        log('Creating/Switching audio track for device: ${device.label}');
        await stopTrack();

        try {
          // Create new track
          _currentTrack = await LocalAudioTrack.create(
            AudioCaptureOptions(deviceId: device.deviceId),
          );
          // Don't auto-start here. The LiveKit Room connection logic
          // (FastConnectOptions or publishTrack) should handle starting/publishing.
          // await _currentTrack!.start(); // Usually not needed here

          // Reflect the new track in the state- AsyncNotifier handles AsyncData
          state = AsyncData(_currentTrack);
          log('Audio track created: ${_currentTrack?.sid}');
        } on Exception catch (error, stackTrace) {
          log('Error creating audio track: $error');
          _currentTrack = null;
          state = AsyncError(error, stackTrace);
        }
        // Else: Correct track already exists, do nothing
      } else {
        // If we shouldn't have a track, stop the current one if it exists
        if (_currentTrack != null) {
          log('Audio disabled or device deselected, stopping track.');
          await stopTrack();
          state = const AsyncData(null); // Reflect null track in state
        }
        // Else: No track should exist, and none does, do nothing
      }
    }
  }

  Future<void> stopTrack() async {
    if (_currentTrack != null) {
      final trackToStop = _currentTrack;
      _currentTrack = null;

      try {
        await trackToStop!.stop();
        log('Audio track stopped: ${trackToStop.sid}');
      } on Exception catch (e) {
        log('Error stopping audio track: $e');
        // Decide if you need to surface this error
      }
    }
  }
}
