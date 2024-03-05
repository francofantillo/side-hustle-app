class UserModel {
  bool? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? name;
  int? isVerified;
  String? email;
  String? otp;
  String? phone;
  String? zipCode;
  String? country;
  String? image;
  double? rating;
  String? apiToken;
  String? fcmToken;
  String? accessToken;
  int? isPushNotification;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.roleId,
      this.firstName,
      this.lastName,
      this.name,
      this.email,
      this.otp,
      this.phone,
      this.zipCode,
      this.country,
      this.image,
      this.rating,
      this.apiToken,
      this.fcmToken,
      this.accessToken,
      this.isPushNotification,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    isVerified = json['is_verified'];
    lastName = json['last_name'];
    name = json['name'];
    email = json['email'];
    otp = json['otp'] != null ? json['otp'].toString() : null;
    phone = json['phone'];
    zipCode = json['zip_code'];
    country = json['country'];
    image = json['image'];
    rating = json['rating']?.toDouble();
    apiToken = json['api_token'];
    fcmToken = json['fcm_token'];
    accessToken = json['access_token'];
    isPushNotification = json['is_push_notification'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['name'] = name;
    data['email'] = email;
    data['otp'] = otp;
    data['phone'] = phone;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['image'] = image;
    data['rating'] = rating;
    data['api_token'] = apiToken;
    data['fcm_token'] = fcmToken;
    data['access_token'] = accessToken;
    data['is_push_notification'] = isPushNotification;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
