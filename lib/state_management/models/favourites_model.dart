class FavouritesModel {
  bool? status;
  String? message;
  List<Data>? favourites;

  FavouritesModel({this.status, this.message, this.favourites});

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      favourites = <Data>[];
      json['data'].forEach((v) {
        favourites!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.favourites != null) {
      data['data'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  double? price;
  String? location;
  OwnerDetail? ownerDetail;

  Data(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.location,
      this.ownerDetail});

  Data.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    image = json['image'];
    // price = json['price'] != null ? json['price'].toString() : json['price'];
    price = json['price']?.toDouble();
    location = json['location'];
    ownerDetail = json['owner_detail'] != null
        ? new OwnerDetail.fromJson(json['owner_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['location'] = this.location;
    if (this.ownerDetail != null) {
      data['owner_detail'] = this.ownerDetail!.toJson();
    }
    return data;
  }
}

class OwnerDetail {
  int? id;
  String? name;
  String? image;
  String? rating;

  OwnerDetail({this.id, this.name, this.image, this.rating});

  OwnerDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rating =
        json['rating'] != null ? json['rating'].toString() : json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rating'] = this.rating;
    return data;
  }
}
