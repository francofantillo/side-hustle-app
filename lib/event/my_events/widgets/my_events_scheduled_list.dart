import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_scheduled_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';

class MyEventsScheduledList extends StatefulWidget {
  const MyEventsScheduledList({super.key});

  @override
  State<MyEventsScheduledList> createState() => _MyEventsScheduledListState();
}

class _MyEventsScheduledListState extends State<MyEventsScheduledList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: 3,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          return Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0, top: 8),
            child: MyEventsScheduledItemsWidget(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.viewEventSelfScreenRoute);
              },
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemEventScheduledHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.favEventsList[index].title,
              subTitle: AlphaAppData.favEventsList[index].subTitle,
              imagePath: AlphaAppData.favEventsList[index].imagePath,
              // imagePath: AssetsPath.imageLoadError,
              price: AlphaAppData.favEventsList[index].price,
              userName: AlphaAppData.favEventsList[index].userName,
              userRating: AlphaAppData.favEventsList[index].userRating,
              userProfile: AlphaAppData.favEventsList[index].userProfile,
            ),
          );
        },
      ),
    );
  }
}
