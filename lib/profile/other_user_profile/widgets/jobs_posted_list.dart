import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/profile/other_user_profile/widgets/jobs_posted_item.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class JobsPostedList extends StatefulWidget {
  const JobsPostedList({super.key});

  @override
  State<JobsPostedList> createState() => _JobsPostedListState();
}

class _JobsPostedListState extends State<JobsPostedList> {
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
            child: JobsPostedItemWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.otherUsersJobsPostedList[index].title,
              subTitle: AlphaAppData.otherUsersJobsPostedList[index].subTitle,
              imagePath:
              AlphaAppData.otherUsersJobsPostedList[index].imagePath,
              price: AlphaAppData.otherUsersJobsPostedList[index].price,
              userName: AlphaAppData.otherUsersJobsPostedList[index].userName,
              userRating:
              AlphaAppData.otherUsersJobsPostedList[index].userRating,
              userProfile:
              AlphaAppData.otherUsersJobsPostedList[index].userProfile,
            ),
          );
        },
      ),
    );
  }
}
