import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';

class AppUtils {
  /// Easy Loading Config
  static configEasyLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColors.primaryColor
      ..textColor = Colors.white
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..boxShadow = <BoxShadow>[]
      ..maskColor = Colors.black.withOpacity(0.6)
      ..maskColor = Colors.transparent
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  /// Date Picker
  static Future<String?> selectDate(
      {required BuildContext context, required DateTime initialDate}) async {
    String? date;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      print("selectedDate: $picked");
      date = await formatDate(selectedDate: picked);
    }
    return date;
  }

  /// Format Date
  static Future<String> formatDate({required DateTime selectedDate}) async {
    String formattedDate = DateFormat('MM/dd/yyyy').format(selectedDate);
    return formattedDate;
  }

  /// Time Picker
  static TimeOfDay? firstSelectedTime;
  static TimeOfDay? secondSelectedTime;
  static String timeDifference = '';

  static Future<void> selectTime(BuildContext context, bool isFirst) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFirst
          ? firstSelectedTime ?? TimeOfDay.now()
          : secondSelectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isFirst) {
        firstSelectedTime = picked;
        secondSelectedTime =
            null; // Reset second time when selecting the first time
      } else {
        if (firstSelectedTime != null) {
          if (picked.hour > (firstSelectedTime?.hour ?? 0) ||
              (picked.hour == (firstSelectedTime?.hour ?? 0) &&
                  picked.minute > (firstSelectedTime?.minute ?? 0))) {
            secondSelectedTime = picked;
            timeDifference = calculateTimeDifference(
                firstSelectedTime!, secondSelectedTime!);
          } else {
            // Display an error or handle validation in your app
            // For this example, we reset the second time to null
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppValidationMessages.timeValidation)));
            }
            secondSelectedTime = null;
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(AppValidationMessages.firstTimeNotSelected)));
          }
          secondSelectedTime = null;
        }
      }
    }
  }

  static String calculateTimeDifference(
      TimeOfDay startTime, TimeOfDay endTime) {
    final int startMinutes = startTime.hour * 60 + startTime.minute;
    final int endMinutes = endTime.hour * 60 + endTime.minute;
    final int differenceMinutes = endMinutes - startMinutes;
    final int hours = differenceMinutes ~/ 60;
    final int minutes = differenceMinutes % 60;
    return '$hours hours and $minutes minutes';
  }

  static showBottomModalSheet(
      {required BuildContext context, required Widget widget}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.boarderRadiusBottomSheet),
        ),
      ),
      builder: (context) {
        return widget;
      },
    );
  }

  /// Delivery Options List
  static const List<String> items = [
    AppStrings.deliveryOptionPickup,
    AppStrings.deliveryOptionCOD,
  ];

}
