import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/product/post_product.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/shop/shop.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_alpha.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewProduct extends StatefulWidget {
  final bool isMyProduct,
      isViewingProductFromOthersShop,
      isEditFromShop,
      viewCart;
  final int? id;

  const ViewProduct(
      {super.key,
      this.id,
      this.isMyProduct = false,
      this.isEditFromShop = false,
      this.viewCart = false,
      this.isViewingProductFromOthersShop = false});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  late final SideHustleCubit _bloc;
  bool isAddToCart = false;
  int index = 0;

  @override
  void initState() {
    isAddToCart = false;
    _bloc = BlocProvider.of(context);
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

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.viewProduct,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<SideHustleCubit, SideHustleState>(
          builder: (contextBuilder, state) {
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
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: textWidget(
                                    text:
                                        state.sideHustleDetailModel?.data?.name,
                                    fontFamily: AppFont.gilroyBold,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppDimensions.textHeadingSizeViewForms,
                                    color: AppColors.textBlackColor),
                              ),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppDimensions.textPriceSizeViewForms,
                                    color: AppColors.textBlackColor),
                                // textWidget(
                                //   text: AppStrings.perHead,
                                //   color: AppColors.textBlackColor,
                                //   fontSize: AppDimensions.textSize10,
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      height(0.03.sw),
                      widget.isMyProduct
                          ? const SizedBox.shrink()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: CustomMaterialButton(
                                  // height: 6,
                                  borderRadius: 12,
                                  fontSize:
                                      AppDimensions.boarderRadiusViewProduct,
                                  color: AppColors.greenColor,
                                  textColor: AppColors.whiteColor,
                                  onPressed: () {},
                                  name: AppStrings.getDirectionToShop),
                            ),
                      height(0.03.sw),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: textWidget(
                            text: AppStrings.productDescription,
                            maxLines: 2,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.textSubHeadingSizeViewForms,
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      height(0.02.sw),
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
                      height(0.03.sw),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: textWidget(
                            text: AppStrings.zipCode,
                            maxLines: 2,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.textSubHeadingSizeViewForms,
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      height(0.02.sw),
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
                                  text: state
                                      .sideHustleDetailModel?.data?.zipCode,
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions
                                      .textSubHeadingTextSizeViewForms),
                            ),
                          ],
                        ),
                      ),
                      height(0.03.sw),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: textWidget(
                            text: AppStrings.deliveryOptions,
                            maxLines: 2,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.textSubHeadingSizeViewForms,
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      height(0.02.sw),
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
                                  text: state.sideHustleDetailModel?.data
                                              ?.deliveryType !=
                                          null
                                      ? state.sideHustleDetailModel!.data!
                                                  .deliveryType ==
                                              DeliveryTypeEnum.Pickup.name
                                          ? AppStrings.pickUpViewProduct
                                          : AppStrings.deliveryOptionCOD
                                      : null,
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions
                                      .textSubHeadingTextSizeViewForms),
                            ),
                          ],
                        ),
                      ),
                      height(0.02.sw),
                      // const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      height(0.02.sh),
                      widget.isMyProduct
                          ? const SizedBox.shrink()
                          : widget.isViewingProductFromOthersShop
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: textWidget(
                                      text: AppStrings.productPostBy,
                                      maxLines: 2,
                                      fontFamily: AppFont.gilroyBold,
                                      fontSize: AppDimensions
                                          .textSubHeadingSizeViewForms,
                                      color: AppColors.textBlackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                      widget.isMyProduct
                          ? const SizedBox.shrink()
                          : widget.isViewingProductFromOthersShop
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
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.textBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                        child: CustomButtonWithIcon(
                                          onPressed: () {
                                            print("pressed Elevated Button");
                                            Navigator.pushNamed(
                                                context,
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
                      isAddToCart ? const SizedBox.shrink() : height(0.02.sh),
                      isAddToCart
                          ? const SizedBox.shrink()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: CustomMaterialButton(
                                onPressed: () {
                                  if (widget.isMyProduct) {
                                    if (widget.isEditFromShop) {
                                      Navigator.pushReplacementNamed(context,
                                          AppRoutes.postProductScreenRoute,
                                          arguments: PostProduct(
                                            isEdit: true,
                                            id: widget.id,
                                            isEditFromShop: true,
                                          ));
                                    } else {
                                      Navigator.pushNamed(context,
                                          AppRoutes.postProductScreenRoute,
                                          arguments: PostProduct(
                                            isEdit: true,
                                            id: widget.id,
                                            isEditFromShop: false,
                                          ));
                                    }
                                  } else {
                                    // Navigator.pushNamed(context, AppRoutes.yourProductsCartScreenRoute);
                                    setState(() {
                                      isAddToCart = true;
                                    });
                                  }
                                },
                                name: widget.isMyProduct
                                    ? AppStrings.editProduct
                                    : AppStrings.addToCart,
                              ),
                            ),
                      height(0.03.sw),
                      isAddToCart
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Row(
                                children: [
                                  IconButtonWithBackground(
                                    // height: .074.sh,
                                    // width: .13.sw,
                                    height: 40.w,
                                    width: 40.w,
                                    borderRadius: 10,
                                    backgroundColor:
                                        AppColors.backIconBackgroundColor,
                                    iconColor:
                                        AppColors.bottomNavUnSelectedColor,
                                    onTap: () {
                                      print("clicked minus");
                                    },
                                    iconPath: AssetsPath.minus,
                                    iconSize: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: textWidget(
                                        // text: "1",
                                        text: state.cartModel?.data
                                                    ?.cartDetails !=
                                                null
                                            ? "${state.cartModel?.data?.cartDetails?[index].qty}"
                                            : "",
                                        fontSize:
                                            AppDimensions.textSizeCartText,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textBlackColor),
                                  ),
                                  IconButtonWithBackground(
                                    // height: .07.sh,
                                    // width: .13.sw,
                                    height: 40.w,
                                    width: 40.w,
                                    borderRadius: 10,
                                    iconSize: 16,
                                    backgroundColor:
                                        AppColors.backIconBackgroundColor,
                                    onTap: () {
                                      print("clicked add");
                                    },
                                    iconPath: AssetsPath.add,
                                    iconColor:
                                        AppColors.bottomNavUnSelectedColor,
                                  ),
                                  width(0.03.sw),
                                  Expanded(
                                      child: CustomMaterialButton(
                                          onPressed: () {
                                            // AppUtils.showBottomModalSheet(
                                            //     context: contextBuilder,
                                            //     widget:
                                            //         const ModalBottomSheetProducts()
                                            //     // const BottomModalSheetDeliveryAddress()
                                            //     );
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
