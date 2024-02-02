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

    /*
    title:Test Job 2
location:Test location
lat:124.251475
lng:200.021547
description:Test description
budget:200
area_code:125487
job_date:2023/10/05
job_time:06:30
total_hours:6
additional_information:Additional Test Information
plan_id:2
end_time:07:30
     */
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
  final response = await postRequestProvider(
      path: API.GET_EDIT_JOB, data: data, token: apiToken);
  return response;
}

/// Edit Job
Future<Response?> editJobProvider(
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

    /*
    title:Test Job 2
location:Test location
lat:124.251475
lng:200.021547
description:Test description
budget:200
area_code:125487
job_date:2023/10/05
job_time:06:30
total_hours:6
additional_information:Additional Test Information
plan_id:2
end_time:07:30
     */
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
        "*****************\nurl: ${API.GET_EDIT_JOB}\n${data}\n**************************");

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
        "*****************\nurl: ${API.GET_EDIT_JOB}\n${data}\n**************************");

    formData = FormData.fromMap(data);
  }

  final response = await postRequestProvider(
      path: API.GET_EDIT_JOB, data: formData, token: apiToken);
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
