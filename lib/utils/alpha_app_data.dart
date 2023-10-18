import 'package:side_hustle/utils/assets_path.dart';

class AlphaAppData {
  /// Home
  /// First Item
  static List<HomeFirstList> homeFirstList = [
    HomeFirstList(name: "Joe’s shop", imagePath: AssetsPath.homeR1),
    HomeFirstList(name: "Brandon's shop", imagePath: AssetsPath.homeR2),
    HomeFirstList(name: "Harry’s shop", imagePath: AssetsPath.homeR3),
    HomeFirstList(name: "Leo’s shop", imagePath: AssetsPath.homeR4),
    HomeFirstList(name: "Kim’s shop", imagePath: AssetsPath.homeR5),
  ];
  /// Jobs And Events List
  static List<JobsAndEvents> jobsAndEventsList = [
    JobsAndEvents(title: "Jobs around you", itemList: jobsAroundYou),
    JobsAndEvents(title: "Events around you", itemList: eventsAroundYou)
  ];
  /// Jobs Around You
  static List<ItemList> jobsAroundYou = [
    ItemList(
        title: "Carpenter",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Leo Lubin",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.userProfileJob)
  ];
  /// Jobs Around You
  static List<ItemList> eventsAroundYou = [
    ItemList(
        title: "Social Event",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Phillip Press",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.social,
        userProfile: AssetsPath.userProfileEvents)
  ];
}

class HomeFirstList {
  final String? name, imagePath;

  HomeFirstList({this.name, this.imagePath});
}

class ItemList {
  final String? title,
      subTitle,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;

  ItemList(
      {this.title,
      this.subTitle,
      this.price,
      this.userProfile,
      this.userName,
      this.userRating,
      this.imagePath});
}

class JobsAndEvents {
  final String? title;
  final List<ItemList>? itemList;

  JobsAndEvents({this.title, this.itemList});
}
