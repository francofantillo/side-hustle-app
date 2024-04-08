import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/shop/widgets/custom_tab_bar_shop.dart';
import 'package:side_hustle/shop/widgets/your_product_list_shop.dart';
import 'package:side_hustle/shop/widgets/your_services_list_shop.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/image_slider/camera_button.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image_beta.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class YourShopScreen extends StatefulWidget {
  const YourShopScreen({super.key});

  @override
  State<YourShopScreen> createState() => _YourShopScreenState();
}

class _YourShopScreenState extends State<YourShopScreen> {
  late final SideHustleCubit _bloc;
  File? _imagePath;
  var index = 0;
  bool isProductSelected = true;
  bool isEdit = false;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    _bloc = BlocProvider.of<SideHustleCubit>(context);
    isProductSelected = true;
    isEdit = false;
    getYourShop();
    super.initState();
  }

  getYourShop() async {
    await _bloc.getYourShopCubit(context: context, mounted: mounted);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideHustleCubit, SideHustleState>(
        builder: (contextBuilder, state) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return BackgroundWidget(
        showAppBar: true,
        // appBarTitle: isEdit ? AppStrings.editShop : AppStrings.shop,
        appBarTitle: isEdit
            ? AppStrings.editShop
            : state.yourShopModel?.shopData?.shopDetail?.name,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: backButton(
              onPressed: () {
                if (isEdit) {
                  isEdit = false;
                  setState(() {});
                } else {
                  Navigator.pop(context);
                }
              },
              iconSize: 16),
        ),
        actions: [
          BlocBuilder<SideHustleCubit, SideHustleState>(
              builder: (context, state) {
            return state.yourShopLoading
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 8),
                    child: CircularIconButton(
                      onPressed: () async {
                        if (isEdit) {
                          await _bloc
                              .editYourShopCubit(
                                  context: context,
                                  mounted: mounted,
                                  image: _imagePath)
                              .then((value) {
                            if (value == 1) {
                              isEdit = false;
                              setState(() {});
                            }
                          });
                        } else {
                          isEdit = true;
                          setState(() {});
                        }
                      },
                      width: 0.10.sw,
                      height: 0.10.sw,
                      icon: isEdit ? Icons.check : Icons.edit,
                      backgroundColor: AppColors.backIconBackgroundColor,
                      iconSize: 14,
                      iconColor: AppColors.primaryColor,
                    ),
                  );
          })
        ],
        body: BlocBuilder<SideHustleCubit, SideHustleState>(
            builder: (context, state) {
          return state.yourShopLoading
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              RoundedCornersImageBeta(
                                // imageHeight: 80.h,
                                imageHeight: isEdit
                                    ? AppDimensions.imageHeightShopEdit
                                    : AppDimensions.imageHeightYourShop,
                                // imageWidth: AppDimensions.imageSizeShop,
                                imageWidth: isEdit
                                    ? AppDimensions.imageWidthShopEdit
                                    : AppDimensions.imageWidthYourShop,
                                // imageWidth: 0.22.sh,
                                // assetImage: AssetsPath.yourShop,
                                assetImage: AssetsPath.imageLoadError,
                                image: _imagePath?.path ??
                                    state.yourShopModel?.shopData?.shopDetail
                                        ?.image,
                                boarderColor: AppColors.whiteColor,
                              ),
                              isEdit
                                  ? Positioned(
                                      left: AppDimensions.imageWidthShopEdit -
                                          0.15.sw,
                                      top: AppDimensions.imageHeightShopEdit -
                                          0.15.sw,
                                      child: CameraButton(
                                        onTap: () async {
                                          print("Clicked");
                                          final image = await ImagePickerService
                                              .selectImageFromGallery();
                                          if (image != null) {
                                            _imagePath = image;
                                            print("image: ${_imagePath?.path}");
                                            setState(() {});
                                          }
                                        },
                                        iconPath: AssetsPath.camera,
                                        height: 0.12.sw,
                                        width: 0.12.sw,
                                        backgroundColor: AppColors.whiteColor,
                                        iconColor: AppColors.primaryColor,
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                          width(0.03.sw),
                          isEdit
                              ? Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomTextFormField(
                                              controller:
                                                  _bloc.shopNameTextController,
                                              hintText: AppStrings.shopName,
                                              maxLines: 1,
                                            ),
                                            height(6.w),
                                            CustomTextFormField(
                                              controller: _bloc
                                                  .shopZipCodeTextController,
                                              hintText: AppStrings.zipCode,
                                              maxLines: 2,
                                              height: 75.h,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatter: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              // height: 0.16.sh
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 6.h),
                                        child: textWidget(
                                            // text: AppStrings.shop,
                                            text: state.yourShopModel?.shopData
                                                ?.shopDetail?.name,
                                            fontFamily: AppFont.gilroyBold,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                AppDimensions.textSizeLarge +
                                                    2.sp,
                                            color: AppColors.textBlackColor),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          state.yourShopModel?.shopData
                                                      ?.shopDetail?.location ==
                                                  null
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0),
                                                  child: ImageIcon(
                                                    const AssetImage(
                                                        AssetsPath.location),
                                                    size: 0.037.sw,
                                                    color:
                                                        const Color(0xFF565656),
                                                  ),
                                                ),
                                          width(0.02.sw),
                                          Expanded(
                                            child: textWidget(
                                                // text: AppStrings.locationText,
                                                text: state
                                                    .yourShopModel
                                                    ?.shopData
                                                    ?.shopDetail
                                                    ?.location,
                                                maxLines: 3,
                                                color: const Color(0xFF565656),
                                                fontSize: AppDimensions
                                                    .textSizeVerySmall),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                    isEdit
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.w),
                            child: CustomTextFormField(
                              hintText: AppStrings.shopAddress,
                              maxLines: 1,
                              height: 45.h,
                              isReadonly: true,
                              onTap: () async {
                                await _bloc.selectShopLocation(
                                    context: context, mounted: mounted);
                              },
                              controller: _bloc.shopLocationTextController,
                              // height: 0.16.sh
                            ),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 0.02.sw),
                      child: CustomTabBarShop(
                        currentTabIndex: _tabIndexBasicToggle.value,
                        tabNames: [
                          SideHustleType.Products.name,
                          SideHustleType.Services.name,
                        ],
                        onChanged: (index) {
                          setState(() {
                            _tabIndexBasicToggle.value = index;
                          });
                        },
                      ),
                    ),
                    _tabIndexBasicToggle.value == 0
                        ? YourProductsListShop(isEdit: isEdit)
                        : YourServicesListShop(isEdit: isEdit),
                    height(0.02.sh),
                    isEdit
                        ? const SizedBox.shrink()
                        : PrimaryPostButton(
                            title: AppStrings.postASideHustle,
                            onPressed: () {
                              AppDialogues.noHeaderDialogue(
                                  context: contextBuilder,
                                  body: PostYourSideHustleDialogueWidget(
                                    isProductSelected: (v) {
                                      isProductSelected = v;
                                      print("prodcut: $isProductSelected");
                                    },
                                    onPressed: () {
                                      print("pressed Dialogue");
                                      _bloc.setIsProductOrServiceFromYourShop(
                                          isProductOrServiceFromYourShop: true);
                                      if (isProductSelected) {
                                        /// reset to Default Value
                                        isProductSelected = true;
                                        // Navigator.pop(contextBuilder);
                                        AppDialogues.noHeaderDialogue(
                                                context: contextBuilder)
                                            .dismiss();
                                        Navigator.pushNamed(contextBuilder,
                                            AppRoutes.postProductScreenRoute);
                                      } else {
                                        /// reset to Default Value
                                        isProductSelected = true;
                                        AppDialogues.noHeaderDialogue(
                                                context: contextBuilder)
                                            .dismiss();
                                        // Navigator.pop(contextBuilder);
                                        Navigator.pushNamed(contextBuilder,
                                            AppRoutes.postServiceScreenRoute);
                                      }
                                    },
                                    onTapClose: () {
                                      Navigator.pop(contextBuilder);
                                    },
                                  )).show();
                            }),
                  ],
                );
        }),
      );
    });
  }
}
