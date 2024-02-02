import 'package:side_hustle/state_management/models/edit_event_model.dart';
import 'package:side_hustle/state_management/models/events_model.dart';

class JobsModel {
  bool? status;
  String? message;
  List<JobsData>? jobs;
  JobsDetail? jobsDetailData;

  JobsModel({this.status, this.message, this.jobs});

  JobsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] is List) {
      if (json['data'] != null) {
        jobs = <JobsData>[];
        json['data'].forEach((v) {
          jobs!.add(new JobsData.fromJson(v));
        });
      }
    } else {
      jobsDetailData =
      json['data'] != null ? JobsDetail.fromJson(json['data']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.jobs != null) {
      data['data'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    if (this.jobsDetailData != null) {
      data['data'] = this.jobsDetailData!.toJson();
    }
    return data;
  }
}

class JobsData {
  int? jobId;
  String? title;
  String? description;
  double? budget;
  String? image;
  User? user;

  JobsData(
      {this.jobId,
        this.title,
        this.description,
        this.budget,
        this.image,
        this.user});

  JobsData.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    title = json['title'];
    description = json['description'];
    budget = json['budget']?.toDouble();
    image = json['image'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['budget'] = this.budget;
    data['image'] = this.image;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? userid;
  String? name;
  String? image;
  double? rating;

  User({this.userid, this.name, this.image, this.rating});

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    image = json['image'];
    rating = json['rating']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rating'] = this.rating;
    return data;
  }
}

class JobsDetail {
  String? title;
  double? budget;
  String? areaCode;
  String? jobDate;
  String? jobTime;
  String? endTime;
  String? totalHours;
  String? location;
  String? lat;
  String? lng;
  String? description;
  String? additionalInformation;
  String? status;
  User? userDetail;
  List<Images>? images;

  JobsDetail(
      {this.title,
        this.budget,
        this.areaCode,
        this.jobDate,
        this.jobTime,
        this.endTime,
        this.totalHours,
        this.location,
        this.lat,
        this.lng,
        this.description,
        this.additionalInformation,
        this.status,
        this.userDetail,
        this.images});

  JobsDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    budget = json['budget']?.toDouble();
    areaCode = json['area_code'];
    jobDate = json['job_date'];
    jobTime = json['job_time'];
    endTime = json['end_time'];
    totalHours = json['total_hours'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    description = json['description'];
    additionalInformation = json['additional_information'];
    status = json['status'];
    userDetail =
    json['user_detail'] != null ? User.fromJson(json['user_detail']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['budget'] = this.budget;
    data['area_code'] = this.areaCode;
    data['job_date'] = this.jobDate;
    data['job_time'] = this.jobTime;
    data['end_time'] = this.endTime;
    data['total_hours'] = this.totalHours;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['description'] = this.description;
    data['additional_information'] = this.additionalInformation;
    data['status'] = this.status;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
