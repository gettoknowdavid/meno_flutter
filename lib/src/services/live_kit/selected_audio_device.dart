//
// ignore_for_file: use_setters_to_change_properties

import 'package:livekit_client/livekit_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_audio_device.g.dart';

/// Provider that holds the currently selected audio input device.
/// Can be updated by UI or other logic.
@Riverpod(keepAlive: true, dependencies: [])
class SelectedAudioDevice extends _$SelectedAudioDevice {
  @override
  MediaDevice? build() => null;

  // Optional: Method to explicitly set the device
  void selectDevice(MediaDevice? device) {
    state = device;
  }
}
