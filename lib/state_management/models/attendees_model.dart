class AttendeesModel {
  bool? status;
  String? message;
  List<Data>? data;

  AttendeesModel({this.status, this.message, this.data});

  AttendeesModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  int? userid;
  int? eventId;
  String? username;
  String? image;
  String? status;

  Data(
      {this.id,
      this.userid,
      this.eventId,
      this.username,
      this.image,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    eventId = json['event_id'];
    username = json['username'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['event_id'] = this.eventId;
    data['username'] = this.username;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
