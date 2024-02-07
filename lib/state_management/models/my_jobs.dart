class MyJobsModel {
  bool? status;
  String? message;
  List<MyJobsData>? myJobs;

  MyJobsModel({this.status, this.message, this.myJobs});

  MyJobsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      myJobs = <MyJobsData>[];
      json['data'].forEach((v) {
        myJobs!.add(new MyJobsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.myJobs != null) {
      data['data'] = this.myJobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyJobsData {
  int? jobId;
  String? image;
  String? title;
  String? description;
  double? budget;

  MyJobsData({this.jobId, this.image, this.title, this.description, this.budget});

  MyJobsData.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    budget = json['budget']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    data['budget'] = this.budget;
    return data;
  }
}
