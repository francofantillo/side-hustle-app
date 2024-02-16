import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/view_service.dart';
import 'package:side_hustle/service/widgets/service_item.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';

class OtherUserServicesListShop extends StatefulWidget {

  const OtherUserServicesListShop({super.key});

  @override
  State<OtherUserServicesListShop> createState() => _OtherUserServicesListShopState();
}

class _OtherUserServicesListShopState extends State<OtherUserServicesListShop> {
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
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.viewServiceScreenRoute,
                    arguments: const ViewService(
                      isMyService: true,
                    ));
              },
              child: ServiceItemsWidget(
                imageWidth: 1.sw,
                imageHeight: AppDimensions.sideHustleItemHeight,
                boarderColor: AppColors.itemBGColor,
                title: AlphaAppData.jobsAndEventsList[0].itemList?[0].title,
                subTitle:
                AlphaAppData.jobsAndEventsList[0].itemList?[0].subTitle,
                serviceType: AppStrings.pickUpViewProduct,
                imagePath:
                AlphaAppData.jobsAndEventsList[0].itemList?[0].imagePath,
                price: AlphaAppData.jobsAndEventsList[0].itemList?[0].price,
                onTap: () {
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
