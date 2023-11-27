import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/widgets/scheduled_job_item.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

import '../../../router/app_route_named.dart';

class MyJobsScheduledList extends StatefulWidget {
  const MyJobsScheduledList({super.key});

  @override
  State<MyJobsScheduledList> createState() => _MyJobsScheduledListState();
}

class _MyJobsScheduledListState extends State<MyJobsScheduledList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: 4,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          return Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0, top: 8),
            child: ScheduledJobItemWidget(
              onTap: () {
                Navigator.pushNamed(
                    context, AppRoutes.viewJobScreenRoute);
              },
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemJobScheduledHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.myJobsScheduleList[index].title,
              subTitle: AlphaAppData.myJobsScheduleList[index].subTitle,
              imagePath: AlphaAppData.myJobsScheduleList[index].imagePath,
              price: AlphaAppData.myJobsScheduleList[index].price,
              userName: AlphaAppData.myJobsScheduleList[index].userName,
              userRating: AlphaAppData.myJobsScheduleList[index].userRating,
              userProfile: AlphaAppData.myJobsScheduleList[index].userProfile,
            ),
          );
        },
      ),
    );
  }
}
