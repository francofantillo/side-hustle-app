import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/widgets/service_item.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';

class ServicesList extends StatefulWidget {
  const ServicesList({super.key});

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
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
            // padding: EdgeInsets.only(right: 16.0, left: 8.0, top: 0.015.sh),
            padding: const EdgeInsets.only(right: 16.0, left: 8.0, top: 8),
            child: ServiceItemsWidget(
              imageWidth: 1.sw,
              imageHeight: AppDimensions.sideHustleItemHeight,
              boarderColor: AppColors.itemBGColor,
              title: AlphaAppData.sideHustleServicesList[index].title,
              subTitle: AlphaAppData.sideHustleServicesList[index].subTitle,
              deliveryType: AppStrings.pickUpViewProduct,
              imagePath:
              AlphaAppData.sideHustleServicesList[index].imagePath,
              price: AlphaAppData.sideHustleServicesList[index].price,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.viewServiceScreenRoute);
              },
            ),
          );
        },
      ),
    );
  }
}
