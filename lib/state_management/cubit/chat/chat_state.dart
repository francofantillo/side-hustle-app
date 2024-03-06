part of 'chat_cubit.dart';

class ChatState {
  ChatModel? chatAllUsersModel;
  bool chatAllUsersLoading;
  ChatModel? chatBlockedUsersModel;
  bool chatBlockedUsersLoading;
  List<ChatListData>? chatTempList;
  List<ChatListData>? chatBlockedTempList;
  bool searchingChat;
  bool searchingChatBlocked;

  ChatState(
      {this.chatAllUsersModel,
      this.chatAllUsersLoading = true,
      this.chatBlockedUsersModel,
      this.chatBlockedUsersLoading = true,
      this.chatTempList,
      this.searchingChat = false,
      this.chatBlockedTempList,
      this.searchingChatBlocked = false});

  ChatState copyWith(
      {ChatModel? chatAllUsersModel,
      bool? chatAllUsersLoading,
      ChatModel? chatBlockedUsersModel,
      bool? chatBlockedUsersLoading,
      List<ChatListData>? chatTempList,
      List<ChatListData>? chatBlockedTempList,
      bool? searchingChat,
      bool? searchingChatBlocked}) {
    return ChatState(
        chatAllUsersModel: chatAllUsersModel ?? this.chatAllUsersModel,
        chatAllUsersLoading: chatAllUsersLoading ?? this.chatAllUsersLoading,
        chatBlockedUsersModel:
            chatBlockedUsersModel ?? this.chatBlockedUsersModel,
        chatBlockedUsersLoading:
            chatBlockedUsersLoading ?? this.chatBlockedUsersLoading,
        chatTempList: chatTempList ?? this.chatTempList,
        chatBlockedTempList: chatBlockedTempList ?? this.chatBlockedTempList,
        searchingChat: searchingChat ?? this.searchingChat,
        searchingChatBlocked:
            searchingChatBlocked ?? this.searchingChatBlocked);
  }
}
