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
  String? image;
  String? location;
  String? lat;
  String? lng;

  ShopDetail(
      {this.id, this.name, this.image, this.location, this.lat, this.lng});

  ShopDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class ServicesProductsData {
  int? id;
  int? userId;
  String? name;
  double? price;
  String? description;
  String? image;

  ServicesProductsData(
      {this.id,
      this.userId,
      this.name,
      this.price,
      this.description,
      this.image});

  ServicesProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
