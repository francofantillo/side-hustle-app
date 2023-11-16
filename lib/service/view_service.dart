import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_service.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/post_service.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
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
                const ImageSlider(
                  hideCameraIcon: true,
                  itemImages: [
                    AssetsPath.plumber,
                    AssetsPath.plumber,
                    AssetsPath.plumber
                  ],
                ),
                height(0.02.sh),
                // AspectRatio(
                //   aspectRatio: 21/9,
                //   child: Container(
                //     // width: imageWidth ?? 0.18.sw, // Set your desired width
                //     // height: imageHeight ?? 0.18.sw, // Set your desired height
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(
                //             Radius.circular(AppDimensions.homeFirstItemWidgetCurve)),
                //         image: DecorationImage(
                //             image: AssetImage(AssetsPath.plumber),
                //             // image: AssetImage(AssetsPath.carpenter),
                //             fit: BoxFit.cover)),
                //   ),
                // ),
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
                                fontSize: AppDimensions.textSizeSmall,
                                color: AppColors.textBlackColor,
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
                                        imageHeight: .09.sh,
                                        imageWidth: .09.sw,
                                      ),
                                      width(.02.sw),
                                      Expanded(
                                        child: textWidget(
                                            text:
                                                AppStrings.userNameViewProduct,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textBlackColor),
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
                height(0.03.sh),
                isAddToCart ? const SizedBox.shrink() : height(0.02.sh),
                isAddToCart
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: customMaterialButton(
                            height: 12.h,
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
                                : AppStrings.requestService,
                            borderRadius:
                                AppDimensions.boarderRadiusViewProduct),
                      ),
                height(0.02.sh),
                isAddToCart
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 48.h,
                                // width: imageWidth!,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 1.7),
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.boarderRadiusViewProduct),
                                ),
                                child: Center(
                                  child: textWidget(
                                    text: AppStrings.serviceAdded,
                                    color: AppColors.primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )),
                            width(0.03.sw),
                            Expanded(
                                child: customMaterialButton(
                                    onPressed: () {
                                      AppUtils.showBottomModalSheet(
                                          context: context,
                                          widget:
                                              // const ModelBottomSheetProducts()
                                              const ModalBottomSheetServices());
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
