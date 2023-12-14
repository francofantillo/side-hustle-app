import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// Change Password
Future<Response?> addCardProvider(
    {String? cardHolder, String? last4, String? apiToken}) async {
  final data = {
    "card_holder": "Test Card",
    "last4": "3423",
    "token": apiToken
  };

  print(
      "*****************\nurl: ${API.ADD_CARD}\ndata: $data\n**************************");
  final response = await postRequestProvider(
      path: API.ADD_CARD, data: data, token: apiToken);
  return response;
}
