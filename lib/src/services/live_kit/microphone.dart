import 'package:meno_flutter/src/services/live_kit/live_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'microphone.g.dart';

// Derived Mic Enabled state (simplifies UI access slightly)
// This just reflects the audioEnabledProvider state but could be more complex
// if needed
@Riverpod(keepAlive: true, dependencies: [LiveKit])
class Microphone extends _$Microphone {
  @override
  bool build() {
    // This provider now primarily reflects if the *local participant* has
    // published audio
    //
    // Watch the main room state to know if connected
    final room = ref.watch(liveKitProvider).value;
    if (room == null) return false;

    // Check the local participant's mic status directly
    // This requires listening to the room state changes
    final isMicEnabled = room.localParticipant?.isMicrophoneEnabled() ?? false;
    return isMicEnabled;
  }

  Future<void> enableMic() async {
    final room = ref.watch(liveKitProvider).value;
    if (room?.localParticipant != null) {
      state = true;
      await room!.localParticipant!.setMicrophoneEnabled(true);
    }
  }

  Future<void> toggleMicMute() async {
    final room = ref.watch(liveKitProvider).value;
    if (room?.localParticipant != null) {
      final currentState = state;
      state = !currentState;
      await room!.localParticipant!.setMicrophoneEnabled(!currentState);
    }
  }
}
