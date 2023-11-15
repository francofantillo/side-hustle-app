import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/home/widgets/items_widget.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class WantedTabList extends StatefulWidget {
  const WantedTabList({super.key});

  @override
  State<WantedTabList> createState() => _WantedTabListState();
}

class _WantedTabListState extends State<WantedTabList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.14.sh),
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
              child: ItemsWidget(
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.applyForJobScreenRoute);
                },
                imageWidth: 1.sw,
                imageHeight: AppDimensions.listItemHeight,
                boarderColor: AppColors.itemBGColor,
                title: AlphaAppData.wantedJobList[index].title,
                subTitle: AlphaAppData.wantedJobList[index].subTitle,
                imagePath: AlphaAppData.wantedJobList[index].imagePath,
                price: AlphaAppData.wantedJobList[index].price,
                userName: AlphaAppData.wantedJobList[index].userName,
                userRating: AlphaAppData.wantedJobList[index].userRating,
                userProfile: AlphaAppData.wantedJobList[index].userProfile,
              ),
            );
          },
        ),
      ),
    );
  }
}
