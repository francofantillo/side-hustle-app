import 'package:intl/src/intl/date_format.dart';

class DateTimeConversions {
  static const timeStampFormat = "yyyy-MM-ddTHH:mm:ss";

  static String convertTo24HourFormat(String time24) {
    final inputFormat = DateFormat('h:mm a');
    final outputFormat = DateFormat('HH:mm');

    final dateTime = inputFormat.parse(time24);
    final time12 = outputFormat.format(dateTime);

    return time12;
  }

  static String notificationsTimeAMPM({String? timeStamp}) {
    if (timeStamp != null) {
      DateTime utcTime = DateFormat(timeStampFormat).parse(timeStamp, true);
      DateTime localTime = utcTime.toLocal();

      print('UTC Time Stamp: $utcTime');
      print('Local Time Stamp: $localTime');
      final time = convertTo12HourFormat(localTime.toIso8601String());
      print('Local Time: $time');
      return time;
    } else {
      return "";
    }
  }

  static String formatDate({required DateTime selectedDate}) {
    String formattedDate = DateFormat('dd MMM, y').format(selectedDate);
    return formattedDate;
  }

  static String notificationsDate({String? timeStamp}) {
    if (timeStamp != null) {
      String utcTimeString = timeStamp;

      DateTime utcTime = DateTime.parse(utcTimeString);
      DateTime localTime = utcTime.toLocal();

      print('UTC Time Stamp: $utcTime');
      print('Local Time Stamp: $localTime');
      final date = formatDate(selectedDate: localTime);
      print('Local Date: $date');
      return date;
    } else {
      return "";
    }
  }

  static bool isPastDate({String? timeStamp}) {
    // Replace this timestamp with your actual timestamp
    if (timeStamp != null) {
      DateTime utcTime = DateFormat(timeStampFormat).parse(timeStamp, true);
      DateTime localTime = utcTime.toLocal();

      // String timestampString = timeStamp;

      // Parse the timestamp string into a DateTime object
      // DateTime timestamp = DateTime.parse(timestampString);

      // Get the current date and time
      DateTime now = DateTime.now();

      // Compare the date part only (ignoring time)
      int dateComparison =
          DateTime(localTime.year, localTime.month, localTime.day)
              .compareTo(DateTime(now.year, now.month, now.day));

      if (dateComparison < 0) {
        print('The timestamp is in the past.');
        return true;
      } else if (dateComparison == 0) {
        print('The timestamp is today.');
        return false;
      } else {
        print('The timestamp is in the future.');
        return false;
      }
    } else {
      return false;
    }
  }

  static String convertTo12HourFormat(String? time12) {
    // final inputFormat = DateFormat('HH:mm:ss');
    final inputFormat = DateFormat('HH:mm');
    final outputFormat = DateFormat('hh:mm a');

    if (time12 == null) {
      return "";
    }

    final dateTime = inputFormat.parse(time12);
    final time24 = outputFormat.format(dateTime);
    print("convertTo12HoursTime: $time24");

    return time24;
  }

  /*
  Not Needed Yet
   */
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
