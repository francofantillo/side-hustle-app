import 'package:intl/src/intl/date_format.dart';

class DateTimeConversions {
  static String convertTo24HourFormat(String time24) {
    final inputFormat = DateFormat('h:mm a');
    final outputFormat = DateFormat('HH:mm');

    final dateTime = inputFormat.parse(time24);
    final time12 = outputFormat.format(dateTime);

    return time12;
  }

  static String? convertTo24HourFormatUTC(String? time12) {
    // 1970-01-01T01:02:00.000Z
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('HH:mm');

    /// Converting time to UTC
    final time = convertToUTCTime(time: time12);

    final dateTime = inputFormat.parse(time!);
    final time24 = outputFormat.format(dateTime);
    print("convertToUTCTime: $time24");

    return time24;
  }

  static String? convertToUTCTime({required String? time}) {
    if (time != null) {
      // DateTime? dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true);
      DateTime? dateTime = DateFormat("hh:mm a").parse(time, false);

      print("dateTime: $dateTime");
      return dateTime.toUtc().toIso8601String();
    }
    return null;
  }

  static String? convertToLocal12HourFormat(String? time12) {
    // 1970-01-01T01:02:00.000Z
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('hh:mm a');

    /// Converting time to Local
    final time = convertToLocalTime(time: time12);

    final dateTime = inputFormat.parse(time!);
    final time24 = outputFormat.format(dateTime);
    print("convertToLocalTime: $time24");

    return time24;
  }

  static String? convertToLocalTime({required String? time}) {
    if (time != null) {
      DateTime? dateTime = DateFormat("HH:mm:ss").parse(time, true);

      print("dateTime: $dateTime");
      return dateTime.toLocal().toIso8601String();
    }
    return null;
  }
}
