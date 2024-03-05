class ChatModel {
  bool? status;
  String? message;
  List<ChatListData>? chatList;

  ChatModel({this.status, this.message, this.chatList});

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      chatList = <ChatListData>[];
      json['data'].forEach((v) {
        chatList!.add(new ChatListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.chatList != null) {
      data['data'] = this.chatList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatListData {
  int? modelId;
  String? modelName;
  int? id;
  int? chatId;
  int? senderId;
  int? receiverId;
  String? senderModel;
  int? messageType;
  int? type;
  String? message;
  int? isSeen;
  String? createdAt;
  int? userId;
  String? userName;
  String? userImage;

  ChatListData(
      {this.modelId,
        this.modelName,
        this.id,
        this.chatId,
        this.senderId,
        this.receiverId,
        this.senderModel,
        this.messageType,
        this.type,
        this.message,
        this.isSeen,
        this.createdAt,
        this.userId,
        this.userName,
        this.userImage});

  ChatListData.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    modelName = json['model_name'];
    id = json['id'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    senderModel = json['sender_model'];
    messageType = json['message_type'];
    type = json['type'];
    message = json['message'];
    isSeen = json['is_seen'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['model_name'] = this.modelName;
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['sender_model'] = this.senderModel;
    data['message_type'] = this.messageType;
    data['type'] = this.type;
    data['message'] = this.message;
    data['is_seen'] = this.isSeen;
    data['created_at'] = this.createdAt;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    return data;
  }
}
