import 'dart:io';

import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';
import 'package:path/path.dart' as getImagePath;

var dio = Dio();

/// Get Wanted Jobs
Future<Response?> getWantedJobsProvider(
    {String? type, String? apiToken}) async {
  final data = {"type": type};

  print(
      "*****************\nurl: ${API.GET_WANTED_JOBS}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_WANTED_JOBS, queryParameter: data, token: apiToken);
  return response;
}

/// Get Jobs Detail
Future<Response?> getJobsDetailProvider(
    {String? jobId, String? apiToken}) async {
  final data = {"job_id": jobId};

  print(
      "*****************\nurl: ${API.GET_JOBS_DETAIL}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_JOBS_DETAIL, queryParameter: data, token: apiToken);
  return response;
}

/// Post Job
Future<Response?> postJobProvider(
    {String? title,
    List<File>? images,
    String? location,
    String? lat,
    String? lng,
    String? jobDate,
    String? jobTime,
    String? endTime,
    String? totalHours,
    String? description,
    String? additionalInformation,
    String? budget,
    String? areaCode,
    String? planId,
    String? apiToken}) async {
  late FormData formData;

  print("images $images");

  if (images != null && images.isNotEmpty) {
    final List<MultipartFile> imageList = [];
    for (int i = 0; i < images.length; i++) {
      final imageNetwork = await MultipartFile.fromFile(images[i].path,
          filename: getImagePath.basename(images[i].path));
      imageList.add(imageNetwork);
      print("Images Multipart $i: ${imageList[i]}\npath: ${images[i].path}");
    }
    print(
        "images length: ${images.length}, Images Multipart Length: ${imageList.length}");

    final Map<String, dynamic> data = {
      "title": title,
      "images[]": imageList,
      "location": location,
      "lat": lat,
      "lng": lng,
      "job_date": jobDate,
      "job_time": jobTime,
      "end_time": endTime,
      "total_hours": totalHours,
      "description": description,
      "additional_information": additionalInformation,
      "area_code": areaCode,
      "budget": budget,
      "plan_id": planId
    };

    print(
        "*****************\nurl: ${API.POST_JOB}\n${data}\n**************************");

    formData = FormData.fromMap(data);
  } else {
    final Map<String, dynamic> data = {
      "title": title,
      "location": location,
      "lat": lat,
      "lng": lng,
      "job_date": jobDate,
      "job_time": jobTime,
      "end_time": endTime,
      "total_hours": totalHours,
      "description": description,
      "additional_information": additionalInformation,
      "area_code": areaCode,
      "budget": budget,
      "plan_id": planId
    };

    print(
        "*****************\nurl: ${API.POST_JOB}\n${data}\n**************************");

    formData = FormData.fromMap(data);
  }

  final response = await postRequestProvider(
      path: API.POST_JOB, data: formData, token: apiToken);
  return response;
}

/// Get Edit Job
Future<Response?> getEditJobProvider({int? jobId, String? apiToken}) async {
  final data = {"job_id": jobId};

  print(
      "*****************\nurl: ${API.GET_EDIT_JOB}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_EDIT_JOB, queryParameter: data, token: apiToken);
  return response;
}

/// Edit Job
Future<Response?> editJobProvider(
    {String? title,
    List<File>? images,
    String? location,
    String? jobId,
    String? lat,
    String? lng,
    String? jobDate,
    String? jobTime,
    String? endTime,
    String? totalHours,
    String? description,
    String? additionalInformation,
    String? budget,
    String? areaCode,
    String? apiToken}) async {
  late FormData formData;

  print("images $images");

  if (images != null && images.isNotEmpty) {
    final List<MultipartFile> imageList = [];
    for (int i = 0; i < images.length; i++) {
      final imageNetwork = await MultipartFile.fromFile(images[i].path,
          filename: getImagePath.basename(images[i].path));
      imageList.add(imageNetwork);
      print("Images Multipart $i: ${imageList[i]}\npath: ${images[i].path}");
    }
    print(
        "images length: ${images.length}, Images Multipart Length: ${imageList.length}");

    final Map<String, dynamic> data = {
      "job_id": jobId,
      "title": title,
      "images[]": imageList,
      "location": location,
      "lat": lat,
      "lng": lng,
      "job_date": jobDate,
      "job_time": jobTime,
      "end_time": endTime,
      "total_hours": totalHours,
      "description": description,
      "additional_information": additionalInformation,
      "area_code": areaCode,
      "budget": budget,
    };

    print(
        "*****************\nurl: ${API.EDIT_JOB}\n$data\n**************************");

    formData = FormData.fromMap(data);
  } else {
    final Map<String, dynamic> data = {
      "job_id": jobId,
      "title": title,
      "location": location,
      "lat": lat,
      "lng": lng,
      "job_date": jobDate,
      "job_time": jobTime,
      "end_time": endTime,
      "total_hours": totalHours,
      "description": description,
      "additional_information": additionalInformation,
      "area_code": areaCode,
      "budget": budget,
    };

    print(
        "*****************\nurl: ${API.EDIT_JOB}\n$data\n**************************");

    formData = FormData.fromMap(data);
  }

  final response = await postRequestProvider(
      path: API.EDIT_JOB, data: formData, token: apiToken);
  return response;
}

/// Apply For Job
Future<Response?> applyForJobProvider(
    {int? jobId, String? bidAmount, String? apiToken}) async {
  final data = {"job_id": jobId, "bid_amount": bidAmount};

  print(
      "*****************\nurl: ${API.APPLYFOR_JOB}\n$data\n**************************");
  final response = await postRequestProvider(
      path: API.APPLYFOR_JOB, data: data, token: apiToken);
  return response;
}

/// Get My Job
Future<Response?> getMyJobProvider({String? type, String? apiToken}) async {
  final data = {"type": type};

  print(
      "*****************\nurl: ${API.GET_MY_JOBS}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_MY_JOBS, queryParameter: data, token: apiToken);
  return response;
}

/// Get Job Request
Future<Response?> getJobRequestsProvider({int? jobId, String? apiToken}) async {
  final data = {"job_id": jobId};

  print(
      "*****************\nurl: ${API.GET_JOB_REQUESTS}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_JOB_REQUESTS, queryParameter: data, token: apiToken);
  return response;
}

/// Update Job Request
Future<Response?> updateJobRequestsProvider(
    {int? jobId,
    int? jobRequestId,
    int? applierId,
    String? status,
    String? bidAmount,
    String? apiToken}) async {
  final data = {
    "job_request_id": jobRequestId,
    "job_id": jobId,
    "applier_id": applierId,
    "status": status,
    "bid_amount": bidAmount
  };

  print(
      "*****************\nurl: ${API.UPDATE_JOB_REQUESTS}\n$data\n**************************");
  final response = await putRequestProvider(
      path: API.UPDATE_JOB_REQUESTS, data: data, token: apiToken);
  return response;
}

/// Update Job Status
Future<Response?> updateJobStatusProvider(
    {int? jobId, String? status, String? apiToken}) async {
  final data = {"job_id": jobId, "status": status};

  print(
      "*****************\nurl: ${API.UPDATE_JOB_STATUS}\n$data\n**************************");
  final response = await putRequestProvider(
      path: API.UPDATE_JOB_STATUS, data: data, token: apiToken);
  return response;
}

/// Add Review
Future<Response?> addReviewProvider(
    {int? taskerId, String? rating, String? review, int? jobId, String? apiToken}) async {
  final data = {
    "model_id": jobId,
    "model_name": "Job",
    "tasker": taskerId,
    "rating": rating,
    "review": review
  };

  print(
      "*****************\nurl: ${API.ADD_JOB_REVIEW}\n$data\n**************************");
  final response = await postRequestProvider(
      path: API.ADD_JOB_REVIEW, data: data, token: apiToken);
  return response;
}
