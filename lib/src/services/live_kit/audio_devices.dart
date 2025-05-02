import 'dart:async';
import 'dart:developer';

import 'package:livekit_client/livekit_client.dart';
import 'package:meno_flutter/src/services/live_kit/selected_audio_device.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_devices.g.dart';

@Riverpod(keepAlive: true, dependencies: [SelectedAudioDevice])
class AudioDevices extends _$AudioDevices {
  StreamSubscription<List<MediaDevice>>? _devicesSubscription;

  @override
  Future<List<MediaDevice>> build() async {
    // Clean up listener when the provider is disposed
    ref.onDispose(() {
      _devicesSubscription?.cancel();
      log('AudioInputDevicesProvider disposed, canceling listener.');
    });

    // Initial load
    final devices = await Hardware.instance.enumerateDevices();
    final audioInputs = _filterAudioInputs(devices);

    // Start listening for changes *after* initial load
    _listenForDeviceChanges();

    // Set the initial default selection *after* the first list is available
    // Use Future.microtask to avoid modifying another provider during build
    if (audioInputs.isNotEmpty) {
      await Future.microtask(() {
        // Check if a selection hasn't already been made
        if (ref.read(selectedAudioDeviceProvider) == null) {
          log('Setting initial audio device: ${audioInputs.first.label}');
          final notifier = ref.read(selectedAudioDeviceProvider.notifier);
          notifier.selectDevice(audioInputs.first);
        }
      });
    }

    log('Initial audio devices loaded: ${audioInputs.length}');
    return audioInputs;
  }

  // Helper to filter devices
  List<MediaDevice> _filterAudioInputs(List<MediaDevice> allDevices) {
    return allDevices.where((d) => d.kind == 'audioinput').toList();
  }

  // Sets up the listener for device changes
  void _listenForDeviceChanges() {
    _devicesSubscription?.cancel();
    _devicesSubscription = Hardware.instance.onDeviceChange.stream.listen(
      (devices) {
        log('Hardware devices changed, reloading audio inputs.');
        final currentInputs = _filterAudioInputs(devices);

        // Update the state with the new list
        state = AsyncData(currentInputs);

        // Handle potential change in selected device
        final currentSelected = ref.read(selectedAudioDeviceProvider);
        final selectedAudioDeviceNotifier = ref.read(
          selectedAudioDeviceProvider.notifier,
        );

        if (currentSelected != null) {
          // Check if the currently selected device is still available
          if (!currentInputs.any(
            (d) => d.deviceId == currentSelected.deviceId,
          )) {
            log('Selected audio device removed, resetting selection.');
            // If not available, reset selection (select first if available)
            selectedAudioDeviceNotifier.selectDevice(
              currentInputs.isNotEmpty ? currentInputs.first : null,
            );
          }
        } else if (currentInputs.isNotEmpty) {
          // If no device was selected, but now devices are available,
          // select the first one.
          log('Devices became available, selecting first audio device.');
          selectedAudioDeviceNotifier.selectDevice(currentInputs.first);
        }
      },
      onError: (dynamic error) {
        log('Error listening to device changes: $error');
        state = AsyncError(error.toString(), StackTrace.current);
      },
    );
  }
}
