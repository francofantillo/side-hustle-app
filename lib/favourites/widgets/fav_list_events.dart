import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/fav_item_events.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';

class FavouritesListEvent extends StatefulWidget {
  const FavouritesListEvent({super.key});

  @override
  State<FavouritesListEvent> createState() => _FavouritesListEventState();
}

class _FavouritesListEventState extends State<FavouritesListEvent> {
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
            child: FavItemEventsWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.favEventsList[index].title,
              location: AppStrings.locationText,
              imagePath: AlphaAppData.favEventsList[index].imagePath,
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
