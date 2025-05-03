import 'package:intl/intl.dart';

/// Formats a Duration component (hours, minutes, seconds) with padding.
String formatTimerUnit(int value) {
  return value.toString().padLeft(2, '0');
}

extension DurationFormatting on Duration {
  String get hoursFormatted => formatTimerUnit(inHours);
  String get minutesFormatted => formatTimerUnit(inMinutes.remainder(60));
  String get secondsFormatted => formatTimerUnit(inSeconds.remainder(60));

  String get timeAgo => DateHelpers.getTimeAgo(this);
}

// --- Or keep _calculateTime similar to before ---
// enum TimerUnit { hrs, mins, secs }

// String calculateTime(Duration time, TimerUnit unit) {
//   final value = switch (unit) {
//     TimerUnit.hrs => time.inHours,
//     TimerUnit.mins => time.inMinutes.remainder(60),
//     TimerUnit.secs => time.inSeconds.remainder(60),
//   };
//   return value.toString().padLeft(2, '0');
// }

class DateHelpers {
  static String getTimeAgo(Duration duration) {
    final now = DateTime.now();
    final dateTime = now.subtract(duration);
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just started';
    } else if (difference.inMinutes < 60) {
      return 'Started ${difference.inMinutes} mins ago';
    } else if (difference.inHours < 24) {
      return 'Started ${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return 'Started ${difference.inDays} days ago';
    } else {
      // Consider using intl package for more robust formatting
      return DateFormat.yMd().format(dateTime);
    }
  }
}
