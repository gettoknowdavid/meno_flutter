import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_notifier.g.dart';

typedef TimerState = ({Duration elapsed, bool isRunning});

@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {
  Timer? _timer;

  @override
  TimerState build() {
    ref.onDispose(() {
      _timer?.cancel();
      log('TimerNotifier disposed, timer cancelled.');
    });

    return (elapsed: Duration.zero, isRunning: false);
  }

  /// Sets the initial elapsed time based on a start time and starts the timer.
  void setAndStart([DateTime? startTime]) {
    _setElapsedTime(startTime);
    start();
  }

  /// Sets the initial elapsed time based on a start time, but doesn't start it.
  void setInitialTime([DateTime? startTime]) {
     _setElapsedTime(startTime);
  }

  /// Starts the timer.
  /// If already running, this does nothing.
  void start() {
    if (_timer?.isActive ?? false) return; // Timer already running

    // Ensure isRunning is true immediately, even before the first tick
    state = (elapsed: state.elapsed, isRunning: true);

    _timer?.cancel(); // Cancel any existing timer just in case
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Update state on each tick
      // Read the *current* elapsed time from state before incrementing
      final newElapsed = state.elapsed + const Duration(seconds: 1);
      state = (elapsed: newElapsed, isRunning: true);
    });
  }

  /// Stops the timer.
  void stop() {
    _timer?.cancel();
    _timer = null;
    // Update state to reflect stopped status
    state = (elapsed: state.elapsed, isRunning: false);
  }

  /// Stops the timer and resets the elapsed time to zero.
  void reset() {
    _timer?.cancel();
    _timer = null;
    // Reset state to initial values
    state = (elapsed: Duration.zero, isRunning: false);
  }

  /// Calculates and sets the elapsed time based on an optional start time.
  void _setElapsedTime([DateTime? startTime]) {
    if (startTime == null) return;
    final now = DateTime.now();
    // Ensure startTime is not in the future, or handle as needed
    final duration = now.difference(startTime).abs();
    // Update only the elapsed part, keep isRunning as it was
    state = (elapsed: duration, isRunning: state.isRunning);
  }
}
