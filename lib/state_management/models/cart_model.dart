class CartModel {
  bool? status;
  String? message;
  DataCart? data;

  CartModel({this.status, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataCart.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataCart {
  int? id;
  int? userId;
  int? ownerId;
  int? shopId;
  double? subTotal;
  int? totalItems;
  String? status;
  int? isAddress;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? street;
  String? apartment;
  String? lat;
  String? lng;
  List<CartDetails>? cartDetails;

  DataCart(
      {this.id,
      this.address,
      this.street,
      this.apartment,
      this.lat,
      this.lng,
      this.userId,
      this.ownerId,
      this.shopId,
      this.subTotal,
      this.totalItems,
      this.status,
      this.isAddress,
      this.createdAt,
      this.updatedAt,
      this.cartDetails});

  DataCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    ownerId = json['owner_id'];
    shopId = json['shop_id'];
    subTotal = json['sub_total']?.toDouble();
    totalItems = json['total_items'];
    status = json['status'];
    isAddress = json['is_address'];
    address = json['address'];
    street = json['street'];
    apartment = json['appartment'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['cart_details'] != null) {
      cartDetails = <CartDetails>[];
      json['cart_details'].forEach((v) {
        cartDetails!.add(CartDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['owner_id'] = this.ownerId;
    data['shop_id'] = this.shopId;
    data['sub_total'] = this.subTotal;
    data['total_items'] = this.totalItems;
    data['status'] = this.status;
    data['is_address'] = this.isAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cartDetails != null) {
      data['cart_details'] = this.cartDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartDetails {
  int? id;
  int? cartId;
  String? type;
  int? productId;
  String? productName;
  String? deliveryType;
  String? serviceType;
  double? price;
  int? qty;
  String? productImage;
  String? description;
  String? address;
  String? street;
  String? apartment;
  String? lat;
  String? lng;
  String? createdAt;
  String? updatedAt;

  CartDetails(
      {this.id,
      this.cartId,
      this.type,
      this.productId,
      this.productName,
      this.deliveryType,
      this.serviceType,
      this.price,
      this.qty,
      this.productImage,
      this.description,
      this.address,
      this.street,
      this.apartment,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt});

  CartDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    type = json['type'];
    productId = json['product_id'];
    productName = json['product_name'];
    deliveryType = json['delivery_type'];
    serviceType = json['service_type'];
    price = json['price']?.toDouble();
    qty = json['qty'];
    productImage = json['product_image'];
    description = json['description'];
    address = json['address'];
    street = json['street'];
    apartment = json['appartment'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['type'] = this.type;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['delivery_type'] = this.deliveryType;
    data['service_type'] = this.serviceType;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['product_image'] = this.productImage;
    data['description'] = this.description;
    data['address'] = this.address;
    data['street'] = this.street;
    data['appartment'] = this.apartment;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
