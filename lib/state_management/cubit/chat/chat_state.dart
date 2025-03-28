part of 'chat_cubit.dart';

class ChatState {
  UserModel? userModel;
  ChatModel? chatAllUsersModel;
  bool chatAllUsersLoading;
  ChatModel? chatBlockedUsersModel;
  bool chatBlockedUsersLoading;
  List<ChatListData>? chatTempList;
  List<ChatListData>? chatBlockedTempList;
  bool searchingChat;
  bool searchingChatBlocked;
  ChatMessagesModel? chatMessagesModel;
  bool chatMessagesLoading;
  int? receiverId;
  bool showEmoji;
  OrderDetailChatModel? orderDetailChatModel;
  bool orderDetailLoading;

  ChatState(
      {this.chatAllUsersModel,
      this.userModel,
      this.chatAllUsersLoading = true,
      this.chatBlockedUsersModel,
      this.chatBlockedUsersLoading = true,
      this.chatTempList,
      this.searchingChat = false,
      this.chatBlockedTempList,
      this.searchingChatBlocked = false,
      this.chatMessagesModel,
      this.chatMessagesLoading = true,
      this.showEmoji = true,
      this.receiverId,
      this.orderDetailChatModel,
      this.orderDetailLoading = true});

  ChatState copyWith(
      {UserModel? userModel,
      ChatModel? chatAllUsersModel,
      bool? chatAllUsersLoading,
      ChatModel? chatBlockedUsersModel,
      bool? chatBlockedUsersLoading,
      List<ChatListData>? chatTempList,
      List<ChatListData>? chatBlockedTempList,
      bool? searchingChat,
      bool? searchingChatBlocked,
      ChatMessagesModel? chatMessagesModel,
      bool? chatMessagesLoading,
      int? receiverId,
      bool? showEmoji,
      OrderDetailChatModel? orderDetailChatModel,
      bool? orderDetailLoading}) {
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
        searchingChatBlocked: searchingChatBlocked ?? this.searchingChatBlocked,
        chatMessagesModel: chatMessagesModel ?? this.chatMessagesModel,
        chatMessagesLoading: chatMessagesLoading ?? this.chatMessagesLoading,
        userModel: userModel ?? this.userModel,
        receiverId: receiverId ?? this.receiverId,
        showEmoji: showEmoji ?? this.showEmoji,
        orderDetailChatModel: orderDetailChatModel ?? this.orderDetailChatModel,
        orderDetailLoading: orderDetailLoading ?? this.orderDetailLoading);
  }
}
