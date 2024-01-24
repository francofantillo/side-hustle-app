import 'dart:io';

import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';
import 'package:path/path.dart' as getImagePath;

var dio = Dio();

/// Get Events
Future<Response?> getEventsProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.GET_EVENTS}\n**************************");
  final response =
      await getRequestProvider(path: API.GET_EVENTS, token: apiToken);
  return response;
}

/// Get Event Details
Future<Response?> getEventDetailsProvider({int? id, String? apiToken}) async {
  final data = {"id": id};

  print(
      "*****************\nurl: ${API.GET_EVENT_DETAILS}\n**************************");
  final response = await getRequestProvider(
      path: API.GET_EVENT_DETAILS, queryParameter: data, token: apiToken);
  return response;
}

/// Get Is Interested Event
Future<Response?> getIsInterestedEventProvider(
    {int? id, String? apiToken}) async {
  final data = {"event_id": id};

  print(
      "*****************\nurl: ${API.GET_INTERESTED_EVENT}\n**************************");
  final response = await getRequestProvider(
      path: API.GET_INTERESTED_EVENT, queryParameter: data, token: apiToken);
  return response;
}

/// Post an Event
Future<Response?> postAnEventProvider(
    {String? name,
    List<File>? images,
    String? location,
    String? lat,
    String? lng,
    String? date,
    String? startTime,
    String? endTime,
    String? purpose,
    String? theme,
    String? vendorsListString,
    String? price,
    String? paymentType,
    String? availableAttractionsString,
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
    print("images length: ${images.length}, Images Multipart Length: ${imageList.length}");

    formData = FormData.fromMap({
      "name": name,
      "images[]": imageList,
      "location": location,
      "lat": lat,
      "lng": lng,
      "date": date,
      "start_time": startTime,
      "end_time": endTime,
      "purpose": purpose,
      "theme": theme,
      "vendors_list": vendorsListString,
      "price": price,
      "payment_type": paymentType,
      "available_attractions": availableAttractionsString,
      "plan_id": planId
    });
  } else {
    formData = FormData.fromMap({
      "name": name,
      "location": location,
      "lat": lat,
      "lng": lng,
      "date": date,
      "start_time": startTime,
      "end_time": endTime,
      "purpose": purpose,
      "theme": theme,
      "vendors_list": vendorsListString,
      "price": price,
      "payment_type": paymentType,
      "available_attractions": availableAttractionsString,
      "plan_id": planId
    });
  }

  print(
      "*****************\nurl: ${API.POST_EVENT}\n${formData.fields}\n**************************");
  final response = await postRequestProvider(
      path: API.POST_EVENT, data: formData, token: apiToken);
  return response;
}
