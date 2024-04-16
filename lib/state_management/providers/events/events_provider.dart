import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as getImagePath;
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

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
    String vendorsListString = "",
    String? price,
    String? paymentType,
    String availableAttractionsString = "",
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
      "price": price,
      "payment_type": paymentType,
      "plan_id": planId
    };

    if (vendorsListString.trim() != "") {
      data.putIfAbsent("vendors_list", () => vendorsListString);
    }
    if (availableAttractionsString.trim() != "") {
      data.putIfAbsent(
          "available_attractions", () => availableAttractionsString);
    }

    formData = FormData.fromMap(data);
  } else {
    final Map<String, dynamic> data = {
      "name": name,
      "location": location,
      "lat": lat,
      "lng": lng,
      "date": date,
      "start_time": startTime,
      "end_time": endTime,
      "purpose": purpose,
      "theme": theme,
      "price": price,
      "payment_type": paymentType,
      "plan_id": planId
    };

    if (vendorsListString.trim() != "") {
      data.putIfAbsent("vendors_list", () => vendorsListString);
    }
    if (availableAttractionsString.trim() != "") {
      data.putIfAbsent(
          "available_attractions", () => availableAttractionsString);
    }

    formData = FormData.fromMap(data);
  }

  print(
      "*****************\nurl: ${API.POST_EVENT}\n${formData.fields}\n**************************");
  final response = await postRequestProvider(
      path: API.POST_EVENT, data: formData, token: apiToken);
  return response;
}

/// Edit an Event
Future<Response?> editAnEventProvider(
    {int? eventId,
    String? name,
    List<File>? images,
    String? location,
    String? lat,
    String? lng,
    String? date,
    String? startTime,
    String? endTime,
    String? purpose,
    String? theme,
    String vendorsListString = "",
    String? price,
    String? paymentType,
    String availableAttractionsString = "",
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

    // "plan_id": planId

    final Map<String, dynamic> data = {
      "event_id": eventId,
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
      "price": price,
      "payment_type": paymentType,
    };

    if (vendorsListString.trim() != "") {
      data.putIfAbsent("vendors_list", () => vendorsListString);
    }
    if (availableAttractionsString.trim() != "") {
      data.putIfAbsent(
          "available_attractions", () => availableAttractionsString);
    }

    formData = FormData.fromMap(data);
  } else {
    // "plan_id": planId

    final Map<String, dynamic> data = {
      "event_id": eventId,
      "name": name,
      "location": location,
      "lat": lat,
      "lng": lng,
      "date": date,
      "start_time": startTime,
      "end_time": endTime,
      "purpose": purpose,
      "theme": theme,
      "price": price,
      "payment_type": paymentType,
    };

    // if (vendorsListString.isNotEmpty) {
    if (vendorsListString.trim() != "") {
      data.putIfAbsent("vendors_list", () => vendorsListString);
    }
    // if (availableAttractionsString.isNotEmpty) {
    if (availableAttractionsString.trim() != "") {
      data.putIfAbsent(
          "available_attractions", () => availableAttractionsString);
    }

    formData = FormData.fromMap(data);
  }

  print(
      "*****************\nurl: ${API.EDIT_EVENT}\n${formData.fields}\n**************************");
  final response = await postRequestProvider(
      path: API.EDIT_EVENT, data: formData, token: apiToken);
  return response;
}

/// Get My Events
Future<Response?> getMyEventsProvider(
    {required String status, String? apiToken}) async {
  final data = {"status": status};

  print(
      "*****************\nurl: ${API.GET_MY_EVENTS}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_MY_EVENTS, queryParameter: data, token: apiToken);
  return response;
}

/// Get Attendees
Future<Response?> getAttendeesProvider(
    {String? eventId, required String type, String? apiToken}) async {
  final data = {"event_id": eventId, "type": type};

  print(
      "*****************\nurl: ${API.GET_ATTENDEES}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_ATTENDEES, queryParameter: data, token: apiToken);
  return response;
}

/// Update Attendees Status
Future<Response?> updateAttendeesProvider(
    {String? attendeesId,
    String? eventId,
    required String status,
    String? apiToken}) async {
  final data = {"id": attendeesId, "event_id": eventId, "status": status};

  print(
      "*****************\nurl: ${API.UPDATE_ATTENDEES_STATUS}\n$data\n**************************");
  final response = await putRequestProvider(
      path: API.UPDATE_ATTENDEES_STATUS, data: data, token: apiToken);
  return response;
}

/// Get Edit Event
Future<Response?> getEditEventProvider({int? id, String? apiToken}) async {
  final data = {"id": id};

  print(
      "*****************\nurl: ${API.GET_EDIT_EVENT}\n**************************");
  final response = await getRequestProvider(
      path: API.GET_EDIT_EVENT, queryParameter: data, token: apiToken);
  return response;
}
