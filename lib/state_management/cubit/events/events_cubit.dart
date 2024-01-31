import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/state_management/models/attendees_model.dart';
import 'package:side_hustle/state_management/models/edit_event_model.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/state_management/models/select_location_model.dart';
import 'package:side_hustle/state_management/providers/events/events_provider.dart';
import 'package:side_hustle/utils/app_strings.dart';
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
      // if(images.length > 4) {
      //   AppUtils.showToast(AppStrings.errorMessageMultiImagesSelectedLimit);
      // } else {
      //   emit(state.copyWith(itemImagesFile: images));
      // }
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
    emit(state.copyWith(
        eventsLoading: true,
        eventsTempList: [],
        searching: false,
        eventsModel: EventsModel()));
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
        // AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsModel: eventsModel));
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Search Events
  searchEvents({
    String? value,
  }) {
    emit(state.copyWith(eventsTempList: [], searching: true));
    final List<EventsData>? originalList = state.eventsModel?.events;
    final List<EventsData> tempList = [];
    print("searchList: $value");
    state.eventsTempList?.clear();
    if (value != null) {
      emit(state.copyWith(searching: true));
      for (int i = 0; i < (originalList?.length ?? 0); i++) {
        String name =
            originalList?[i].name != null ? "${originalList![i].name}" : '';
        if (name.toLowerCase().contains(value.toLowerCase())) {
          tempList.add(originalList![i]);
        }
      }
      if (tempList.isNotEmpty) {
        print("searchList tempList: ${tempList[0].name}");
        final tempSearchEventList = tempList;
        emit(state.copyWith(eventsTempList: tempSearchEventList));
      } else if (value.isEmpty) {
        print("searchList tempList is empty");
        emit(state.copyWith(eventsTempList: originalList));
      } else {
        emit(state.copyWith(eventsTempList: []));
      }
    }
  }

  /// Get Event Details
  Future getEventDetailsCubit({
    required BuildContext context,
    required bool mounted,
    required int? id,
    int index = 0,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(
        eventsDetailLoading: true,
        eventsDetailModel: EventsModel(),
        myEventsIndex: index));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getEventDetailsProvider(id: id, apiToken: token);

    EasyLoading.dismiss();
    emit(state.copyWith(eventsDetailLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        // AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsDetailModel: eventsModel));
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
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

        // AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsDetailModel: eventsModel));
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  setVendorAndAvailableAttractionList(
      {required List vendorList, required List availableAttraction}) {
    emit(state.copyWith(
        vendorList: vendorList, availableAttractionsList: availableAttraction));
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

    late String vendorListString;

    for (int i = 0; i < (state.vendorList?.length ?? 0); i++) {
      print("Hobbies Length: ${state.vendorList?.length}");
      if (i == 0) {
        if ((state.vendorList!.length - 1) == i) {
          vendorListString = "${state.vendorList![i]}";
        } else {
          vendorListString = "${state.vendorList![i]},";
        }
      } else {
        if ((state.vendorList!.length - 1) == i) {
          vendorListString += "${state.vendorList![i]}";
        } else {
          vendorListString += "${state.vendorList![i]},";
        }
      }
    }

    if ((state.vendorList?.length ?? 0) == 0) {
      vendorListString = "";
    }

    late String availableAttractionListString;

    for (int i = 0; i < (state.availableAttractionsList?.length ?? 0); i++) {
      print("Hobbies Length: ${state.availableAttractionsList?.length}");
      if (i == 0) {
        if ((state.availableAttractionsList!.length - 1) == i) {
          availableAttractionListString =
              "${state.availableAttractionsList![i]}";
        } else {
          availableAttractionListString =
              "${state.availableAttractionsList![i]},";
        }
      } else {
        if ((state.availableAttractionsList!.length - 1) == i) {
          availableAttractionListString +=
              "${state.availableAttractionsList![i]}";
        } else {
          availableAttractionListString +=
              "${state.availableAttractionsList![i]},";
        }
      }
    }

    if ((state.availableAttractionsList?.length ?? 0) == 0) {
      availableAttractionListString = "";
    }

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
      startTime: DateTimeConversions.convertTo24HourFormat(
          startTimeTextController.text),
      endTime:
          DateTimeConversions.convertTo24HourFormat(endTimeTextController.text),
      purpose: eventPurposeTextController.text,
      theme: eventThemeTextController.text,
      // vendorsListString: eventVendorTextController.text,
      vendorsListString: vendorListString,
      price: eventPriceTextController.text,
      paymentType: "card",
      // availableAttractionsString: eventAvailableTextController.text,
      availableAttractionsString: availableAttractionListString,
      // planId: "1",
      planId: planId.toString(),
    );

    EasyLoading.dismiss();
    emit(state.copyWith(eventsDetailLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(eventsDetailModel: eventsModel));
        if (mounted) {
          Navigator.pop(context);
        }
        print("id: ${response.data['data']['id']}");

        return response.data['data']['id'] ?? 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }

  /// Edit an Event
  Future<int> editAnEventCubit(
      {required BuildContext context,
      required int planId,
      required bool mounted}) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    String? lat;
    String? lng;
    if (selectLocationModel != null) {
      lat = selectLocationModel?.lat?.toString();
      lng = selectLocationModel?.lng?.toString();
    } else {
      lat = state.editEventModel?.eventDetails?.lat;
      lng = state.editEventModel?.eventDetails?.lng;
    }
    print("editEventModel lat: ${state.editEventModel?.eventDetails?.lat}");
    print("editEventModel lng: ${state.editEventModel?.eventDetails?.lng}");
    print("editAnEventCubit lat: $lat");
    print("lng: $lng");
    final token = await prefs.getToken();

    late String vendorListString;

    for (int i = 0; i < (state.vendorList?.length ?? 0); i++) {
      print("Hobbies Length: ${state.vendorList?.length}");
      if (i == 0) {
        if ((state.vendorList!.length - 1) == i) {
          vendorListString = "${state.vendorList![i]}";
        } else {
          vendorListString = "${state.vendorList![i]},";
        }
      } else {
        if ((state.vendorList!.length - 1) == i) {
          vendorListString += "${state.vendorList![i]}";
        } else {
          vendorListString += "${state.vendorList![i]},";
        }
      }
    }

    if ((state.vendorList?.length ?? 0) == 0) {
      vendorListString = "";
    }

    late String availableAttractionListString;

    for (int i = 0; i < (state.availableAttractionsList?.length ?? 0); i++) {
      print("Hobbies Length: ${state.availableAttractionsList?.length}");
      if (i == 0) {
        if ((state.availableAttractionsList!.length - 1) == i) {
          availableAttractionListString =
              "${state.availableAttractionsList![i]}";
        } else {
          availableAttractionListString =
              "${state.availableAttractionsList![i]},";
        }
      } else {
        if ((state.availableAttractionsList!.length - 1) == i) {
          availableAttractionListString +=
              "${state.availableAttractionsList![i]}";
        } else {
          availableAttractionListString +=
              "${state.availableAttractionsList![i]},";
        }
      }
    }

    if ((state.availableAttractionsList?.length ?? 0) == 0) {
      availableAttractionListString = "";
    }

    final response = await editAnEventProvider(
      apiToken: token,
      eventId: state.editEventModel?.eventDetails?.eventId,
      name: eventNameTextController.text,
      location: eventLocationTextController.text,
      // lat: "24.87804237639414",
      // lng: "67.06849843858433",
      lat: lat,
      lng: lng,
      images: state.itemImagesFile,
      date: dateTextController.text,
      startTime: DateTimeConversions.convertTo24HourFormat(
          startTimeTextController.text),
      endTime:
          DateTimeConversions.convertTo24HourFormat(endTimeTextController.text),
      purpose: eventPurposeTextController.text,
      theme: eventThemeTextController.text,
      // vendorsListString: eventVendorTextController.text,
      vendorsListString: vendorListString,
      price: eventPriceTextController.text,
      paymentType: "card",
      // availableAttractionsString: eventAvailableTextController.text,
      availableAttractionsString: availableAttractionListString,
      // planId: "1",
      planId: planId.toString(),
    );

    EasyLoading.dismiss();
    emit(state.copyWith(eventsDetailLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        AppUtils.showToast(response.data["message"]);
        final myEvent = state.myEventsModel?.events?[state.myEventsIndex];
        myEvent?.name = eventsModel.eventDetails?.eventName;
        myEvent?.location = eventsModel.eventDetails?.location;
        myEvent?.price = eventsModel.eventDetails?.price;
        myEvent?.image = (eventsModel.eventDetails?.images?.length == null ||
                eventsModel.eventDetails!.images!.isEmpty)
            ? null
            : eventsModel.eventDetails?.images?[0].image;

        final events = state.myEventsModel;
        events?.events?[state.myEventsIndex] = myEvent!;

        emit(state.copyWith(
            eventsDetailModel: eventsModel, myEventsModel: events));
        print("id: ${response.data['data']['id']}");

        return response.data['data']['id'] ?? 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }

  /// Get My Events
  Future getMyEventsCubit({
    required BuildContext context,
    required bool mounted,
    required String status,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(myEventsLoading: true, myEventsModel: EventsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getMyEventsProvider(status: status, apiToken: token);

    EasyLoading.dismiss();
    emit(state.copyWith(myEventsLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel myEventsModel = EventsModel.fromJson(response.data);
        emit(state.copyWith(myEventsModel: myEventsModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get Attendees
  Future getAttendeesCubit({
    required BuildContext context,
    required bool mounted,
    required String type,
    required String? eventId,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(
        attendeesModelLoading: true, attendeesModel: AttendeesModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getAttendeesProvider(
        eventId: eventId, type: type, apiToken: token);

    EasyLoading.dismiss();
    emit(state.copyWith(attendeesModelLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        AttendeesModel attendeesModel = AttendeesModel.fromJson(response.data);
        emit(state.copyWith(attendeesModel: attendeesModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Update Attendees
  Future updateAttendeesCubit({
    required BuildContext context,
    required bool mounted,
    required String status,
    required String? eventId,
    required String? attendeesId,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    // emit(state.copyWith(
    //     attendeesModelLoading: true, attendeesModel: AttendeesModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await updateAttendeesProvider(
        attendeesId: attendeesId,
        eventId: eventId,
        status: status,
        apiToken: token);

    EasyLoading.dismiss();
    emit(state.copyWith(attendeesModelLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        AttendeesModel attendeesModel = AttendeesModel.fromJson(response.data);
        AppUtils.showToast(attendeesModel.message);
        emit(state.copyWith(attendeesModel: attendeesModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get Edit Event
  Future<EventsModel?> getEditEventCubit({
    required BuildContext context,
    required bool mounted,
    required int? id,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(editEventModel: EventsModel(), editEventLoading: true));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getEditEventProvider(id: id, apiToken: token);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        EventsModel eventsModel = EventsModel.fromJson(response.data);
        emit(state.copyWith(
            editEventModel: eventsModel, editEventLoading: false));
        print("editEventModel lat: ${state.editEventModel?.eventDetails?.lat}");
        print("editEventModel lng: ${state.editEventModel?.eventDetails?.lng}");
        return eventsModel;
      }

      /// Failed
      else {
        emit(state.copyWith(editEventLoading: false));
        AppUtils.showToast(response.data["message"]);
        return null;
      }
    } else {
      emit(state.copyWith(editEventLoading: false));
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return null;
    }
  }
}
