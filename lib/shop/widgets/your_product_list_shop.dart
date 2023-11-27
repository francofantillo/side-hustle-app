import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/product/post_product.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/product/widgets/your_products_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';

class YourProductsListShop extends StatefulWidget {
  final bool isEdit;

  const YourProductsListShop({super.key, this.isEdit = false});

  @override
  State<YourProductsListShop> createState() => _YourProductsListShopState();
}

class _YourProductsListShopState extends State<YourProductsListShop> {
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
            // padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            padding: EdgeInsets.only(right: 16.0.w, left: 16.0.w, top: 8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.viewProductScreenRoute,
                    arguments: const ViewProduct(isMyProduct: true));
              },
              child: YourProductsItemWidget(
                imageWidth: 1.sw,
                isDelete: widget.isEdit,
                imageHeight: AppDimensions.sideHustleItemHeight,
                boarderColor: AppColors.itemBGColor,
                title: AlphaAppData.sideHustleProductsList[index].title,
                subTitle: AlphaAppData.sideHustleProductsList[index].subTitle,
                deliveryType: AppStrings.pickUpViewProduct,
                imagePath: AlphaAppData.sideHustleProductsList[index].imagePath,
                price: AlphaAppData.sideHustleProductsList[index].price,
                onTap: () {
                  if (widget.isEdit) {
                  } else {
                    Navigator.pushNamed(
                        context, AppRoutes.postProductScreenRoute,
                        arguments: const PostProduct(
                          isEdit: true,
                        ));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
