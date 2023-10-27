import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/widgets/event_item.dart';
import 'package:side_hustle/favourites/widgets/fav_item_events.dart';
import 'package:side_hustle/job/my_jobs/widgets/completed_job_item.dart';
import 'package:side_hustle/product/widgets/products_items.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';

class MyJobsCompletedList extends StatefulWidget {
  const MyJobsCompletedList({super.key});

  @override
  State<MyJobsCompletedList> createState() => _MyJobsCompletedListState();
}

class _MyJobsCompletedListState extends State<MyJobsCompletedList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            padding: const EdgeInsets.only(right: 16.0, left: 8.0, top: 8),
            child: CompletedJobItemWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemCompletedJobHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.jobsAndEventsList[0].itemList?[0].title,
              subTitle:
              AlphaAppData.jobsAndEventsList[0].itemList?[0].subTitle,
              imagePath: AlphaAppData
                  .jobsAndEventsList[0].itemList?[0].imagePath,
              price: AlphaAppData.jobsAndEventsList[0].itemList?[0].price,
              userName:
              AlphaAppData.jobsAndEventsList[0].itemList?[0].userName,
              userRating: AlphaAppData
                  .jobsAndEventsList[0].itemList?[0].userRating,
              userProfile: AlphaAppData
                  .jobsAndEventsList[0].itemList?[0].userProfile,
            ),
          );
        },
      ),
    );
  }
}
