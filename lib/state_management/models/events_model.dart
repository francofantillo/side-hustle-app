class EventsModel {
  bool? status;
  String? message;
  EventsData? eventDetails;
  List<EventsData>? events;

  EventsModel({this.status, this.message, this.eventDetails});

  EventsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] is List) {
      if (json['data'] != null) {
        events = <EventsData>[];
        json['data'].forEach((v) {
          events!.add(EventsData.fromJson(v));
        });
      }
    } else {
      eventDetails =
          json['data'] != null ? EventsData.fromJson(json['data']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;

    if (this.eventDetails != null) {
      data['data'] = this.eventDetails!.toJson();
    }
    return data;
  }
}

class EventsData {
  List<Images>? images;
  String? image;
  int? isFavourite;
  String? lat;
  String? lng;
  String? name;
  EventOwnerDetail? eventOwnerDetail;
  int? eventId;
  String? eventName;
  double? price;
  String? location;
  String? startDate;
  String? startTime;
  String? endTime;
  String? purpose;
  String? theme;
  List<String>? vendorsList;
  List<AvailableAttractions>? availableAttractions;
  String? paymentType;
  int? isInterested;

  EventsData(
      {this.images,
      this.isFavourite,
      this.image,
      this.name,
      this.lat,
      this.lng,
      this.eventOwnerDetail,
      this.eventId,
      this.eventName,
      this.price,
      this.location,
      this.startDate,
      this.startTime,
      this.endTime,
      this.purpose,
      this.theme,
      this.vendorsList,
      this.availableAttractions,
      this.isInterested,
      this.paymentType});

  EventsData.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    eventOwnerDetail = json['event_owner_detail'] != null
        ? EventOwnerDetail.fromJson(json['event_owner_detail'])
        : null;
    eventId = json['event_id'];
    image = json['image'];
    isFavourite = json['is_favourite'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    eventName = json['event_name'];
    // price = json['price'] != null ? json['price'].toString() : json['price'];
    price = json['price']?.toDouble();
    location = json['location'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    purpose = json['purpose'];
    theme = json['theme'];
    vendorsList = json['vendors_list']?.cast<String>();
    if (json['available_attractions'] != null) {
      availableAttractions = <AvailableAttractions>[];
      json['available_attractions'].forEach((v) {
        availableAttractions!.add(AvailableAttractions.fromJson(v));
      });
    }
    paymentType = json['payment_type'];
    isInterested = json['is_interested'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.eventOwnerDetail != null) {
      data['event_owner_detail'] = this.eventOwnerDetail!.toJson();
    }
    data['event_id'] = this.eventId;
    data['image'] = this.image;
    data['is_favourite'] = this.isFavourite;
    data['name'] = this.name;
    data['event_name'] = this.eventName;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['price'] = this.price;
    data['location'] = this.location;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['purpose'] = this.purpose;
    data['theme'] = this.theme;
    data['vendors_list'] = this.vendorsList;
    if (this.availableAttractions != null) {
      data['available_attractions'] =
          this.availableAttractions!.map((v) => v.toJson()).toList();
    }
    data['payment_type'] = this.paymentType;
    data['is_interested'] = this.isInterested;
    return data;
  }
}

class Images {
  int? id;
  String? image;

  Images({this.image, this.id});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }
}

class EventOwnerDetail {
  int? isOwner;
  int? id;
  String? name;
  String? rating;
  String? image;

  EventOwnerDetail({this.isOwner, this.id, this.name, this.rating, this.image});

  EventOwnerDetail.fromJson(Map<String, dynamic> json) {
    isOwner = json['is_owner'];
    id = json['id'];
    name = json['name'];
    rating =
        json['rating'] != null ? json['rating'].toString() : json['rating'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['is_owner'] = this.isOwner;
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['image'] = this.image;
    return data;
  }
}

class AvailableAttractions {
  String? attr;

  AvailableAttractions({this.attr});

  AvailableAttractions.fromJson(Map<String, dynamic> json) {
    attr = json['attr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['attr'] = this.attr;
    return data;
  }
}
