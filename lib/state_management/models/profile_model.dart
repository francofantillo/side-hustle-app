class ProfileModel {
  bool? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? image;
  int? myJobs;
  int? completedJobs;
  int? myEvents;

  Data(
      {this.id,
        this.name,
        this.email,
        this.image,
        this.myJobs,
        this.completedJobs,
        this.myEvents});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    myJobs = json['my_jobs'];
    completedJobs = json['completed_jobs'];
    myEvents = json['my_events'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['my_jobs'] = this.myJobs;
    data['completed_jobs'] = this.completedJobs;
    data['my_events'] = this.myEvents;
    return data;
  }
}
