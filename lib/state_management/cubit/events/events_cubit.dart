import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/state_management/providers/events/events_provider.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(EventsState());

  Future resetEventsBloc() async {
    emit(EventsState());
  }

  final prefs = SharedPreferencesHelper.instance;

  /// Get Events
  Future getEventsCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(eventsLoading: true, eventsModel: EventsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getEventsProvider(apiToken: token);

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
    emit(state.copyWith(eventsDetailLoading: true, eventsDetailModel: EventsModel()));
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
}
