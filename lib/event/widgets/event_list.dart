import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/widgets/event_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.14.sh),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
          itemCount: 4,
          // Replace with your item count
          itemBuilder: (context, index) {
            // Replace with your horizontal list item
            return Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 8.0),
              child: EventItemsWidget(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.viewEventScreenRoute);
                },
                imageWidth: 1.sw,
                imageHeight: AppDimensions.listItemHeight,
                boarderColor: AppColors.itemBGColor,
                title: AlphaAppData.eventsList[index].title,
                location:
                AlphaAppData.eventsList[index].subTitle,
                imagePath: AlphaAppData.eventsList[index].imagePath,
                price: AlphaAppData.eventsList[index].price,
                userName:
                AlphaAppData.eventsList[index].userName,
                userRating: AlphaAppData.eventsList[index].userRating,
                userProfile: AlphaAppData.eventsList[index].userProfile,
              ),
            );
          },
        ),
      ),
    );
  }
}
