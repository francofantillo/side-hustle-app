import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/post_service.dart';
import 'package:side_hustle/shop/shop.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

import '../cart/modal_bottom_sheet/modal_bottom_sheet_request_service.dart';

class ViewService extends StatefulWidget {
  final bool isMyService, isViewingServiceFromOthersShop, isEditFromShop;
  final int? id;

  const ViewService(
      {super.key,
      this.id,
      this.isMyService = false,
      this.isEditFromShop = false,
      this.isViewingServiceFromOthersShop = false});

  @override
  State<ViewService> createState() => _ViewServiceState();
}

class _ViewServiceState extends State<ViewService> {
  late final SideHustleCubit _bloc;

  bool isAddToCart = false;
  int index = 0;

  @override
  void initState() {
    isAddToCart = false;
    _bloc = BlocProvider.of(context);
    print("isEditFromShop: ${widget.isEditFromShop}");
    isProductExistInCart();
    getSideHustleDetail();
    super.initState();
  }

  getSideHustleDetail() async {
    await _bloc.getSideHustleDetailCubit(
        context: context, mounted: mounted, id: widget.id);
  }

  isProductExistInCart() async {
    await _bloc.isProductExist(productId: widget.id).then((value) {
      if (value != -1) {
        isAddToCart = true;
        index = value;
      }
    });
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
      body: BlocBuilder<SideHustleCubit, SideHustleState>(
          builder: (contextBuilder, state) {
        print("serviceType: ${state.sideHustleDetailModel?.data?.serviceType}");
        return state.sideHustleDetailLoading
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.rootPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.sideHustleDetailModel?.data?.images?.isEmpty ?? true
                          ? const NoImagesFoundWidget()
                          : ImageSlider(
                              hideCameraIcon: true,
                              indicatorLength: (state.sideHustleDetailModel
                                          ?.data?.images?.isEmpty ??
                                      true)
                                  ? null
                                  : state.sideHustleDetailModel?.data?.images
                                      ?.length,
                              responseImages:
                                  state.sideHustleDetailModel?.data?.images),
                      height(0.02.sw),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: textWidget(
                                  text: state.sideHustleDetailModel?.data?.name,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      AppDimensions.textHeadingSizeViewForms,
                                  color: AppColors.textBlackColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                textWidget(
                                    text: state.sideHustleDetailModel?.data
                                                ?.price !=
                                            null
                                        ? "\$${state.sideHustleDetailModel?.data?.price?.toStringAsFixed(2)}"
                                        : null,
                                    fontFamily: AppFont.gilroyBold,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppDimensions.textPriceSizeViewForms,
                                    color: AppColors.textBlackColor),
                                textWidget(
                                    // text: AppStrings.perHour,
                                    text: state.sideHustleDetailModel?.data
                                                ?.serviceType ==
                                            ServiceTypeEnum.Hourly.name
                                        ? AppStrings.perHour
                                        : AppStrings.fixed,
                                    fontSize: AppDimensions.textSize10,
                                    color: AppColors.textBlackColor),
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
                            text:
                                state.sideHustleDetailModel?.data?.description,
                            maxLines: 30,
                            color: AppColors.textBlackColor,
                            fontSize:
                                AppDimensions.textSubHeadingTextSizeViewForms),
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
                            text: state.sideHustleDetailModel?.data
                                ?.additionalInformation,
                            maxLines: 30,
                            color: AppColors.textBlackColor,
                            fontSize:
                                AppDimensions.textSubHeadingTextSizeViewForms),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: textWidget(
                                      text: AppStrings.servicePostBy,
                                      maxLines: 2,
                                      fontFamily: AppFont.gilroyBold,
                                      color: AppColors.textBlackColor,
                                      fontSize: AppDimensions
                                          .textSubHeadingSizeViewForms,
                                      fontWeight: FontWeight.bold),
                                ),
                      widget.isMyService
                          ? const SizedBox.shrink()
                          : widget.isViewingServiceFromOthersShop
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            CircularCacheImageWidget(
                                              showLoading: false,
                                              image: state.sideHustleDetailModel
                                                  ?.data?.productOwner?.image,
                                              assetImage:
                                                  AssetsPath.placeHolder,
                                              boarderColor:
                                                  AppColors.primaryColor,
                                              imageHeight: .1.sw,
                                              imageWidth: .1.sw,
                                            ),
                                            width(.02.sw),
                                            Expanded(
                                              child: textWidget(
                                                  text: state
                                                      .sideHustleDetailModel
                                                      ?.data
                                                      ?.productOwner
                                                      ?.name,
                                                  fontSize: 12.sp,
                                                  fontFamily:
                                                      AppFont.gilroyBold,
                                                  color:
                                                      AppColors.textBlackColor,
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
                                            Navigator.pushNamed(context,
                                                AppRoutes.shopScreenRoute,
                                                arguments: ShopScreen(
                                                  shopId: state
                                                      .sideHustleDetailModel
                                                      ?.data
                                                      ?.shopId,
                                                ));
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
                                                userName: AppStrings
                                                    .userNameViewProduct,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: CustomMaterialButton(
                                  onPressed: () {
                                    if (widget.isMyService) {
                                      // Navigator.pushNamed(context,
                                      //     AppRoutes.postServiceScreenRoute,
                                      //     arguments: const PostService(
                                      //       isEdit: true,
                                      //     ));
                                      if (widget.isEditFromShop) {
                                        Navigator.pushReplacementNamed(context,
                                            AppRoutes.postServiceScreenRoute,
                                            arguments: PostService(
                                              isEdit: true,
                                              id: widget.id,
                                              isEditFromShop: true,
                                            ));
                                      } else {
                                        Navigator.pushNamed(context,
                                            AppRoutes.postServiceScreenRoute,
                                            arguments: PostService(
                                              isEdit: true,
                                              id: widget.id,
                                              isEditFromShop: false,
                                            ));
                                      }
                                    } else {
                                      _bloc
                                          .checkIsOtherShop(
                                              shopId: state
                                                  .sideHustleDetailModel
                                                  ?.data
                                                  ?.shopId)
                                          .then((value) async {
                                        if (value == 1) {
                                          /// Show Cart Clear Dialog
                                          AppDialogues.showCartClearInfo(
                                              context: context,
                                              onPressedOk: () async {
                                                /// Clear Cart
                                                AppUtils.showBottomModalSheet(
                                                    context: context,
                                                    widget:
                                                        BottomModalSheetRequestService(
                                                      onItemAdded: onItemAdded,
                                                      productId: state
                                                          .sideHustleDetailModel
                                                          ?.data
                                                          ?.productId,
                                                      shopId: state
                                                          .sideHustleDetailModel
                                                          ?.data
                                                          ?.shopId,
                                                    ));
                                              }).show();
                                        } else {
                                          /// Request Service
                                          AppUtils.showBottomModalSheet(
                                              context: context,
                                              widget:
                                                  BottomModalSheetRequestService(
                                                onItemAdded: onItemAdded,
                                                productId: state
                                                    .sideHustleDetailModel
                                                    ?.data
                                                    ?.productId,
                                                shopId: state
                                                    .sideHustleDetailModel
                                                    ?.data
                                                    ?.shopId,
                                              ));
                                        }
                                      });
                                    }
                                  },
                                  name: widget.isMyService
                                      ? AppStrings.editService
                                      : AppStrings.requestService),
                            ),
                      height(0.02.sw),
                      isAddToCart
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      // height: 48.h,
                                      // width: imageWidth!,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: AppDimensions
                                                  .buttonDefaultHeight -
                                              2),
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
                                          fontSize:
                                              AppDimensions.textSizeNormal,
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
                                            // Navigator.pushNamed(
                                            //     context,
                                            //     AppRoutes
                                            //         .yourServiceCartScreenRoute);
                                            Navigator.pushNamed(
                                                context,
                                                AppRoutes
                                                    .yourProductsCartScreenRoute);
                                          },
                                          // name: AppStrings.viewCartText,
                                          name:
                                              "View Cart (${state.cartModel?.data?.totalItems})",
                                          borderRadius: AppDimensions
                                              .boarderRadiusViewProduct))
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
