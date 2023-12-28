import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// Change Password
Future<Response?> getWantedJobsProvider(
    {String? type, String? apiToken}) async {
  print(
      "*****************\nurl: ${API.ADD_PRODUCT_OR_SERVICE}\n**************************");
  final response = await getRequestProvider(
      path: API.ADD_PRODUCT_OR_SERVICE, token: apiToken);
  return response;
}
