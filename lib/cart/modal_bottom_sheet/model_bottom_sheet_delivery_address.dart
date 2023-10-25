import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_products.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class BottomModelSheetDeliveryAddress extends StatefulWidget {
  final bool isEdit, isService;

  const BottomModelSheetDeliveryAddress(
      {super.key, this.isEdit = false, this.isService = false});

  @override
  State<BottomModelSheetDeliveryAddress> createState() =>
      _BottomModelSheetDeliveryAddressState();
}

class _BottomModelSheetDeliveryAddressState
    extends State<BottomModelSheetDeliveryAddress> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Wrap(
        children: [
          Container(
            // height: widget.isEdit
            //     ? AppDimensions.modelSheetProductsHeight
            //     : AppDimensions.modelSheetDeliveryHeight,
            width: 1.sw,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                  topLeft:
                      Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
              // image: const DecorationImage(
              //     image: AssetImage(
              //         AssetsPath.drawerBg),
              //     fit: BoxFit.cover)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                  child: textWidget(
                      text: AppStrings.deliveryAddress,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeBottomSheet,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                  child: textWidget(
                      text: widget.isService
                          ? AppStrings.deliveryAddressServiceHint
                          : AppStrings.deliveryAddressHint,
                      maxLines: 2,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeSmall),
                ),
                height(0.02.sh),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                  child: CustomTextFormField(
                    height: 40.h,
                    hintText: AppStrings.enterCompleteAddress,
                  ),
                ),
                height(0.01.sh),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 4.0),
                        child: CustomTextFormField(
                          height: 40.h,
                          hintText: AppStrings.street,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 12.0),
                        child: CustomTextFormField(
                          height: 40.h,
                          hintText: AppStrings.suitApartment,
                        ),
                      ),
                    ),
                  ],
                ),
                height(0.02.sh),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: customMaterialButton(
                      height: 10.h,
                      onPressed: () {
                        if (widget.isEdit) {
                          Navigator.pop(context);
                        } else {
                          if (widget.isService) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            AppUtils.showBottomModelSheet(
                                context: context,
                                widget: const ModelBottomSheetProducts(
                                  isDelivery: true,
                                ));
                          }
                        }
                      },
                      borderRadius: 16,
                      name: widget.isEdit
                          ? AppStrings.done
                          : widget.isService
                              ? AppStrings.confirm
                              : AppStrings.addToCart,
                      color: AppColors.whiteColor,
                      textColor: AppColors.primaryColor),
                ),
                height(0.03.sh),
                Center(
                  child: CircularIconButton(
                      icon: Icons.close,
                      iconSize: .09.sw,
                      iconColor: AppColors.primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: AppColors.whiteColor),
                ),
                height(0.02.sw),
                Center(
                  child: textWidget(
                      text: AppStrings.cancel,
                      maxLines: 2,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeSmall),
                ),
                height(0.1.sw),
              ],
            ),
          ),
        ],
      );
    });
  }
}
