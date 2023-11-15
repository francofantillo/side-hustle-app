import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:side_hustle/event/widgets/event_post_pacakges_item.dart';

class EventPostPackagesList extends StatefulWidget {
  const EventPostPackagesList({super.key});

  @override
  State<EventPostPackagesList> createState() => _EventPostPackagesListState();
}

class _EventPostPackagesListState extends State<EventPostPackagesList> {
  int defaultCardIndex = 2;
  Map<String, List> defaultCard = {
    "x": [false, false, false],
  };

  Map<String, List> packages = {
    "packages": [
      {
        "packagePrice": 1.00,
        "packageType": "Post per day",
        "default": false,
      },
      {
        "packagePrice": 7.00,
        "packageType": "Post per week",
        "default": false,
      },
      {
        "packagePrice": 30.00,
        "packageType": "Post per Month",
        "default": true,
      }
    ]
  };

  @override
  void initState() {
    setDefaultCardList();
    super.initState();
  }

  setDefaultCardList() {
    for (int i = 0; i < packages["packages"]!.length; i++) {
      defaultCard["x"]![i] = packages["packages"]![i]["default"];
      if (packages["packages"]![i]["default"]) {
        defaultCardIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: packages["packages"]?.length ?? 0,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          if (kDebugMode) {
            print("packages: ${packages["packages"]?[index]["default"]}");
          }
          return Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, left: 8.0, bottom: 10),
              child: EventPostPackagesItem(
                defaultPackage: defaultCard["x"]?[index],
                packageType: packages["packages"]?[index]["packageType"],
                packagePrice: packages["packages"]?[index]["packagePrice"],
                onChanged: (v) {
                  if (v!) {
                    defaultCard["x"]?[defaultCardIndex] = false;
                    defaultCardIndex = index;
                    defaultCard["x"]?[index] = false;
                  } else {
                    defaultCard["x"]?[defaultCardIndex] = false;
                    defaultCardIndex = index;
                    defaultCard["x"]?[index] = true;
                  }
                  setState(() {});
                },
              ));
        },
      ),
    );
  }
}
