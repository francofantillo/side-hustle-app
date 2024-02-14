import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// Get Your Shop
Future<Response?> getYourShopProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.GET_YOUR_SHOP}\n**************************");
  final response =
      await getRequestProvider(path: API.GET_YOUR_SHOP, token: apiToken);
  return response;
}
