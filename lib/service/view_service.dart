import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/post_service.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_alpha.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

import '../cart/modal_bottom_sheet/modal_bottom_sheet_request_service.dart';

class ViewService extends StatefulWidget {
  final bool isMyService, isViewingServiceFromOthersShop;

  const ViewService(
      {super.key,
      this.isMyService = false,
      this.isViewingServiceFromOthersShop = false});

  @override
  State<ViewService> createState() => _ViewServiceState();
}

class _ViewServiceState extends State<ViewService> {
  bool isAddToCart = false;

  @override
  void initState() {
    isAddToCart = false;
    super.initState();
  }

  void onItemAdded(bool onItemAdded) {
    isAddToCart = onItemAdded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.viewService,
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
                const ImageSliderAlpha(
                  hideCameraIcon: true,
                  itemImages: [
                    AssetsPath.plumber,
                    AssetsPath.plumber,
                    AssetsPath.plumber
                  ],
                ),
                height(0.02.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                          text: AppStrings.plumber,
                          fontFamily: AppFont.gilroyBold,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.textHeadingSizeViewForms,
                          color: AppColors.textBlackColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          textWidget(
                              text: AppStrings.eventPrice,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textPriceSizeViewForms,
                              color: AppColors.textBlackColor),
                          textWidget(
                            text: AppStrings.perHead,
                            fontSize: AppDimensions.textSize10,
                            color: AppColors.textBlackColor
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                height(0.02.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.serviceDescription,
                      maxLines: 2,
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.textSubHeadingSizeViewForms,
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.productDescViewProduct,
                      maxLines: 30,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSubHeadingTextSizeViewForms),
                ),
                height(0.02.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.additionalInformation,
                      maxLines: 2,
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.textSubHeadingSizeViewForms,
                      color: AppColors.textBlackColor,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.productDescViewProduct,
                      maxLines: 30,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSubHeadingTextSizeViewForms),
                ),
                height(0.03.sw),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 1,
                    color: AppColors.greyColor.withOpacity(0.8),
                  ),
                ),
                height(0.04.sw),
                widget.isMyService
                    ? const SizedBox.shrink()
                    : widget.isViewingServiceFromOthersShop
                        ? const SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: AppStrings.servicePostBy,
                                maxLines: 2,
                                fontFamily: AppFont.gilroyBold,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions.textSubHeadingSizeViewForms,
                                fontWeight: FontWeight.bold),
                          ),
                widget.isMyService
                    ? const SizedBox.shrink()
                    : widget.isViewingServiceFromOthersShop
                        ? const SizedBox.shrink()
                        : Padding(
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
                                        image: AssetsPath.phillipPressProfile,
                                        boarderColor: AppColors.primaryColor,
                                        imageHeight: .1.sw,
                                        imageWidth: .1.sw,
                                      ),
                                      width(.02.sw),
                                      Expanded(
                                        child: textWidget(
                                            text:
                                                AppStrings.userNameViewProduct,
                                            fontSize: 12.sp,
                                            fontFamily: AppFont.gilroyBold,
                                            color: AppColors.textBlackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                  child: CustomButtonWithIcon(
                                    onPressed: () {
                                      print("pressed Elevated Button");
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.shopScreenRoute);
                                    },
                                    borderRadius: 10,
                                    backgroundColor: AppColors.greenColor,
                                    iconPath: AssetsPath.sideHustle,
                                    name: AppStrings.viewShop,
                                  ),
                                ),
                                width(0.01.sw),
                                IconButtonWithBackground(
                                  height: 50.h,
                                  width: .17.sw,
                                  borderRadius: 10,
                                  onTap: () {
                                    print("clicked message");
                                    Navigator.pushNamed(context,
                                        AppRoutes.chatOneToOneScreenRoute,
                                        arguments: const ChatOneToOne(
                                          userName:
                                              AppStrings.userNameViewProduct,
                                        ));
                                  },
                                  iconPath: AssetsPath.message,
                                  backgroundColor: AppColors.primaryColor,
                                  iconColor: AppColors.whiteColor,
                                ),
                              ],
                            ),
                          ),
                height(0.05.sw),
                isAddToCart ? const SizedBox.shrink() : height(0.02.sw),
                isAddToCart
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: CustomMaterialButton(
                            // height: 12.h,
                            onPressed: () {
                              // isAddToCart = true;
                              // setState(() {});
                              if (widget.isMyService) {
                                Navigator.pushNamed(
                                    context, AppRoutes.postServiceScreenRoute,
                                    arguments: const PostService(
                                      isEdit: true,
                                    ));
                              } else {
                                AppUtils.showBottomModalSheet(
                                    context: context,
                                    // widget: const ModalBottomSheetProducts(isDelivery: true,));
                                    widget: BottomModalSheetRequestService(
                                      onItemAdded: onItemAdded,
                                    ));
                                // widget: const ModalBottomSheetServices(
                                //   isDelivery: true,
                                // ));
                              }
                            },
                            name: widget.isMyService
                                ? AppStrings.editService
                                : AppStrings.requestService),
                      ),
                height(0.02.sw),
                isAddToCart
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {},
                              child: Container(
                                // height: 48.h,
                                // width: imageWidth!,
                                padding: EdgeInsets.symmetric(vertical: AppDimensions.buttonDefaultHeight - 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: textWidget(
                                    text: AppStrings.serviceAdded,
                                    color: AppColors.primaryColor,
                                    fontFamily: AppFont.gilroySemiBold,
                                    fontSize: AppDimensions.textSizeNormal,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                            width(0.03.sw),
                            Expanded(
                                child: CustomMaterialButton(
                                    onPressed: () {
                                      // AppUtils.showBottomModalSheet(
                                      //     context: context,
                                      //     widget:
                                      //         // const ModelBottomSheetProducts()
                                      //         const ModalBottomSheetServices());
                                      Navigator.pushNamed(context, AppRoutes.yourServiceCartScreenRoute);
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
