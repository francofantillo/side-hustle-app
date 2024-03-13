class OrderDetailChatModel {
  bool? status;
  String? message;
  List<Data>? data;

  OrderDetailChatModel({this.status, this.message, this.data});

  OrderDetailChatModel.fromJson(Map<String, dynamic> json) {
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
  int? orderId;
  int? shopId;
  int? productId;
  String? type;
  String? productName;
  String? deliveryType;
  String? serviceType;
  String? productPerPrice;
  int? productQty;
  String? productSubtotalPrice;
  String? productImage;
  String? deliveryAddress;
  String? street;
  String? appartment;
  String? lat;
  String? lng;
  String? serviceDate;
  String? hoursRequired;
  String? startTime;
  String? endTime;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.orderId,
        this.shopId,
        this.productId,
        this.type,
        this.productName,
        this.deliveryType,
        this.serviceType,
        this.productPerPrice,
        this.productQty,
        this.productSubtotalPrice,
        this.productImage,
        this.deliveryAddress,
        this.street,
        this.appartment,
        this.lat,
        this.lng,
        this.serviceDate,
        this.hoursRequired,
        this.startTime,
        this.endTime,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    shopId = json['shop_id'];
    productId = json['product_id'];
    type = json['type'];
    productName = json['product_name'];
    deliveryType = json['delivery_type'];
    serviceType = json['service_type'];
    productPerPrice = json['product_per_price'];
    productQty = json['product_qty'];
    productSubtotalPrice = json['product_subtotal_price'];
    productImage = json['product_image'];
    deliveryAddress = json['delivery_address'];
    street = json['street'];
    appartment = json['appartment'];
    lat = json['lat'];
    lng = json['lng'];
    serviceDate = json['service_date'];
    hoursRequired = json['hours_required'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['shop_id'] = this.shopId;
    data['product_id'] = this.productId;
    data['type'] = this.type;
    data['product_name'] = this.productName;
    data['delivery_type'] = this.deliveryType;
    data['service_type'] = this.serviceType;
    data['product_per_price'] = this.productPerPrice;
    data['product_qty'] = this.productQty;
    data['product_subtotal_price'] = this.productSubtotalPrice;
    data['product_image'] = this.productImage;
    data['delivery_address'] = this.deliveryAddress;
    data['street'] = this.street;
    data['appartment'] = this.appartment;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['service_date'] = this.serviceDate;
    data['hours_required'] = this.hoursRequired;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
