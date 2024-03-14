import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

var dio = Dio();

/// Get Chat List
Future<Response?> getChatsListProvider({String? apiToken}) async {
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

/// Get Chats
Future<Response?> getMessagesProvider(
    {int? customerId,
    int? modelId,
    String? modelName,
    String? apiToken}) async {
  final data = {
    "customer_id": customerId,
    "model_id": modelId,
    "model_name": modelName
  };
  print(
      "*****************\nurl: ${API.GET_MESSAGES}\napiToken: $apiToken\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.GET_MESSAGES, queryParameter: data, token: apiToken);
  return response;
}

/// Upload Image
Future<Response?> uploadImageProvider(
    {int? senderId,
    receiverId,
    modelId,
    chatId,
    senderModel,
    receiverModel,
    fileType,
    imageBase64,
    String? apiToken}) async {
  // "model_name": "Order",
  final data = {
    "type": 2,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "model_id": modelId,
    "chat_id": chatId,
    "sender_model": senderModel,
    "receiver_model": receiverModel,
    "model_name": "Order",
    "file_type": fileType,
    "image": imageBase64,
  };
  print(
      "*****************\nurl: ${API.UPLOAD_IMAGE}\napiToken: $apiToken\n$data\n**************************");
  final response = await postRequestProvider(
      // path: API.UPLOAD_IMAGE, data: FormData.fromMap(data), token: apiToken);
      path: API.UPLOAD_IMAGE,
      data: data,
      token: apiToken);
  return response;
}

/// Get Order Listing
Future<Response?> getOrderDetailChatProvider(
    {int? customerId, int? orderId, String? apiToken}) async {
  final data = {
    "order_id": orderId,
  };
  print(
      "*****************\nurl: ${API.ORDER_DETAIL_CAHT}\napiToken: $apiToken\n$data\n**************************");
  final response = await getRequestProvider(
      path: API.ORDER_DETAIL_CAHT, queryParameter: data, token: apiToken);
  return response;
}

/// Blocked Users Chat List
Future<Response?> getUnBlockAllUsersChatProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.UN_BLOCK_ALL_CAHT}\napiToken: $apiToken\n**************************");
  final response =
      await getRequestProvider(path: API.UN_BLOCK_ALL_CAHT, token: apiToken);
  return response;
}
