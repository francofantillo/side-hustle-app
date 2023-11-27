

import 'package:side_hustle/event/model/attendees_model.dart';
import 'package:side_hustle/utils/assets_path.dart';

class AppList {

  static const List vendorsListData = [
    "Burgers",
    "BBQ",
    "Wraps",
    "Hot dogs",
    "Fries",
    "Ice Cream",
  ];
  static const List attractionList = [
    "Child Care",
    "Bounce House",
    "Full Bar",
    "Swimming Pool",
    "Musical Chair",
    "Stand Up Comedy",
    "Music"
  ];
  static List<Attendees> attendeesList = [
    Attendees("Shanaya Kale", AssetsPath.placeHolderProfileImage),
    Attendees("Angelina", AssetsPath.placeHolderProfileImage),
    Attendees("Natasha", AssetsPath.placeHolderProfileImage),
    Attendees("Jane", AssetsPath.placeHolderProfileImage),
    Attendees("Angelina", AssetsPath.placeHolderProfileImage),
    Attendees("Katty", AssetsPath.placeHolderProfileImage),
    Attendees("Johnny", AssetsPath.placeHolderProfileImage),
    Attendees("Rose", AssetsPath.placeHolderProfileImage)
  ];

}