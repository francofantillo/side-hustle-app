

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
    Attendees("Shanaya Kale", AssetsPath.shanaya),
    Attendees("Angelina", AssetsPath.angelina),
    Attendees("Natasha", AssetsPath.natasha),
    Attendees("Jane", AssetsPath.jane),
    Attendees("Angelina", AssetsPath.angelina_2),
    Attendees("Katty", AssetsPath.katty),
    Attendees("Johnny", AssetsPath.johnny),
    Attendees("Rose", AssetsPath.rose)
  ];

}