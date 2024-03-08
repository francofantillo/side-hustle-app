class PlaceOrderModel {
  bool? status;
  String? message;
  Data? data;

  PlaceOrderModel({this.status, this.message, this.data});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? modelId;
  String? modelName;
  int? customerId;
  List<Messages>? messages;

  Data({this.modelId, this.modelName, this.customerId, this.messages});

  Data.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    modelName = json['model_name'];
    customerId = json['customer_id'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['model_name'] = this.modelName;
    data['customer_id'] = this.customerId;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  int? chatId;
  int? senderId;
  int? receiverId;
  String? senderModel;
  String? receiverModel;
  String? productCount;
  String? message;
  String? filePath;
  int? type;
  int? messageType;
  int? isSeen;
  String? productType;
  String? name;
  double? price;
  String? deliveryType;
  String? serviceDate;
  String? startTime;
  String? endTime;
  String? image;
  String? location;
  String? lat;
  String? lng;
  String? description;
  String? createdAt;
  String? updatedAt;

  Messages(
      {this.id,
        this.chatId,
        this.senderId,
        this.receiverId,
        this.senderModel,
        this.receiverModel,
        this.productCount,
        this.message,
        this.filePath,
        this.type,
        this.messageType,
        this.isSeen,
        this.productType,
        this.name,
        this.price,
        this.deliveryType,
        this.serviceDate,
        this.startTime,
        this.endTime,
        this.image,
        this.location,
        this.lat,
        this.lng,
        this.description,
        this.createdAt,
        this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    senderModel = json['sender_model'];
    receiverModel = json['receiver_model'];
    productCount = json['product_count'];
    message = json['message'];
    filePath = json['file_path'];
    type = json['type'];
    messageType = json['message_type'];
    isSeen = json['is_seen'];
    productType = json['product_type'];
    name = json['name'];
    price = json['price'];
    deliveryType = json['delivery_type'];
    serviceDate = json['service_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    image = json['image'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['sender_model'] = this.senderModel;
    data['receiver_model'] = this.receiverModel;
    data['product_count'] = this.productCount;
    data['message'] = this.message;
    data['file_path'] = this.filePath;
    data['type'] = this.type;
    data['message_type'] = this.messageType;
    data['is_seen'] = this.isSeen;
    data['product_type'] = this.productType;
    data['name'] = this.name;
    data['price'] = this.price;
    data['delivery_type'] = this.deliveryType;
    data['service_date'] = this.serviceDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['image'] = this.image;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
