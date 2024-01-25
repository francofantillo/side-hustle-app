import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/state_management/models/select_location_model.dart';
import 'package:side_hustle/state_management/providers/events/events_provider.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(EventsState());

  Future resetEventsBloc() async {
    emit(EventsState());
  }

  final prefs = SharedPreferencesHelper.instance;

  SelectLocationModel? selectLocationModel;
  TextEditingController dateTextController = TextEditingController();
  TextEditingController startTimeTextController = TextEditingController();
  TextEditingController endTimeTextController = TextEditingController();
  TextEditingController eventNameTextController = TextEditingController();
  TextEditingController eventLocationTextController = TextEditingController();
  TextEditingController eventPurposeTextController = TextEditingController();
  TextEditingController eventThemeTextController = TextEditingController();
  TextEditingController eventVendorTextController = TextEditingController();
  TextEditingController eventPriceTextController = TextEditingController();
  TextEditingController eventAvailableTextController = TextEditingController();

  initPostEventControllers() {
    dateTextController = TextEditingController();
    startTimeTextController = TextEditingController();
    endTimeTextController = TextEditingController();
    eventNameTextController = TextEditingController();
    eventLocationTextController = TextEditingController();
    eventPurposeTextController = TextEditingController();
    eventThemeTextController = TextEditingController();
    eventVendorTextController = TextEditingController();
    eventPriceTextController = TextEditingController();
    eventAvailableTextController = TextEditingController();
    state.itemImagesFile = null;
    selectLocationModel = null;
  }

  /// Select Location
  Future selectLocation(
      {required BuildContext context, required bool mounted}) async {
    final SelectLocationModel? location =
        await AppUtils.selectLocation(context: context, mounted: mounted);

    if (location != null) {
      eventLocationTextController.text = location.locationAddress ?? "";
      selectLocationModel = location;
    }
  }

  /// Select Multiple Images
  Future selectMultiImages() async {
    List<File>? images =
        await ImagePickerService.selectMultipleImagesFromGallery();
    if (images != null && images.isNotEmpty) {
      emit(state.copyWith(itemImagesFile: images));
    }
  }

  // final objEventList = objEvent?.events?[index];
  // objEventList?.isFavourite = isFavourite;
  /// Set Fav
  Future setFave({required int index, required int isFavourite}) async {
    final objEvent = state.eventsModel;
    objEvent?.events?[index].isFavourite = isFavourite;
    emit(state.copyWith(eventsModel: objEvent));
  }

  /// Get Events
  Future getEventsCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(eventsLoading: true, eventsModel: EventsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getEventsProvider(apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    emit(state.copyWith(eventsLoading: false));
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        print(
            "status: ${response.data["status"]} response: ${eventsModel.events}");
        // AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsModel: eventsModel));
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get Event Details
  Future getEventDetailsCubit({
    required BuildContext context,
    required bool mounted,
    required int? id,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(
        eventsDetailLoading: true, eventsDetailModel: EventsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getEventDetailsProvider(id: id, apiToken: token);

    EasyLoading.dismiss();
    emit(state.copyWith(eventsDetailLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        print(
            "status: ${response.data["status"]} response: ${eventsModel.events}");
        // AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsDetailModel: eventsModel));
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get Is Interested Event
  Future getIsInterestedEventCubit({
    required BuildContext context,
    required bool mounted,
    required int? id,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final token = await prefs.getToken();

    final response =
        await getIsInterestedEventProvider(id: id, apiToken: token);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        print(
            "status: ${response.data["status"]} response: ${eventsModel.events}");
        // AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsDetailModel: eventsModel));
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Post an Event
  Future<int> postAnEventCubit(
      {required BuildContext context,
      required int planId,
      required bool mounted}) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final String? lat = selectLocationModel?.lat?.toString();
    final String? lng = selectLocationModel?.lng?.toString();
    print("lat: $lat");
    print("lng: $lng");
    final token = await prefs.getToken();

    final response = await postAnEventProvider(
      apiToken: token,
      name: eventNameTextController.text,
      location: eventLocationTextController.text,
      // lat: "24.87804237639414",
      // lng: "67.06849843858433",
      lat: lat,
      lng: lng,
      images: state.itemImagesFile,
      date: dateTextController.text,
      startTime: DateTimeConversions.convertTo24HourFormatUTC(
          startTimeTextController.text),
      endTime: DateTimeConversions.convertTo24HourFormatUTC(
          endTimeTextController.text),
      purpose: eventPurposeTextController.text,
      theme: eventThemeTextController.text,
      vendorsListString: eventVendorTextController.text,
      price: eventPriceTextController.text,
      paymentType: "card",
      availableAttractionsString: eventAvailableTextController.text,
      // planId: "1",
      planId: planId.toString(),
    );

    EasyLoading.dismiss();
    emit(state.copyWith(eventsDetailLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        print(
            "status: ${response.data["status"]} response: ${eventsModel.events}");
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsDetailModel: eventsModel));
        if (mounted) {
          Navigator.pop(context);
        }
        return 1;
      }

      /// Failed
      else {
        // print(
        //     "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }
}
