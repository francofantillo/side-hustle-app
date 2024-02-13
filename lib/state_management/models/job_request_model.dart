class JobRequestModel {
  bool? status;
  String? message;
  List<JobRequestData>? data;

  JobRequestModel({this.status, this.message, this.data});

  JobRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <JobRequestData>[];
      json['data'].forEach((v) {
        data!.add(JobRequestData.fromJson(v));
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

class JobRequestData {
  int? jobRequestId;
  int? jobId;
  double? bidAmount;
  int? userId;
  String? username;
  double? rating;
  String? image;

  JobRequestData(
      {this.jobRequestId,
        this.jobId,
        this.bidAmount,
        this.userId,
        this.username,
        this.rating,
        this.image});

  JobRequestData.fromJson(Map<String, dynamic> json) {

    jobRequestId = json['job_request_id'];
    jobId = json['job_id'];
    bidAmount = json['bid_amount']?.toDouble();
    userId = json['user_id'];
    username = json['username'];
    rating = json['rating']?.toDouble();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_request_id'] = this.jobRequestId;
    data['job_id'] = this.jobId;
    data['bid_amount'] = this.bidAmount;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['rating'] = this.rating;
    data['image'] = this.image;
    return data;
  }
}
