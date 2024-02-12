// class GetEditJobModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   GetEditJobModel({this.status, this.message, this.data});
//
//   GetEditJobModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? userId;
//   int? assignedUserId;
//   String? title;
//   int? bidAmount;
//   double? budget;
//   String? areaCode;
//   String? jobDate;
//   String? jobTime;
//   String? endTime;
//   int? totalHours;
//   String? location;
//   String? lat;
//   String? lng;
//   String? description;
//   String? additionalInformation;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   List<Images>? images;
//
//   Data(
//       {this.id,
//         this.userId,
//         this.assignedUserId,
//         this.title,
//         this.bidAmount,
//         this.budget,
//         this.areaCode,
//         this.jobDate,
//         this.jobTime,
//         this.endTime,
//         this.totalHours,
//         this.location,
//         this.lat,
//         this.lng,
//         this.description,
//         this.additionalInformation,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.images});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     assignedUserId = json['assigned_user_id'];
//     title = json['title'];
//     bidAmount = json['bid_amount'];
//     budget = json['budget'];
//     areaCode = json['area_code'];
//     jobDate = json['job_date'];
//     jobTime = json['job_time'];
//     endTime = json['end_time'];
//     totalHours = json['total_hours'];
//     location = json['location'];
//     lat = json['lat'];
//     lng = json['lng'];
//     description = json['description'];
//     additionalInformation = json['additional_information'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['assigned_user_id'] = this.assignedUserId;
//     data['title'] = this.title;
//     data['bid_amount'] = this.bidAmount;
//     data['budget'] = this.budget;
//     data['area_code'] = this.areaCode;
//     data['job_date'] = this.jobDate;
//     data['job_time'] = this.jobTime;
//     data['end_time'] = this.endTime;
//     data['total_hours'] = this.totalHours;
//     data['location'] = this.location;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     data['description'] = this.description;
//     data['additional_information'] = this.additionalInformation;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Images {
//   int? id;
//   int? jobId;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//
//   Images({this.id, this.jobId, this.image, this.createdAt, this.updatedAt});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['job_id'];
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['job_id'] = this.jobId;
//     data['image'] = this.image;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
