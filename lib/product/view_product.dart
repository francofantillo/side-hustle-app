import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_products.dart';
import 'package:side_hustle/cart/products/products_cart_list.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_image_with_background_color.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewPorduct extends StatefulWidget {
  const ViewPorduct({super.key});

  @override
  State<ViewPorduct> createState() => _ViewPorductState();
}

class _ViewPorductState extends State<ViewPorduct> {
  bool isAddToCart = false;

  @override
  void initState() {
    isAddToCart = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.applyForJob,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: Builder(builder: (contextBuilder) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.rootPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ImageSlider(),
                height(0.02.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                          text: AppStrings.watch,
                          fontWeight: FontWeight.w500,
                          fontSize: AppDimensions.textHeadingSizeHome,
                          color: AppColors.textBlackColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          textWidget(
                              text: AppStrings.eventPrice,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeNormal,
                              color: AppColors.textBlackColor),
                          textWidget(
                            text: AppStrings.perHead,
                            fontSize: AppDimensions.textSizePerHead,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                height(0.02.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: customMaterialButton(
                      onPressed: () {},
                      name: AppStrings.getDirectionToShop,
                      borderRadius: AppDimensions.boarderRadiusViewProduct,
                      color: AppColors.greenColor),
                ),
                height(0.03.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.productDescription,
                      maxLines: 2,
                      fontSize: AppDimensions.textSizeSmall,
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.productDescViewProduct,
                      maxLines: 30,
                      fontSize: AppDimensions.textSizeVerySmall),
                ),
                height(0.02.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.zipCode,
                      maxLines: 2,
                      fontSize: AppDimensions.textSizeSmall,
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                      width(0.02.sw),
                      Expanded(
                        child: textWidget(
                            text: AppStrings.zipCodeText,
                            maxLines: 1,
                            fontSize: AppDimensions.textSizeVerySmall),
                      ),
                    ],
                  ),
                ),
                height(0.02.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.deliveryOptions,
                      maxLines: 2,
                      fontSize: AppDimensions.textSizeSmall,
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                      width(0.02.sw),
                      Expanded(
                        child: textWidget(
                            text: AppStrings.pickUpViewProduct,
                            maxLines: 1,
                            fontSize: AppDimensions.textSizeVerySmall),
                      ),
                    ],
                  ),
                ),
                height(0.02.sh),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                height(0.02.sh),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.productPostBy,
                      maxLines: 2,
                      fontSize: AppDimensions.textSizeSmall,
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircularCacheImageWidget(
                              showLoading: false,
                              image: AssetsPath.userProfileJob,
                              boarderColor: AppColors.primaryColor,
                              imageHeight: .09.sh,
                              imageWidth: .09.sw,
                            ),
                            width(.02.sw),
                            Expanded(
                              child: textWidget(
                                  text: AppStrings.userNameViewProduct,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlackColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45.h,
                        child: CustomButtonWithIcon(
                          onPressed: () {
                            print("pressed Elevated Button");
                          },
                          borderRadius: 10,
                          backgroundColor: AppColors.greenColor,
                          iconPath: AssetsPath.sideHustle,
                          name: AppStrings.viewShop,
                        ),
                      ),
                      RoundedImageWithBackgroundColor(
                        assetPath: AssetsPath.message,
                        imageHeight: .03.sh,
                        imageWidth: .06.sw,
                        backgroundColor: AppColors.primaryColor,
                        socialButtonSize: .03.sh,
                        borderRadius: 12,
                      ),
                    ],
                  ),
                ),
                isAddToCart ? const SizedBox.shrink() : height(0.02.sh),
                isAddToCart
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: customMaterialButton(
                            onPressed: () {
                              isAddToCart = true;
                              setState(() {});
                            },
                            name: AppStrings.addToCart,
                            borderRadius:
                                AppDimensions.boarderRadiusViewProduct),
                      ),
                height(0.02.sh),
                isAddToCart
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          children: [
                            RoundedImageWithBackgroundColor(
                              assetPath: AssetsPath.minus,
                              iconColor: AppColors.greyColor,
                              imageHeight: .03.sh,
                              imageWidth: .06.sw,
                              backgroundColor:
                                  AppColors.backIconBackgroundColor,
                              socialButtonSize: .03.sh,
                              borderRadius: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: textWidget(
                                  text: "1",
                                  fontSize: AppDimensions.textSizeCartText,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlackColor),
                            ),
                            RoundedImageWithBackgroundColor(
                              assetPath: AssetsPath.add,
                              iconColor: AppColors.greyColor,
                              imageHeight: .03.sh,
                              imageWidth: .06.sw,
                              backgroundColor:
                                  AppColors.backIconBackgroundColor,
                              socialButtonSize: .03.sh,
                              borderRadius: 12,
                            ),
                            width(0.03.sw),
                            Expanded(
                                child: customMaterialButton(
                                    onPressed: () {
                                      AppUtils.showBottomModelSheet(
                                          context: contextBuilder,
                                          widget:
                                              const ModelBottomSheetProducts());
                                    },
                                    name: AppStrings.viewCartText,
                                    borderRadius:
                                        AppDimensions.boarderRadiusViewProduct))
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
