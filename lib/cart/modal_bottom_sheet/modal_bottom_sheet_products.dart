import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_delivery_address.dart';
import 'package:side_hustle/cart/products/products_cart_list.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ModalBottomSheetProducts extends StatefulWidget {
  final bool isDelivery;

  const ModalBottomSheetProducts({super.key, this.isDelivery = false});

  @override
  State<ModalBottomSheetProducts> createState() =>
      _ModalBottomSheetProductsState();
}

class _ModalBottomSheetProductsState extends State<ModalBottomSheetProducts> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        height: AppDimensions.modelSheetProductsHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight:
                    Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                topLeft:
                    Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
            image: const DecorationImage(
                image: AssetImage(AssetsPath.drawerBg), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                      text: AppStrings.yourCart,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeBottomSheet,
                      fontWeight: FontWeight.w500),
                  IconButton(
                    padding: EdgeInsets.zero,
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
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              child: textWidget(
                  text: AppStrings.yourCartItems,
                  color: AppColors.textWhiteColor,
                  fontSize: AppDimensions.textSizeSmall),
            ),
            height(0.02.sh),
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
                    widget.isDelivery
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWidget(
                                  text: AppStrings.deliveryAddress,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeBottomSheet,
                                  fontWeight: FontWeight.w500),
                              IconButtonWithBackground(
                                onTap: () {
                                  AppUtils.showBottomModalSheet(
                                      context: context,
                                      widget:
                                          const BottomModalSheetDeliveryAddress(
                                        isEdit: true,
                                      ));
                                },
                                iconPath: AssetsPath.edit,
                                backgroundColor: AppColors.primaryColor,
                                iconColor: AppColors.whiteColor,
                                height: 30.h,
                                width: 30.h,
                              )
                            ],
                          )
                        : const SizedBox.shrink(),
                    widget.isDelivery
                        ? height(0.02.sh)
                        : const SizedBox.shrink(),
                    widget.isDelivery
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImageIcon(
                                const AssetImage(AssetsPath.location),
                                size: 0.025.sh,
                              ),
                              width(0.02.sw),
                              Expanded(
                                child: textWidget(
                                    text: AppStrings.locationText,
                                    maxLines: 2,
                                    fontSize: AppDimensions.textSizeVerySmall),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    widget.isDelivery
                        ? height(0.02.sh)
                        : const SizedBox.shrink(),
                    widget.isDelivery
                        ? const Divider()
                        : const SizedBox.shrink(),
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
                    CustomMaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, AppRoutes.chatOneToOneScreenRoute,
                              arguments: const ChatOneToOne(
                                isOrderChat: true,
                              ));
                        },
                        name: AppStrings.placeOrder,
                        borderRadius: AppDimensions.boarderRadiusCartPlaceOrder,
                        color: AppColors.primaryColor),
                    height(0.02.sh),
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
