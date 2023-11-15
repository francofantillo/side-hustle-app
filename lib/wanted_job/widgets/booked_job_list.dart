import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job.dart';

class BookedTabList extends StatefulWidget {
  const BookedTabList({super.key});

  @override
  State<BookedTabList> createState() => _BookedTabListState();
}

class _BookedTabListState extends State<BookedTabList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.14.sh, top: 8),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
          itemCount: 3,
          // Replace with your item count
          itemBuilder: (context, index) {
            // Replace with your horizontal list item
            return Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 8.0),
              child: BookedJobsWidget(
                  imageWidth: 1.sw,
                  imageHeight: AppDimensions.listItemHeight,
                  boarderColor: AppColors.itemBGColor,
                  title: AlphaAppData.wantedJobList[index].title,
                  subTitle: AlphaAppData.wantedJobList[index].subTitle,
                  imagePath: AlphaAppData.wantedJobList[index].imagePath,
                  price: AlphaAppData.wantedJobList[index].price
              ),
            );
          },
        ),
      ),
    );
  }
}
