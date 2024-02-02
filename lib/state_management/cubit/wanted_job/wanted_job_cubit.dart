import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/models/jobs_model.dart';
import 'package:side_hustle/state_management/models/select_location_model.dart';
import 'package:side_hustle/state_management/providers/wanted_jobs/wanted_job_provider.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

part 'wanted_job_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsState());

  Future resetWantedJobBloc() async {
    emit(JobsState());
  }

  final prefs = SharedPreferencesHelper.instance;

  SelectLocationModel? selectLocationModel;
  TextEditingController dateTextController = TextEditingController();
  TextEditingController startTimeTextController = TextEditingController();
  TextEditingController endTimeTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController areaCodeTextController = TextEditingController();
  TextEditingController additionalInfoTextController = TextEditingController();
  String? totalHours;

  initPostJobControllers() {
    dateTextController = TextEditingController();
    startTimeTextController = TextEditingController();
    endTimeTextController = TextEditingController();
    titleTextController = TextEditingController();
    locationTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    priceTextController = TextEditingController();
    areaCodeTextController = TextEditingController();
    additionalInfoTextController = TextEditingController();
    state.itemImagesFile = null;
    selectLocationModel = null;
    totalHours = null;
  }

  /// Select Location
  Future selectLocation(
      {required BuildContext context, required bool mounted}) async {
    final SelectLocationModel? location =
    await AppUtils.selectLocation(context: context, mounted: mounted);

    if (location != null) {
      locationTextController.text = location.locationAddress ?? "";
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

  /// Get Wanted Jobs
  Future getWantedJobsCubit(
      {required BuildContext context,
        required bool mounted,
        required String type}) async {
    emit(state.copyWith(
        jobsLoading: true,
        wantedJobsTempList: [],
        searching: false,
        jobsModel: JobsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getWantedJobsProvider(type: type, apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    emit(state.copyWith(jobsLoading: false));
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        JobsModel jobsModel = JobsModel.fromJson(response.data);
        emit(state.copyWith(jobsModel: jobsModel));
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
  searchWantedJobs({
    String? value,
  }) {
    emit(state.copyWith(wantedJobsTempList: [], searching: true));
    final List<JobsData>? originalList = state.jobsModel?.jobs;
    final List<JobsData> tempList = [];
    print("searchList: $value");
    state.wantedJobsTempList?.clear();
    if (value != null) {
      emit(state.copyWith(searching: true));
      for (int i = 0; i < (originalList?.length ?? 0); i++) {
        String name =
        originalList?[i].title != null ? "${originalList![i].title}" : '';
        if (name.toLowerCase().contains(value.toLowerCase())) {
          tempList.add(originalList![i]);
        }
      }
      if (tempList.isNotEmpty) {
        print("searchList tempList: ${tempList[0].title}");
        final tempSearchEventList = tempList;
        emit(state.copyWith(wantedJobsTempList: tempSearchEventList));
      } else if (value.isEmpty) {
        print("searchList tempList is empty");
        emit(state.copyWith(wantedJobsTempList: originalList));
      } else {
        emit(state.copyWith(wantedJobsTempList: []));
      }
    }
  }

  /// Get Jobs Detail
  Future getJobsDetailCubit(
      {required BuildContext context,
        required bool mounted,
        required String? jobId}) async {
    emit(state.copyWith(jobsDetailLoading: true, jobsDetailModel: JobsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getJobsDetailProvider(jobId: jobId, apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    emit(state.copyWith(jobsDetailLoading: false));
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        JobsModel jobsModel = JobsModel.fromJson(response.data);
        emit(state.copyWith(jobsDetailModel: jobsModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Post an Job
  Future<int> postJobCubit(
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

    final response = await postJobProvider(
        apiToken: token,
        title: titleTextController.text,
        location: locationTextController.text,
        lat: lat,
        lng: lng,
        images: state.itemImagesFile,
        jobDate: dateTextController.text,
        jobTime: DateTimeConversions.convertTo24HourFormat(
            startTimeTextController.text),
        endTime: DateTimeConversions.convertTo24HourFormat(
            endTimeTextController.text),
        description: descriptionTextController.text,
        additionalInformation: additionalInfoTextController.text,
        budget: priceTextController.text,
        planId: planId.toString(),
        areaCode: areaCodeTextController.text,
        totalHours: totalHours);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        AppUtils.showToast(response.data["message"]);
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        return 1;
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
}
