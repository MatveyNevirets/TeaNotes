abstract class Utils {
  static String transformTime(int? seconds) {
    if (seconds != null) {
      final minutesTimer = ((seconds / 60) % 60).floor();
      final secondsTimer = (seconds % 60);
      return "${minutesTimer.toString().padLeft(2, '0')}:${secondsTimer.toString().padLeft(2, '0')}";
    } else {
      return "00:00";
    }
  }
}
