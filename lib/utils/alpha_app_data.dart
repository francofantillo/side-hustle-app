import 'package:side_hustle/utils/assets_path.dart';

class AlphaAppData {
  /// Home
  /// First Item
  static List<HomeFirstList> homeFirstList = [
    HomeFirstList(name: "Joe’s shop", imagePath: AssetsPath.homeR1),
    // HomeFirstList(name: "Joe’s shop", imagePath: "https://picsum.photos/200/300"),
    HomeFirstList(name: "Brandon's shop", imagePath: AssetsPath.homeR2),
    HomeFirstList(name: "Harry’s shop", imagePath: AssetsPath.homeR3),
    HomeFirstList(name: "Leo’s shop", imagePath: AssetsPath.homeR4),
    HomeFirstList(name: "Kim’s shop", imagePath: AssetsPath.homeR5),
  ];

  /// Chat all users Messages List
  static final List<ChatAllUsersItemModel> chatAllUsersList = [
    ChatAllUsersItemModel(
        name: "Talan Calzoni",
        message: "You: Hey! How are you doing?",
        time: "18 Aug, 2023"),
    ChatAllUsersItemModel(
        image: AssetsPath.chatUser1,
        name: "Terry Levin",
        message: "You: Hey! How are you doing?",
        time: "18 Aug, 2023"),
    ChatAllUsersItemModel(
        image: AssetsPath.chatUser2,
        name: "Abram Bergson",
        message: "You: Hey! How are you doing?",
        time: "18 Aug, 2023"),
    ChatAllUsersItemModel(
        image: AssetsPath.chatUser3,
        name: "Wilson Septimus",
        message: "You: Hey! How are you doing?",
        time: "18 Aug, 2023"),
    ChatAllUsersItemModel(
        image: AssetsPath.chatUser4,
        name: "Nolan Ekstrom Bothman",
        message: "You: Hey! How are you doing?",
        time: "18 Aug, 2023"),
    ChatAllUsersItemModel(
        image: AssetsPath.chatUser5,
        name: "Nolan Carder",
        message: "You: Hey! How are you doing?",
        time: "18 Aug, 2023"),
  ];

  /// Jobs And Events List
  static List<JobsAndEvents> jobsAndEventsList = [
    JobsAndEvents(title: "Wanted Jobs around you", itemList: jobsAroundYou),
    JobsAndEvents(title: "Events around you", itemList: eventsAroundYou)
  ];

