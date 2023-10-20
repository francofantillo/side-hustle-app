import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/home/widgets/items_widget.dart';
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
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
          itemCount: 4,
          // Replace with your item count
          itemBuilder: (context, index) {
            // Replace with your horizontal list item
            return Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 8.0),
              child: ItemsWidget(
                imageWidth: 1.sw,
                imageHeight: AppDimensions.listItemHeight,
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
      ),
    );
  }
}
