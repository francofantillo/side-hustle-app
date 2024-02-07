class CardModel {
  bool? status;
  String? message;
  List<DataCard>? data;

  CardModel({this.status, this.message, this.data});

  CardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataCard>[];
      json['data'].forEach((v) {
        data!.add(new DataCard.fromJson(v));
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

class DataCard {
  int? id;
  int? userId;
  String? cardId;
  String? customerId;
  String? last4;
  String? type;
  String? ownerName;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  DataCard(
      {this.id,
        this.userId,
        this.cardId,
        this.customerId,
        this.last4,
        this.type,
        this.ownerName,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  DataCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    customerId = json['customer_id'];
    last4 = json['last4'];
    type = json['type'];
    ownerName = json['owner_name'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['card_id'] = this.cardId;
    data['customer_id'] = this.customerId;
    data['last4'] = this.last4;
    data['type'] = this.type;
    data['owner_name'] = this.ownerName;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
