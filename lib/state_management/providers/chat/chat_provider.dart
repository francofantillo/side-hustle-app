import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// Get Chat List
Future<Response?> getChatsProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.GET_CHAT_LIST}\napiToken: $apiToken\n**************************");
  final response =
      await getRequestProvider(path: API.GET_CHAT_LIST, token: apiToken);
  return response;
}

/// Blocked Users Chat List
Future<Response?> getBlockedUsersChatListProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.BLOCKED_USERS_CHAT_LIST}\napiToken: $apiToken\n**************************");
  final response = await getRequestProvider(
      path: API.BLOCKED_USERS_CHAT_LIST, token: apiToken);
  return response;
}

/// Block User
Future<Response?> blockUserProvider({int? chatId, String? apiToken}) async {
  final data = {"chat_id": chatId};
  print(
      "*****************\nurl: ${API.BLOCK_USER}\napiToken: $apiToken\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.BLOCK_USER, queryParameter: data, token: apiToken);
  return response;
}

/// UnBlock User
Future<Response?> unBlockUserProvider({int? chatId, String? apiToken}) async {
  final data = {"chat_id": chatId};
  print(
      "*****************\nurl: ${API.UN_BLOCK_USER}\napiToken: $apiToken\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.UN_BLOCK_USER, queryParameter: data, token: apiToken);
  return response;
}
