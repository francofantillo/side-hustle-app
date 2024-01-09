import 'package:dio/dio.dart';
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
  final data = {
    "name": {},
    "location": {},
    "lat": {},
    "lng": {},
    "date": {},
    "start_time": {},
    "end_time": {},
    "purpose": {},
    "theme": {},
    "vendors_list": {},
    "price": {},
    "payment_type": {},
    "available_attractions": {},
    "plan_id": {}
  };

  final FormData formData = FormData.fromMap(data);

  print(
      "*****************\nurl: ${API.ADD_EVENT}\n$data\n**************************");
  final response = await postRequestProvider(
      path: API.ADD_EVENT, data: formData, token: apiToken);
  return response;
}
