import 'package:side_hustle/state_management/models/events_model.dart';

class GetEditSideHustleModel {
  bool? status;
  String? message;
  EditSideHustleData? editSideHustleData;

  GetEditSideHustleModel({this.status, this.message, this.editSideHustleData});

  GetEditSideHustleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    editSideHustleData = json['data'] != null ? new EditSideHustleData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.editSideHustleData != null) {
      data['data'] = this.editSideHustleData!.toJson();
    }
    return data;
  }
}

class EditSideHustleData {
  int? id;
  int? userId;
  int? shopId;
  String? type;
  String? name;
  double? price;
  double? hourlyRate;
  String? deliveryType;
  String? serviceType;
  String? location;
  String? lat;
  String? lng;
  String? zipCode;
  String? description;
  String? additionalInformation;
  String? createdAt;
  String? updatedAt;
  List<Images>? productImages;

  EditSideHustleData(
      {this.id,
        this.userId,
        this.shopId,
        this.type,
        this.name,
        this.price,
        this.hourlyRate,
        this.deliveryType,
        this.serviceType,
        this.location,
        this.lat,
        this.lng,
        this.zipCode,
        this.description,
        this.additionalInformation,
        this.createdAt,
        this.updatedAt,
        this.productImages});

  EditSideHustleData.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    type = json['type'];
    name = json['name'];
    price = json['price']?.toDouble();
    hourlyRate = json['hourly_rate']?.toDouble();
    deliveryType = json['delivery_type'];
    serviceType = json['service_type'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    zipCode = json['zip_code'];
    description = json['description'];
    additionalInformation = json['additional_information'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product_images'] != null) {
      productImages = <Images>[];
      json['product_images'].forEach((v) {
        productImages!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hourly_rate'] = this.hourlyRate;
    data['delivery_type'] = this.deliveryType;
    data['service_type'] = this.serviceType;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['zip_code'] = this.zipCode;
    data['description'] = this.description;
    data['additional_information'] = this.additionalInformation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
