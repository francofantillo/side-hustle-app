import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:side_hustle/base_widget/base_widget.dart';
import 'package:side_hustle/state_management/models/select_location_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_api_headers/google_api_headers.dart';

class AppUtils {
  /// Easy Loading Config
  static configEasyLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingFour
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColors.primaryColor
      ..textColor = Colors.white
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..boxShadow = <BoxShadow>[]
      ..maskColor = Colors.black.withOpacity(0.6)
      ..maskColor = Colors.transparent
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  /// Launch Map
  static launchMap({double? lat, double? lng, String? shopName}) async {
    if (Platform.isIOS) {
      if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
        await MapLauncher.showMarker(
          mapType: MapType.google,
          coords: Coords(lat ?? 37.759392, lng ?? -122.5107336),
          title: shopName ?? "   ",
        );
        return;
      } else if (await MapLauncher.isMapAvailable(MapType.apple) ?? false) {
        await MapLauncher.showMarker(
          mapType: MapType.apple,
          coords: Coords(lat ?? 37.759392, lng ?? -122.5107336),
          title: shopName ?? "   ",
        );
      }
    } else {
      if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
        await MapLauncher.showMarker(
          mapType: MapType.google,
          coords: Coords(lat ?? 37.759392, lng ?? -122.5107336),
          title: shopName ?? "",
        );
      }
    }
  }

  /// Get Current Location
  static Future<SelectLocationModel?> getCurrentLocation() async {
    try {
      // Request permission to access location
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        showToast("Permission denied");
        return null;
      }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get the address from the current location
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return SelectLocationModel(
          locationAddress: placemarks.first.street,
          lat: position.latitude,
          lng: position.longitude);
    } catch (e) {
      // Handle any exceptions that might occur
      print(e.toString());
      return null;
    }
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

  static Future<String?> selectCardExpiry(
      {required BuildContext context}) async {
    print("called select date");
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1800),
      lastDate: DateTime.now().add(const Duration(days: 3000)),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return DateFormat(AppStrings.cardExpiryFormat).format(selectedDate);
    }
    return null;
  }

  /// Format Date
  static Future<String> formatDate({required DateTime selectedDate}) async {
    String formattedDate = DateFormat('MM/dd/yyyy').format(selectedDate);
    // String formattedDate = DateFormat('dd MMM, y').format(selectedDate);
    return formattedDate;
  }

  /// Format Date
  static String formatDateView({required DateTime selectedDate}) {
    // String formattedDate = DateFormat('MM/dd/yyyy').format(selectedDate);
    String formattedDate = DateFormat('dd MMMM, y').format(selectedDate);
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
        if (secondSelectedTime != null) {
          if (secondSelectedTime!.hour > (picked.hour ?? 0) ||
              (secondSelectedTime!.hour == (picked.hour ?? 0) &&
                  secondSelectedTime!.minute > (picked.minute ?? 0))) {
            firstSelectedTime = picked;
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppValidationMessages.timeValidation)));
            }
          }
        } else {
          firstSelectedTime = picked;
        }
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
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(AppValidationMessages.timeValidation)));
            }
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

  static String? calculateTotalHours() {
    if (firstSelectedTime != null && secondSelectedTime != null) {
      DateTime dateTime1 = DateTime(
          2022, 1, 1, firstSelectedTime!.hour, firstSelectedTime!.minute);
      DateTime dateTime2 = DateTime(
          2022, 1, 1, secondSelectedTime!.hour, secondSelectedTime!.minute);

      Duration difference = dateTime2.difference(dateTime1);
      double hoursDifference = difference.inMinutes / 60;

      // Display the total difference in hours with minutes as decimal points
      print('Total time difference: $hoursDifference hours');
      return hoursDifference.toStringAsFixed(2);
      // return hoursDifference.toString();
    } else {
      return null;
    }
  }

  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final outputFormat = DateFormat('h:mm a');
    final time12 = outputFormat.format(dateTime);
    return time12;
  }

  static TimeOfDay convertToTimeOfDay(String time24) {
    final inputFormat = DateFormat('HH:mm:ss');
    final dateTime = inputFormat.parse(time24);

    return TimeOfDay.fromDateTime(dateTime);
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

  static void showToast(String? message) {
    FToast fToast = FToast();
    fToast.init(BaseWidget.globalKey.currentContext!);
    Fluttertoast.showToast(
      textColor: AppColors.whiteColor,
      msg: message ?? "",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: AppColors.primaryColor,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
    );
  }

  static launchURL({required String url}) async {
    // final pdfUrl = Uri.parse('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf');
    final urlLaunch = Uri.parse(url);

    if (await canLaunchUrl(urlLaunch)) {
      await launchUrl(urlLaunch);
    } else {
      throw 'Could not launch $urlLaunch';
    }
  }

  /// Select Location
  static Future<SelectLocationModel?> selectLocation(
      {required BuildContext context, required bool mounted}) async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Constants.googlePlacesApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: 'en',
      components: [const Component(Component.country, 'us')],
      // components: [const Component(Component.country, 'pk')],
      resultTextStyle: Theme.of(context).textTheme.titleMedium,
    );

    if (mounted) {
      EasyLoading.show();
      final PlacesDetailsResponse? detail =
          await displayPrediction(p, ScaffoldMessenger.of(context));
      final geometry = detail?.result.geometry!;
      final lat = geometry?.location.lat;
      final lng = geometry?.location.lng;

      print('${p?.description} - $lat/$lng');
      if (p?.description != null) {
        EasyLoading.dismiss();
        return SelectLocationModel(
            locationAddress: p?.description, lat: lat, lng: lng);
      }
    }
    EasyLoading.dismiss();
    return null;
  }

  static Future<PlacesDetailsResponse?> displayPrediction(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return null;
    }

    // get detail (lat/lng)
    final _places = GoogleMapsPlaces(
      apiKey: Constants.googlePlacesApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await _places.getDetailsByPlaceId(p.placeId!);
    // final geometry = detail.result.geometry!;
    // final lat = geometry.location.lat;
    // final lng = geometry.location.lng;

    // messengerState.showSnackBar(
    //   SnackBar(
    //     content: Text('${p.description} - $lat/$lng'),
    //   ),
    // );

    return detail;
  }
}
