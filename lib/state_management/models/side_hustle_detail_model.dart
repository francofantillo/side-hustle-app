import 'package:side_hustle/state_management/models/events_model.dart';

class SideHustleDetailModel {
  bool? status;
  String? message;
  Data? data;

  SideHustleDetailModel({this.status, this.message, this.data});

  SideHustleDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<Images>? images;
  int? productId;
  int? shopId;
  String? name;
  double? price;
  String? description;
  String? zipCode;
  String? deliveryType;
  String? serviceType;
  ProductOwner? productOwner;

  Data(
      {this.images,
        this.productId,
        this.shopId,
        this.name,
        this.price,
        this.description,
        this.zipCode,
        this.deliveryType,
        this.serviceType,
        this.productOwner});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    productId = json['product_id'];
    shopId = json['shop_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    zipCode = json['zip_code'];
    deliveryType = json['delivery_type'];
    serviceType = json['service_type'];
    productOwner = json['product_owner'] != null
        ? new ProductOwner.fromJson(json['product_owner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['product_id'] = this.productId;
    data['shop_id'] = this.shopId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['zip_code'] = this.zipCode;
    data['delivery_type'] = this.deliveryType;
    data['service_type'] = this.serviceType;
    if (this.productOwner != null) {
      data['product_owner'] = this.productOwner!.toJson();
    }
    return data;
  }
}

/*class Images {
  int? id;
  int? productId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images({this.id, this.productId, this.image, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/

class ProductOwner {
  int? userid;
  String? name;
  Null? image;

  ProductOwner({this.userid, this.name, this.image});

  ProductOwner.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
