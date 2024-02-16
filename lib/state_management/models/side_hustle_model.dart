class SideHustleModel {
  bool? status;
  String? message;
  List<Data>? data;

  SideHustleModel({this.status, this.message, this.data});

  SideHustleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String? name;
  double? price;
  String? description;
  String? image;

  Data({this.id, this.name, this.price, this.description, this.image});

  Data.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    price = json['price']?.toDouble();
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
