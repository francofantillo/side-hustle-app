class ResumeModel {
  bool? status;
  String? message;
  Data? data;

  ResumeModel({this.status, this.message, this.data});

  ResumeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
  String? profession;
  String? familyTies;
  String? professionalBackground;
  String? favouriteQuote;
  String? description;
  String? filename;
  String? fileSize;
  String? file;
  String? profileImage;
  String? createdAt;
  String? updatedAt;
  List<Hobbies>? hobbies;

  Data(
      {this.id,
        this.userId,
        this.actualName,
        this.nickName,
        this.profession,
        this.familyTies,
        this.professionalBackground,
        this.favouriteQuote,
        this.description,
        this.filename,
        this.fileSize,
        this.file,
        this.profileImage,
        this.createdAt,
        this.updatedAt,
        this.hobbies});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    actualName = json['actual_name'];
    nickName = json['nick_name'];
    profession = json['profession'];
    familyTies = json['family_ties'];
    professionalBackground = json['professional_background'];
    favouriteQuote = json['favourite_quote'];
    description = json['description'];
    filename = json['filename'];
    fileSize = json['file_size'];
    file = json['file'];
    profileImage = json['profile_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['hobbies'] != null) {
      hobbies = <Hobbies>[];
      json['hobbies'].forEach((v) {
        hobbies!.add(new Hobbies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['actual_name'] = this.actualName;
    data['nick_name'] = this.nickName;
    data['profession'] = this.profession;
    data['family_ties'] = this.familyTies;
    data['professional_background'] = this.professionalBackground;
    data['favourite_quote'] = this.favouriteQuote;
    data['description'] = this.description;
    data['filename'] = this.filename;
    data['file_size'] = this.fileSize;
    data['file'] = this.file;
    data['profile_image'] = this.profileImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hobbies != null) {
      data['hobbies'] = this.hobbies!.map((v) => v.toJson()).toList();
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

  Hobbies({this.id, this.resumeId, this.hobby, this.createdAt, this.updatedAt});

  Hobbies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resumeId = json['resume_id'];
    hobby = json['hobby'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resume_id'] = this.resumeId;
    data['hobby'] = this.hobby;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
