class NotificationsModel {
  bool? status;
  String? message;
  List<Data>? data;

  NotificationsModel({this.status, this.message, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? senderImage;
  String? senderName;
  String? notification;
  String? datetime;

  Data(
      {this.id,
      this.senderImage,
      this.senderName,
      this.notification,
      this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderImage = json['sender_image'];
    senderName = json['sender_name'];
    notification = json['notification'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['sender_image'] = this.senderImage;
    data['sender_name'] = this.senderName;
    data['notification'] = this.notification;
    data['datetime'] = this.datetime;
    return data;
  }
}
