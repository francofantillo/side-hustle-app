import 'package:side_hustle/state_management/models/events_model.dart';

class EditEventModel {
  bool? status;
  String? message;
  Data? data;

  EditEventModel({this.status, this.message, this.data});

  EditEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? eventId;
  String? eventName;
  String? location;
  String? startDate;
  String? startTime;
  String? endTime;
  String? purpose;
  String? theme;
  int? price;
  String? paymentType;
  List<Images>? images;
  List<String>? vendorsList;
  List<AvailableAttractions>? availableAttractions;

  Data(
      {this.eventId,
        this.eventName,
        this.location,
        this.startDate,
        this.startTime,
        this.endTime,
        this.purpose,
        this.theme,
        this.price,
        this.paymentType,
        this.images,
        this.vendorsList,
        this.availableAttractions});

  Data.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    location = json['location'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    purpose = json['purpose'];
    theme = json['theme'];
    price = json['price'];
    paymentType = json['payment_type'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    vendorsList = json['vendors_list'].cast<String>();
    if (json['available_attractions'] != null) {
      availableAttractions = <AvailableAttractions>[];
      json['available_attractions'].forEach((v) {
        availableAttractions!.add(new AvailableAttractions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_name'] = this.eventName;
    data['location'] = this.location;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['purpose'] = this.purpose;
    data['theme'] = this.theme;
    data['price'] = this.price;
    data['payment_type'] = this.paymentType;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['vendors_list'] = this.vendorsList;
    if (this.availableAttractions != null) {
      data['available_attractions'] =
          this.availableAttractions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class Images {
  String? image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}*/

class AvailableAttractions {
  String? attr;

  AvailableAttractions({this.attr});

  AvailableAttractions.fromJson(Map<String, dynamic> json) {
    attr = json['attr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attr'] = this.attr;
    return data;
  }
}
