import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/home/widgets/home_items_widget.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class JobsHorizontalListWidget extends StatelessWidget {
  final String? title;
  final List<ItemList>? itemsList;
  final double horizontalListSize;
  final Function()? onTapLabel;
  final bool isEvent;

  const JobsHorizontalListWidget(
      {super.key,
      this.title,
      this.itemsList,
      this.onTapLabel,
      this.isEvent = false,
      required this.horizontalListSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 8.0, top: 4, right: 8, bottom: 8),
          child: InkWell(
            onTap: onTapLabel,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(
                    text: title ?? AppStrings.blessTheseBusinesses,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textSizeNormal,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlackColor),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppDimensions.itemsArrowForwardIconSize,
                )
              ],
            ),
          ),
        ),
        // Horizontal ListView
        SizedBox(
          height: horizontalListSize, // Set the desired height
          width: 1.sw,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: itemsList?.length ?? 0, // Replace with your item count
            itemBuilder: (context, index) {
              // Replace with your horizontal list item
              return Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: HomeItemsWidget(
                  onTap: () {
                    if (isEvent) {
                      Navigator.pushNamed(
                          context, AppRoutes.viewEventScreenRoute);
                    } else {
                      Navigator.pushNamed(
                          context, AppRoutes.applyForJobScreenRoute);
                    }
                  },
                  commentIconPath: AssetsPath.comment,
                  imageWidth: 1.sw,
                  imageHeight: horizontalListSize,
                  boarderColor: AppColors.itemBGColor,
                  title: itemsList?[index].title,
                  desc: itemsList?[index].subTitle,
                  imagePath: itemsList?[index].imagePath,
                  price: itemsList?[index].price,
                  userName: itemsList?[index].userName,
                  userRating: itemsList?[index].userRating,
                  userProfile: itemsList?[index].userProfile,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
