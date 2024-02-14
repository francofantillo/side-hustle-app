import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/state_management/models/job_request_model.dart';
import 'package:side_hustle/state_management/models/jobs_model.dart';
import 'package:side_hustle/state_management/models/my_jobs.dart';
import 'package:side_hustle/state_management/models/select_location_model.dart';
import 'package:side_hustle/state_management/providers/wanted_jobs/wanted_job_provider.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
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
    state.totalHours = null;
    emit(state.copyWith(images: []));
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
      final List<Images>? imagesList = state.images;
      for (int i = 0; i < images.length; i++) {
        imagesList!.add(Images(image: images[i].path));
      }
      emit(state.copyWith(images: imagesList));
    }
  }

  totalHour() {
    final totalHours = AppUtils.calculateTotalHours();
    if (totalHours != null) {
      emit(state.copyWith(totalHours: totalHours));
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

  /// Post a Job
  Future<int> postJobCubit(
      {required BuildContext context,
      required int planId,
      required bool isFromMyJobs,
      required bool mounted}) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final String? lat = selectLocationModel?.lat?.toString();
    final String? lng = selectLocationModel?.lng?.toString();
    print("lat: $lat");
    print("lng: $lng");

    final token = await prefs.getToken();

    List<File> itemImagesFile = [];
    for (int i = 0; i < state.images!.length; i++) {
      if (state.images![i].image != null &&
          !(state.images![i].image!.contains("http"))) {
        itemImagesFile.add(File(state.images![i].image!));
        print("postJobCubit itemImagesFile: ${state.images![i].image}");
      }
    }

    final response = await postJobProvider(
        apiToken: token,
        title: titleTextController.text,
        location: locationTextController.text,
        lat: lat,
        lng: lng,
        // images: state.itemImagesFile,
        images: itemImagesFile,
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
        totalHours: state.totalHours);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        AppUtils.showToast(response.data["message"]);
        if (mounted) {
          if (isFromMyJobs) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, AppRoutes.myJobsScreenRoute);
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
            // Navigator.pushNamed(context, AppRoutes.myJobsScreenRoute);
          }
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

  /// Edit a Job
  Future<int> editJobCubit(
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
      lat = state.jobsModel?.jobsDetailData?.lat;
      lng = state.jobsModel?.jobsDetailData?.lng;
    }
    print("editJobModel lat: ${state.jobsModel?.jobsDetailData?.lat}");
    print("editJobModel lng: ${state.jobsModel?.jobsDetailData?.lng}");
    print("editJobCubit lat: $lat");
    print("editJobCubit lng: $lng");

    final token = await prefs.getToken();

    List<File> itemImagesFile = [];
    for (int i = 0; i < state.images!.length; i++) {
      if (state.images![i].image != null &&
          !(state.images![i].image!.contains("http"))) {
        itemImagesFile.add(File(state.images![i].image!));
        print("editJobCubit itemImagesFile: ${state.images![i].image}");
      }
    }

    final response = await editJobProvider(
        apiToken: token,
        jobId: state.jobsModel?.jobsDetailData?.id,
        title: titleTextController.text,
        location: locationTextController.text,
        lat: lat,
        lng: lng,
        images: itemImagesFile,
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
        totalHours: state.totalHours);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        AppUtils.showToast(response.data["message"]);
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutes.myJobsScreenRoute);
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

  /// Get Edot Job
  Future<JobsModel?> getEditJobCubit(
      {required BuildContext context,
      required bool mounted,
      required int? jobId}) async {
    emit(state.copyWith(editJobLoading: true, jobsModel: JobsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getEditJobProvider(jobId: jobId, apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        JobsModel jobsDetail = JobsModel.fromJson(response.data);
        // AppUtils.showToast(response.data['message']);
        emit(state.copyWith(
            editJobLoading: false,
            jobsModel: jobsDetail,
            images: jobsDetail.jobsDetailData?.images ?? []));
        return jobsDetail;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(editJobLoading: false));
        return null;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      emit(state.copyWith(editJobLoading: false));
      return null;
    }
  }

  /// Apply For Job
  Future applyForJobCubit({
    required BuildContext context,
    required bool mounted,
    required int? jobId,
    required String? bidAmount,
  }) async {
    // emit(state.copyWith(jobsDetailLoading: true, jobsDetailModel: JobsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await applyForJobProvider(
        jobId: jobId, bidAmount: bidAmount, apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        JobsModel jobsModel = JobsModel.fromJson(response.data);
        emit(state.copyWith(jobsDetailModel: jobsModel));
        AppUtils.showToast(response.data['message']);
        if (mounted) {
          Navigator.pop(context);
          // Navigator.pushNamedAndRemoveUntil(
          //     context,
          //     AppRoutes.bottomTabsScreenRoute,
          //     arguments: const BottomTabsScreen(
          //       currentIndex: 1,
          //       wantedTabCurrentIndex: 1,
          //     ),
          //     (route) => false);
        }
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get My Jobs
  Future getMYJobSCubit(
      {required BuildContext context,
      required bool mounted,
      required String type}) async {
    emit(state.copyWith(myJobsLoading: true, myJobsModel: MyJobsModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getMyJobProvider(type: type, apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        MyJobsModel myJobsModel = MyJobsModel.fromJson(response.data);
        // AppUtils.showToast(response.data['message']);
        emit(state.copyWith(myJobsLoading: false, myJobsModel: myJobsModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(myJobsLoading: false));
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      emit(state.copyWith(myJobsLoading: false));
    }
  }

  /// Get Job Requests
  Future getJobRequestsCubit(
      {required BuildContext context,
      required bool mounted,
      required int? jobId}) async {
    emit(state.copyWith(
        jobRequestLoading: true, jobRequestModel: JobRequestModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response =
        await getJobRequestsProvider(jobId: jobId, apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        JobRequestModel jobRequestModel =
            JobRequestModel.fromJson(response.data);
        emit(state.copyWith(
            jobRequestLoading: false, jobRequestModel: jobRequestModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(jobRequestLoading: false));
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      emit(state.copyWith(jobRequestLoading: false));
    }
  }

  /// Update Job Requests
  Future<int> updateJobRequestsCubit(
      {required BuildContext context,
      required bool mounted,
      required int index,
      required String status}) async {
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await updateJobRequestsProvider(
        jobId: state.jobRequestModel?.data?[index].jobId,
        jobRequestId: state.jobRequestModel?.data?[index].jobRequestId,
        applierId: state.jobRequestModel?.data?[index].userId,
        status: status,
        bidAmount:
            state.jobRequestModel?.data?[index].bidAmount?.toStringAsFixed(2),
        apiToken: token);

    print("status code: ${response?.statusCode}");

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        JobRequestModel jobRequestModel =
            JobRequestModel.fromJson(response.data);
        emit(state.copyWith(
            jobRequestLoading: false, jobRequestModel: jobRequestModel));
        AppUtils.showToast(response.data['message']);
        EasyLoading.dismiss();
        return 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
      return 0;
    }
  }

  /// Update Job Status
  Future<int> startJobCubit(
      {required BuildContext context,
      required bool mounted,
      required int? jobId}) async {
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await updateJobStatusProvider(
        jobId: jobId, status: JobStatusEnum.Ongoing.name, apiToken: token);

    print("status code: ${response?.statusCode}");

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        JobsModel jobsModel = JobsModel.fromJson(response.data);
        emit(state.copyWith(
            jobsModel: jobsModel, wantedJobsTempList: [], searching: false));
        AppUtils.showToast(response.data['message']);
        EasyLoading.dismiss();
        return 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
      return 0;
    }
  }

  /// Update Job Status
  Future<int> completeJobCubit(
      {required BuildContext context,
      required bool mounted,
      required int index,
      required int? jobId}) async {
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await updateJobStatusProvider(
        jobId: jobId, status: JobStatusEnum.Completed.name, apiToken: token);

    print("status code: ${response?.statusCode}");

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final ongoingJobs = state.myJobsModel;
        ongoingJobs?.myJobs?.removeAt(index);
        AppUtils.showToast(response.data['message']);
        EasyLoading.dismiss();
        emit(state.copyWith(myJobsModel: ongoingJobs));
        return 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
      return 0;
    }
  }

  /// Add Review
  Future<int> reviewCubit({
    required BuildContext context,
    required bool mounted,
    required int? taskerId,
    required int? jobId,
    required double rating,
    String? review,
  }) async {
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await addReviewProvider(
        taskerId: taskerId,
        jobId: jobId,
        rating: rating.toString(),
        review: review,
        apiToken: token);

    print("status code: ${response?.statusCode}");

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        MyJobsModel myJobsModel = MyJobsModel.fromJson(response.data);
        emit(state.copyWith(myJobsLoading: false, myJobsModel: myJobsModel));
        AppUtils.showToast(response.data['message']);
        EasyLoading.dismiss();
        return 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
      return 0;
    }
  }
}
