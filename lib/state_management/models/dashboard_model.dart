class DashboardModel {
  bool? status;
  String? message;
  Data? data;

  DashboardModel({this.status, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  List<Shops>? shops;
  List<Jobs>? jobs;
  List<Events>? events;
  List<Banners>? banners;

  Data({this.shops, this.jobs, this.events, this.banners});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(new Shops.fromJson(v));
      });
    }
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
  int? shopId;
  String? name;
  String? image;

  Shops({this.shopId, this.name, this.image});

  Shops.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Jobs {
  int? jobId;
  String? name;
  String? image;
  String? description;
  double? price;
  UserDetail? userDetail;

  Jobs(
      {this.jobId,
        this.name,
        this.image,
        this.description,
        this.price,
        this.userDetail});

  Jobs.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price']?.toDouble();
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['bid_amount'] = this.price;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class Events {
  int? eventId;
  String? name;
  String? image;
  String? purpose;
  double? price;
  UserDetail? userDetail;

  Events(
      {this.eventId,
        this.name,
        this.image,
        this.purpose,
        this.price,
        this.userDetail});

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    name = json['name'];
    image = json['image'];
    purpose = json['purpose'];
    price = json['price']?.toDouble();
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['purpose'] = this.purpose;
    data['price'] = this.price;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  int? userid;
  String? name;
  String? image;
  double? rating;

  UserDetail({this.userid, this.name, this.image, this.rating});

  UserDetail.fromJson(Map<String, dynamic> json) {

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

class Banners {
  int? id;
  String? name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  Banners(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
