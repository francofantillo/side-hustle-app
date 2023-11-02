import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/fav_item_shops.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class FavouritesListShops extends StatefulWidget {
  const FavouritesListShops({super.key});

  @override
  State<FavouritesListShops> createState() => _FavouritesListShopsState();
}

class _FavouritesListShopsState extends State<FavouritesListShops> {
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
            padding: const EdgeInsets.only(right: 16.0, left: 8.0, top: 8.0),
            child: FavItemShopsWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.listItemFavouritesShopHeight,
              boarderColor: AppColors.itemBGColor,
              title: "Gustavo Rosser’s Shop",
              products: "24 Products",
              services: "5 Services",
              imagePath:
              AlphaAppData.jobsAndEventsList[0].itemList?[0].imagePath,
              price: AlphaAppData.jobsAndEventsList[0].itemList?[0].price,
              userName: AlphaAppData.jobsAndEventsList[0].itemList?[0].userName,
              userRating:
              AlphaAppData.jobsAndEventsList[0].itemList?[0].userRating,
              userProfile:
              AlphaAppData.jobsAndEventsList[0].itemList?[0].userProfile,
            ),
          );
        },
      ),
    );
  }
}
