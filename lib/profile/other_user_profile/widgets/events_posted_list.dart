import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/profile/other_user_profile/widgets/events_posted_item.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class EventsPostedList extends StatefulWidget {
  const EventsPostedList({super.key});

  @override
  State<EventsPostedList> createState() => _EventsPostedListState();
}

class _EventsPostedListState extends State<EventsPostedList> {
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
            child: EventsPostedItemWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.eventsList[index].title,
              subTitle: AlphaAppData.eventsList[index].subTitle,
              imagePath: AlphaAppData.eventsList[index].imagePath,
              price: AlphaAppData.eventsList[index].price,
              userName: AlphaAppData.eventsList[index].userName,
              userRating: AlphaAppData.eventsList[index].userRating,
              userProfile: AlphaAppData.eventsList[index].userProfile,
            ),
          );
        },
      ),
    );
  }
}
