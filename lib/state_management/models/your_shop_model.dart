class YourShopModel {
  bool? status;
  String? message;
  ShopData? shopData;

  YourShopModel({this.status, this.message, this.shopData});

  YourShopModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    shopData = json['data'] != null ? ShopData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shopData != null) {
      data['data'] = this.shopData!.toJson();
    }
    return data;
  }
}

class ShopData {
  ShopDetail? shopDetail;
  List<ServicesProductsData>? services;
  List<ServicesProductsData>? products;

  ShopData({this.shopDetail, this.services, this.products});

  ShopData.fromJson(Map<String, dynamic> json) {
    shopDetail = json['shop_detail'] != null
        ? new ShopDetail.fromJson(json['shop_detail'])
        : null;
    if (json['services'] != null) {
      services = <ServicesProductsData>[];
      json['services'].forEach((v) {
        services!.add(new ServicesProductsData.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ServicesProductsData>[];
      json['products'].forEach((v) {
        products!.add(new ServicesProductsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopDetail != null) {
      data['shop_detail'] = this.shopDetail!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopDetail {
  int? id;
  String? name;
  String? zipCode;
  String? image;
  String? location;
  String? lat;
  String? lng;
  String? deliveryType;

  ShopDetail(
      {this.id,
      this.name,
      this.zipCode,
      this.image,
      this.location,
      this.lat,
      this.lng,
      this.deliveryType});

  ShopDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    zipCode = json['zip_code'];
    image = json['image'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    deliveryType = json['delivery_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['zip_code'] = this.zipCode;
    data['image'] = this.image;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['delivery_type'] = this.deliveryType;
    return data;
  }
}

class ServicesProductsData {
  int? id;
  int? shopId;
  int? userId;
  String? name;
  double? price;
  double? hourlyRate;
  String? description;
  String? image;
  String? serviceType;
  String? deliveryType;

  ServicesProductsData(
      {this.id,
      this.shopId,
      this.userId,
      this.name,
      this.price,
      this.hourlyRate,
      this.description,
      this.image,
      this.serviceType,
      this.deliveryType});

  ServicesProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    userId = json['user_id'];
    name = json['name'];
    price = json['price']?.toDouble();
    hourlyRate = json['hourly_rate']?.toDouble();
    description = json['description'];
    image = json['image'];
    serviceType = json['service_type'];
    deliveryType = json['delivery_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hourly_rate'] = this.hourlyRate;
    data['description'] = this.description;
    data['image'] = this.image;
    data['service_type'] = this.serviceType;
    data['delivery_type'] = this.deliveryType;
    return data;
  }
}
