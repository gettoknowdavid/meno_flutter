//
// ignore_for_file: use_setters_to_change_properties

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_enabled.g.dart';

/// Provider indicating whether audio capture/track should be enabled.
/// Defaults to true.
@Riverpod(keepAlive: true, dependencies: [])
class AudioEnabled extends _$AudioEnabled {
  @override
  bool build() => true; // Default to enabled

  void setEnabled(bool enabled) {
    state = enabled;
  }

  void toggle() {
    state = !state;
  }
}
