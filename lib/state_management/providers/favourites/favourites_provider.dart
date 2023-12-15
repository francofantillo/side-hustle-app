import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// Get Favourites
Future<Response?> getFavouritesProvider(
    {required String type, String? apiToken}) async {
  final data = {"type": type};

  print(
      "*****************\nurl: ${API.GET_FAVOURITES}\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_FAVOURITES, queryParameter: data, token: apiToken);
  return response;
}

/// Add To Fav
Future<Response?> addToFavProvider(
    {int? id, String? type, String? apiToken}) async {
  final data = {"model_id": id, "model_name": type};

  print(
      "*****************\nurl: ${API.ADD_TO_FAVOURITES}\ndata: $data\n**************************");
  final response = await postRequestProvider(
      path: API.ADD_TO_FAVOURITES, data: data, token: apiToken);
  return response;
}

/// Remove From Fav
Future<Response?> removeFromFavProvider(
    {int? id, String? type, String? apiToken}) async {
  final data = {"model_id": id, "model_name": type};

  print(
      "*****************\nurl: ${API.REMOVE_FROM_FAVOURITES}\ndata: $data\n**************************");
  final response = await postRequestProvider(
      path: API.REMOVE_FROM_FAVOURITES, data: data, token: apiToken);
  return response;
}
