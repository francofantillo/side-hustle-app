import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/state_management/models/chat_model.dart';
import 'package:side_hustle/state_management/providers/chat/chat_provider.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  final prefs = SharedPreferencesHelper.instance;

  Future resetChatBloc() async {
    emit(ChatState());
  }

  /// Get all user chat
  Future getChatsCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    emit(state.copyWith(
        chatAllUsersLoading: true, chatAllUsersModel: ChatModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getChatsProvider(apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        ChatModel chatModel = ChatModel.fromJson(response.data);
        emit(state.copyWith(
            chatAllUsersLoading: false, chatAllUsersModel: chatModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(chatAllUsersLoading: false));
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      emit(state.copyWith(chatAllUsersLoading: false));
    }
  }

  /// Get blocked users chat list
  Future getBlockedUsersChatCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    emit(state.copyWith(
        chatBlockedUsersLoading: true, chatBlockedUsersModel: ChatModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getBlockedUsersChatListProvider(apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        ChatModel chatModel = ChatModel.fromJson(response.data);
        emit(state.copyWith(
            chatBlockedUsersLoading: false, chatBlockedUsersModel: chatModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(chatBlockedUsersLoading: false));
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      emit(state.copyWith(chatBlockedUsersLoading: false));
    }
  }
}
