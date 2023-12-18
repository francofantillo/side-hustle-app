class ResumeModel {
  bool? status;
  String? message;
  Data? data;

  ResumeModel({this.status, this.message, this.data});

  ResumeModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? actualName;
  String? nickName;
  String? familyTies;
  String? professionalBackground;
  String? favouriteQuote;
  String? description;
  String? file;
  String? profileImage;
  String? createdAt;
  String? updatedAt;
  List<Hobbies>? hobbies;

  Data({
    this.id,
    this.userId,
    this.actualName,
    this.nickName,
    this.familyTies,
    this.professionalBackground,
    this.favouriteQuote,
    this.description,
    this.file,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.hobbies,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    actualName = json['actual_name'];
    nickName = json['nick_name'];
    familyTies = json['family_ties'];
    professionalBackground = json['professional_background'];
    favouriteQuote = json['favourite_quote'];
    description = json['description'];
    file = json['file'];
    profileImage = json['profile_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['hobbies'] != null) {
      hobbies = <Hobbies>[];
      json['hobbies'].forEach((dynamic v) {
        hobbies!.add(Hobbies.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['actual_name'] = actualName;
    data['nick_name'] = nickName;
    data['family_ties'] = familyTies;
    data['professional_background'] = professionalBackground;
    data['favourite_quote'] = favouriteQuote;
    data['description'] = description;
    data['file'] = file;
    data['profile_image'] = profileImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (hobbies != null) {
      data['hobbies'] = hobbies!.map((Hobbies v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hobbies {
  int? id;
  int? resumeId;
  String? hobby;
  String? createdAt;
  String? updatedAt;

  Hobbies({
    this.id,
    this.resumeId,
    this.hobby,
    this.createdAt,
    this.updatedAt,
  });

  Hobbies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resumeId = json['resume_id'];
    hobby = json['hobby'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['resume_id'] = resumeId;
    data['hobby'] = hobby;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
