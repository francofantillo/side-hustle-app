import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/products/products_cart_list.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ModelBottomSheetProducts extends StatefulWidget {
  const ModelBottomSheetProducts({super.key});

  @override
  State<ModelBottomSheetProducts> createState() =>
      _ModelBottomSheetProductsState();
}

class _ModelBottomSheetProductsState extends State<ModelBottomSheetProducts> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        height: .7.sh,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppDimensions.boarderRadiusBottomSheet),
            image: const DecorationImage(
                image: AssetImage(AssetsPath.drawerBg), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                      text: AppStrings.yourCart,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeBottomSheet,
                      fontWeight: FontWeight.w500),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(CustomIcon.cancel),
                    iconSize: 36,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: textWidget(
                  text: AppStrings.yourCartItems,
                  color: AppColors.textWhiteColor,
                  fontSize: AppDimensions.textSizeSmall),
            ),
            const ProductsCartList(),
            Container(
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                    topRight:
                        Radius.circular(AppDimensions.bottomButtonBGCurve),
                    topLeft:
                        Radius.circular(AppDimensions.bottomButtonBGCurve)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidget(
                                  text: AppStrings.estimatedTotal,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeCartText,
                                  fontWeight: FontWeight.w500),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: textWidget(
                                  text: AppStrings.estimatedTotalText,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 2,
                                  fontSize: AppDimensions.textSizeVerySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        textWidget(
                            text: AppStrings.productPricingNumeric,
                            fontWeight: FontWeight.w500,
                            fontSize: AppDimensions.textSizeCartText,
                            color: AppColors.textBlackColor),
                      ],
                    ),
                    height(0.02.sh),
                    customMaterialButton(
                        onPressed: () {},
                        name: AppStrings.placeOrder,
                        borderRadius: AppDimensions.boarderRadiusCartPlaceOrder,
                        color: AppColors.primaryColor)
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