  /// Wanted Jobs Around You
  static List<ItemList> jobsAroundYou = [
    ItemList(
        title: "Carpenter",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Leo Lubin",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.leoLubinProfile)
  ];

  /// Events Around You
  static List<ItemList> eventsAroundYou = [
    ItemList(
        title: "Social Event",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Phillip Press",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.social,
        userProfile: AssetsPath.phillipPressProfile)
  ];

  /// Events List
  static List<ItemList> eventsList = [
    ItemList(
        title: "Musical Event",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Leo Lubin",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.musical,
        userProfile: AssetsPath.leoLubinProfile),
    ItemList(
        title: "Social Event",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Leo Lubin",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.event2,
        userProfile: AssetsPath.leoLubinProfile),
    ItemList(
        title: "Party Event",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Leo Lubin",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.event3,
        userProfile: AssetsPath.leoLubinProfile),
    ItemList(
        title: "Beach Event",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Leo Lubin",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.event4,
        userProfile: AssetsPath.leoLubinProfile),
  ];

  /// Wanted Jobs List
  static List<ItemList> wantedJobList = [
    ItemList(
        title: "Carpenter",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Emerson Aminoff",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: "https://i.pravatar.cc/150?img=8"),
    ItemList(
        title: "Cleaner",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Talan Stanton",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.cleaner,
        userProfile: "https://i.pravatar.cc/150?img=18"),
    ItemList(
        title: "Electrician",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Corey Philips",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.electrician,
        userProfile: "https://i.pravatar.cc/150?img=13"),
  ];

  /// Side Hustle Products List
  static List<ItemList> sideHustleProductsList = [
    ItemList(
        title: "Watch",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Emerson Aminoff",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.watch,
        userProfile: "https://i.pravatar.cc/150?img=8"),
    ItemList(
        title: "Mouse",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Talan Stanton",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.mouse,
        userProfile: "https://i.pravatar.cc/150?img=18"),
    ItemList(
        title: "Keyboard",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Corey Philips",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.mouse,
        userProfile: "https://i.pravatar.cc/150?img=13"),
    ItemList(
        title: "Eggs",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Corey Philips",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.mouse,
        userProfile: "https://i.pravatar.cc/150?img=13"),
  ];

  /// Side Hustle Services List
  static List<ItemList> sideHustleServicesList = [
    ItemList(
        title: "Carpenter",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Emerson Aminoff",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.plumber,
        userProfile: "https://i.pravatar.cc/150?img=8"),
    ItemList(
        title: "Graphics Designing",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Talan Stanton",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.mouse,
        userProfile: "https://i.pravatar.cc/150?img=18"),
    ItemList(
        title: "Web Development",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Corey Philips",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.mouse,
        userProfile: "https://i.pravatar.cc/150?img=13"),
    ItemList(
        title: "Cleaner",
        subTitle:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Corey Philips",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.mouse,
        userProfile: "https://i.pravatar.cc/150?img=13"),
  ];

  /// Post Service Images List
  static List<String> postServiceImagesList = [
    AssetsPath.carpenter,
    AssetsPath.carpenter,
    AssetsPath.carpenter
  ];

  /// Post Product Images List
  static List<String> postProductImagesList = [
    AssetsPath.headphones,
    AssetsPath.headphones,
    AssetsPath.headphones
  ];

  /// Brandon Gouse Profile Image
  static const String dpProfile = "https://i.pravatar.cc/150?img=14";

  /// My Jobs Schedule List
  static List<ItemList> myJobsScheduleList = [
    ItemList(
        title: "Carpenter",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Davis Dorwart",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Cleaner",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Brandon Korsgaard",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.cleaner,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Driver",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Terry Botosh",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.driver,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Carpenter",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Emerson Aminoff",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.plumber,
        userProfile: "https://i.pravatar.cc/150?img=8"),
  ];

  /// My Jobs Onging List
  static List<ItemList> myJobsOngoingList = [
    ItemList(
        title: "Carpenter",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Davis Dorwart",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Cleaner",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Brandon Korsgaard",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.cleaner,
        userProfile: AssetsPath.phillipPressProfile),
  ];

  /// Fav Events List
  static List<ItemList> favEventsList = [
    ItemList(
        title: "Musical Event",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Jaylon Gouse",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.fav1,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Social Event",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Marcus Arcand",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.fav2,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Children’s Birthday",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "James Curtis",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.fav3,
        userProfile: AssetsPath.phillipPressProfile),
  ];

  /// Fav Jobs List
  static List<ItemList> favJobsList = [
    ItemList(
        title: "Carpenter",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Davis Dorwart",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Driver",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Terry Botosh",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.driver,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Cleaner",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Brandon Korsgaard",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.cleaner,
        userProfile: AssetsPath.phillipPressProfile),
  ];

  /// Fav Shops List
  static List<ItemList> favShopsList = [
    ItemList(
        title: "Gustavo Rosser’s Shop",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Gustavo Rosser",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Jakob Donin’s Shop",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Jakob Donin",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Carter Curtis’s Shop",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Carter Curtis",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.phillipPressProfile),
    ItemList(
        title: "Ruben Press’s Shop",
        subTitle:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        userName: "Ruben Press",
        userRating: "5.0 ratings",
        price: "\$24.56",
        imagePath: AssetsPath.carpenter,
        userProfile: AssetsPath.phillipPressProfile),
  ];

}

class ChatAllUsersItemModel {
  final String? image, name, message, time;

  ChatAllUsersItemModel({this.image, this.name, this.message, this.time});
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
