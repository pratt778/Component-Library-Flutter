import 'dart:async';

/// Delays invoking an action until after a quiet period has elapsed. Useful for
/// search-as-you-type, input throttling, and resizing handlers.
class Debouncer {
  Debouncer({this.duration = const Duration(milliseconds: 300)});

  final Duration duration;
  Timer? _timer;

  /// Returns true if a timer is currently active.
  bool get isRunning => _timer?.isActive ?? false;

  /// Schedules [action]; cancels any previously scheduled run.
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Cancels the pending action, if any.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Disposes of the debouncer and cancels active timers.
  void dispose() {
    cancel();
  }
}
