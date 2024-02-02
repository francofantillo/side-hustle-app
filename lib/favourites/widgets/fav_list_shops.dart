import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/fav_item_shops.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class FavouritesListShops extends StatefulWidget {
  const FavouritesListShops({super.key});

  @override
  State<FavouritesListShops> createState() => _FavouritesListShopsState();
}

class _FavouritesListShopsState extends State<FavouritesListShops> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
      return state.favouritesModelLoading
          ? const SizedBox.shrink()
          // : state.favouritesModel?.favourites?.isEmpty ?? true
          : true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageNoItemsFound),
                )
              : Expanded(
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
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, top: 8.0),
                        child: FavItemShopsWidget(
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.listItemFavShopsHeight,
                          boarderColor: AppColors.itemBGColor,
                          title: AlphaAppData.favShopsList[index].title,
                          products: "24 Products",
                          services: "5 Services",
                          imagePath: AlphaAppData.favShopsList[index].imagePath,
                          price: AlphaAppData.favShopsList[index].price,
                          userName: AlphaAppData.favShopsList[index].userName,
                          userRating:
                              AlphaAppData.favShopsList[index].userRating,
                          userProfile:
                              AlphaAppData.favShopsList[index].userProfile,
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
