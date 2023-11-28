import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_delivery_address.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class DeliveryAddressYourCart extends StatelessWidget {
  final bool isDelivery, isOrderService;

  const DeliveryAddressYourCart(
      {super.key, this.isDelivery = false, this.isOrderService = false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          // width: 1.sw,
          // height: 0.62.sw,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppDimensions.bottomButtonBGCurve),
                topLeft: Radius.circular(AppDimensions.bottomButtonBGCurve)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isDelivery
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: AppStrings.deliveryAddress,
                              color: AppColors.textWhiteColor,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSizeCartText,
                              fontWeight: FontWeight.bold),
                          IconButtonWithBackground(
                            onTap: () {
                              AppUtils.showBottomModalSheet(
                                  context: context,
                                  widget: const BottomModalSheetDeliveryAddress(
                                    isEdit: true,
                                  ));
                            },
                            iconPath: AssetsPath.edit,
                            backgroundColor: AppColors.whiteColor,
                            iconColor: AppColors.primaryColor,
                            borderRadius: 8,
                            height: 25.h,
                            width: 25.h,
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
                isDelivery ? height(0.02.sw) : const SizedBox.shrink(),
                isDelivery
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageIcon(
                            const AssetImage(AssetsPath.location),
                            color: AppColors.whiteColor,
                            size: 0.037.sw,
                          ),
                          width(0.02.sw),
                          Expanded(
                            child: textWidget(
                                // text: AppStrings.locationText,
                                text: AppStrings.deliveryAddressHint,
                                maxLines: 2,
                                color: const Color(0xFFFCFCFC),
                                fontSize: AppDimensions.textSizeVerySmall),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                isDelivery ? height(0.01.sw) : const SizedBox.shrink(),
                isDelivery
                    ? const Divider(
                        color: AppColors.whiteColor,
                      )
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
                              color: AppColors.textWhiteColor,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSizeCartText,
                              fontWeight: FontWeight.bold),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0, top: 4),
                            child: textWidget(
                              text: AppStrings.estimatedTotalText,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFCFCFC),
                              maxLines: 2,
                              fontSize: AppDimensions.textSizeVerySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    textWidget(
                        // text: AppStrings.productPricingNumeric,
                        text: "\$98.24",
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textPriceSizeViewForms + 2.sp,
                        color: AppColors.textWhiteColor),
                  ],
                ),
                height(0.01.sw),
                CustomMaterialButton(
                    // height: 8,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.chatOneToOneScreenRoute,
                          arguments: ChatOneToOne(
                            isOrderChat: true,
                            isOrderService: isOrderService,
                          ));
                    },
                    name: AppStrings.placeOrder,
                    borderRadius: AppDimensions.boarderRadiusCartPlaceOrder,
                    color: AppColors.whiteColor,
                    fontSize: AppDimensions.textSizeNormal,
                    textColor: AppColors.primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
