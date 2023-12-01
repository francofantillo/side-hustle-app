import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/fav_item_jobs.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class FavouritesListJobs extends StatefulWidget {
  const FavouritesListJobs({super.key});

  @override
  State<FavouritesListJobs> createState() => _FavouritesListJobsState();
}

class _FavouritesListJobsState extends State<FavouritesListJobs> {
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
            child: FavItemJobsWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemFavJobHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.favJobsList[index].title,
              subTitle: AlphaAppData.favJobsList[index].subTitle,
              imagePath: AlphaAppData.favJobsList[index].imagePath,
              price: AlphaAppData.favJobsList[index].price,
              userName: AlphaAppData.favJobsList[index].userName,
              userRating: AlphaAppData.favJobsList[index].userRating,
              userProfile: AlphaAppData.favJobsList[index].userProfile,
            ),
          );
        },
      ),
    );
  }
}
