import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/services/service_cart_item.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';

class ServicesCartList extends StatefulWidget {
  const ServicesCartList({super.key});

  @override
  State<ServicesCartList> createState() => _ServicesCartListState();
}

class _ServicesCartListState extends State<ServicesCartList> {
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
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 8),
            child: ServiceCartItemWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.cartItemServiceHeight,
              boarderColor: AppColors.itemBGColor,
              title: AppStrings.plumber,
              subTitle: AlphaAppData.jobsAndEventsList[0].itemList?[0].subTitle,
              imagePath: AssetsPath.plumber,
              price: "\$12.56",
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
