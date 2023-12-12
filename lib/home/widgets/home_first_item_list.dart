import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/home/widgets/home_first_item_widget.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class FirstHomeListItemWidget extends StatelessWidget {
  final String? title;
  final List<HomeFirstList>? itemsList;
  final double horizontalListSize;
  final Function()? onTapLabel;

  const FirstHomeListItemWidget(
      {super.key,
      this.title,
      this.itemsList,
      this.onTapLabel,
      required this.horizontalListSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: InkWell(
            onTap: onTapLabel,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(
                    text: title ?? AppStrings.blessTheseBusinesses,
                    fontSize: AppDimensions.textSizeNormal,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFont.gilroyBold,
                    color: AppColors.textBlackColor),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppDimensions.itemsArrowForwardIconSize,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: horizontalListSize, // Set the desired height
          width: 1.sw,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            shrinkWrap: true,
            itemCount: itemsList?.length ?? 0, // Replace with your item count
            itemBuilder: (context, index) {
              // Replace with your horizontal list item
              return Material(
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.shopScreenRoute);
                  },
                  child: Padding(
                    // padding: const EdgeInsets.only(right: 2.0, left: 8.0, top: 8),
                    padding: const EdgeInsets.only(top: 8, left: 6),
                    child: HomeFirstItemWidget(
                      title: itemsList?[index].name,
                      assetImage: itemsList?[index].imagePath,
                      boarderColor: AppColors.homeFirstItemOutlineColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
