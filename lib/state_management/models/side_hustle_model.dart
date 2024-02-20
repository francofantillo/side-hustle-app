class SideHustleModel {
  bool? status;
  String? message;
  List<SideHustleData>? sideHustleData;

  SideHustleModel({this.status, this.message, this.sideHustleData});

  SideHustleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      sideHustleData = <SideHustleData>[];
      json['data'].forEach((v) {
        sideHustleData!.add(new SideHustleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.sideHustleData != null) {
      data['data'] = this.sideHustleData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SideHustleData {
  int? id;
  String? name;
  double? price;
  String? description;
  String? image;
  String? deliveryType;
  String? serviceType;

  SideHustleData({this.id, this.name, this.price, this.description, this.image, this.deliveryType, this.serviceType});

  SideHustleData.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    price = json['price']?.toDouble();
    description = json['description'];
    image = json['image'];
    deliveryType = json['delivery_type'];
    serviceType = json['service_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['delivery_type'] = this.deliveryType;
    data['service_type'] = this.serviceType;
    return data;
  }
}
