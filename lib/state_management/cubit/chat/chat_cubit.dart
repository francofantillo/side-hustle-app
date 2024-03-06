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
        chatTempList: [],
        searchingChat: false,
        chatAllUsersLoading: true,
        chatAllUsersModel: ChatModel()));
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
        chatBlockedTempList: [],
        searchingChatBlocked: false,
        chatBlockedUsersLoading: true,
        chatBlockedUsersModel: ChatModel()));
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

  /// Search Chat List
  searchChatList({
    String? value,
  }) {
    emit(state.copyWith(chatTempList: [], searchingChat: true));
    final List<ChatListData>? originalList = state.chatAllUsersModel?.chatList;
    final List<ChatListData> tempList = [];
    print("searchList: $value");
    state.chatTempList?.clear();
    if (value != null) {
      emit(state.copyWith(searchingChat: true));
      for (int i = 0; i < (originalList?.length ?? 0); i++) {
        String name = originalList?[i].userName != null
            ? "${originalList![i].userName}"
            : '';
        if (name.toLowerCase().contains(value.toLowerCase())) {
          tempList.add(originalList![i]);
        }
      }
      if (tempList.isNotEmpty) {
        print("searchList tempList: ${tempList[0].userName}");
        final tempSearchChatList = tempList;
        emit(state.copyWith(chatTempList: tempSearchChatList));
      } else if (value.isEmpty) {
        print("searchList tempList is empty");
        emit(state.copyWith(chatTempList: originalList));
      } else {
        emit(state.copyWith(chatTempList: []));
      }
    }
  }

  /// Search Blocked Chat List
  searchBlockedChatList({
    String? value,
  }) {
    emit(state.copyWith(chatBlockedTempList: [], searchingChatBlocked: true));
    final List<ChatListData>? originalList =
        state.chatBlockedUsersModel?.chatList;
    final List<ChatListData> tempList = [];
    print("searchList: $value");
    state.chatBlockedTempList?.clear();
    if (value != null) {
      emit(state.copyWith(searchingChatBlocked: true));
      for (int i = 0; i < (originalList?.length ?? 0); i++) {
        String name = originalList?[i].userName != null
            ? "${originalList![i].userName}"
            : '';
        if (name.toLowerCase().contains(value.toLowerCase())) {
          tempList.add(originalList![i]);
        }
      }
      if (tempList.isNotEmpty) {
        print("searchList tempList: ${tempList[0].userName}");
        final tempSearchChatList = tempList;
        emit(state.copyWith(chatBlockedTempList: tempSearchChatList));
      } else if (value.isEmpty) {
        print("searchList tempList is empty");
        emit(state.copyWith(chatBlockedTempList: originalList));
      } else {
        emit(state.copyWith(chatBlockedTempList: []));
      }
    }
  }

  /// block user
  Future<int> blockUserChatCubit(
      {required BuildContext context,
      required bool mounted,
      required int? chatId,
      required int index}) async {
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await blockUserProvider(chatId: chatId, apiToken: token);

    print("status code: ${response?.statusCode}");

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final ChatModel? chatModel = state.chatAllUsersModel;
        chatModel?.chatList?.removeAt(index);
        emit(state.copyWith(chatAllUsersModel: chatModel));
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
      return 0;
    }
  }

  /// UnBlock user
  Future<int> unBlockUserChatCubit(
      {required BuildContext context,
      required bool mounted,
      required int? chatId,
      required int index}) async {
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await unBlockUserProvider(chatId: chatId, apiToken: token);

    print("status code: ${response?.statusCode}");

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final ChatModel? chatModel = state.chatAllUsersModel;
        chatModel?.chatList
            ?.insert(0, state.chatBlockedUsersModel!.chatList![index]);
        emit(state.copyWith(chatAllUsersModel: chatModel));
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
      return 0;
    }
  }
}
