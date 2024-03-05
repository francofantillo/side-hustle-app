part of 'chat_cubit.dart';

class ChatState {
  ChatModel? chatAllUsersModel;
  bool chatAllUsersLoading;
  ChatModel? chatBlockedUsersModel;
  bool chatBlockedUsersLoading;

  ChatState(
      {this.chatAllUsersModel,
      this.chatAllUsersLoading = true,
      this.chatBlockedUsersModel,
      this.chatBlockedUsersLoading = true});

  ChatState copyWith(
      {ChatModel? chatAllUsersModel,
      bool? chatAllUsersLoading,
      ChatModel? chatBlockedUsersModel,
      bool? chatBlockedUsersLoading}) {
    return ChatState(
        chatAllUsersModel: chatAllUsersModel ?? this.chatAllUsersModel,
        chatAllUsersLoading: chatAllUsersLoading ?? this.chatAllUsersLoading,
        chatBlockedUsersModel:
            chatBlockedUsersModel ?? this.chatBlockedUsersModel,
        chatBlockedUsersLoading:
            chatBlockedUsersLoading ?? this.chatBlockedUsersLoading);
  }
}
