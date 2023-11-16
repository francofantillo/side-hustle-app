import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/shop/widgets/your_product_list_shop.dart';
import 'package:side_hustle/shop/widgets/your_services_list_shop.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/image_slider/camera_button.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';
import 'package:toggle_switch/toggle_switch.dart';

class YourShopScreen extends StatefulWidget {
  const YourShopScreen({super.key});

  @override
  State<YourShopScreen> createState() => _YourShopScreenState();
}

class _YourShopScreenState extends State<YourShopScreen> {
  var index = 0;
  bool isProductSelected = true;
  bool isEdit = false;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
    isEdit = false;
    super.initState();
  }

  List<List<Color>?>? bgColorsZero = [
    [AppColors.primaryColor],
    [Colors.transparent],
    [Colors.transparent],
    [Colors.transparent],
  ];

  List<List<Color>?>? bgColorsOne = [
    [Colors.transparent],
    [AppColors.primaryColor],
    [Colors.transparent],
    [Colors.transparent],
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contextBuilder) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return BackgroundWidget(
        showAppBar: true,
        appBarTitle: AppStrings.shop,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child:
          backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 8),
            child: CircularIconButton(
              onPressed: () {
                if (isEdit) {
                  isEdit = false;
                  setState(() {});
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
          )
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      RoundedCornersImage(
                        // imageHeight: 80.h,
                        imageHeight: isEdit
                            ? AppDimensions.imageHeightShopEdit
                            : AppDimensions.imageHeightShop,
                        // imageWidth: AppDimensions.imageSizeShop,
                        imageWidth: isEdit
                            ? AppDimensions.imageWidthShopEdit
                            : AppDimensions.imageWidthShop,
                        // imageWidth: 0.22.sh,
                        assetImage: AssetsPath.yourShop,
                        boarderColor: AppColors.whiteColor,
                      ),
                      isEdit
                          ? Positioned(
                        left: AppDimensions.imageWidthShopEdit - 0.15.sw,
                        top: AppDimensions.imageHeightShopEdit - 0.15.sw,
                        // child: IconButtonWithBackground(
                        //   onTap: () {
                        //     print("Clicked");
                        //   },
                        //   iconPath: AssetsPath.camera,
                        //   height: 0.12.sw,
                        //   width: 0.12.sw,
                        //   backgroundColor: AppColors.whiteColor,
                        //   iconColor: AppColors.primaryColor,
                        // ),
                        child: CameraButton(
                          onTap: () {
                            print("Clicked");
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
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const CustomTextFormField(
                                hintText: AppStrings.shopName,
                                maxLines: 1,
                              ),
                              CustomTextFormField(
                                hintText: AppStrings.zipCode,
                                maxLines: 2,
                                height: 75.h,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: textWidget(
                              text: AppStrings.shop,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeNormal,
                              color: AppColors.textBlackColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: ImageIcon(
                                const AssetImage(AssetsPath.location),
                                size: 0.025.sh,
                                color: AppColors.greyColorNoOpacity,
                              ),
                            ),
                            width(0.02.sw),
                            Expanded(
                              child: textWidget(
                                  text: AppStrings.locationText,
                                  maxLines: 3,
                                  fontSize:
                                  AppDimensions.textSizeVerySmall),
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
              padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              child: CustomTextFormField(

                hintText: AppStrings.shopAddress,
                maxLines: 1,
                height: 45.h,
                // height: 0.16.sh
              ),
            )
                : const SizedBox.shrink(),
            Padding(
              // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 0.02.sw),
              child: SizedBox(
                width: 1.sw,
                child: ToggleSwitch(
                  customWidths: [.5.sw, .396.sw],
                  animate: true,
                  animationDuration: 200,
                  isVertical: false,
                  minWidth: 90,
                  cornerRadius: 12.0.w,
                  changeOnTap: true,
                  activeBgColors: const [
                    [AppColors.primaryColor],
                    [AppColors.primaryColor]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: AppColors.switchTabBackgroundColor,
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: _tabIndexBasicToggle.value,
                  totalSwitches: 2,
                  labels: [
                    SideHustleType.Products.name,
                    SideHustleType.Services.name,
                  ],
                  radiusStyle: true,
                  onToggle: (index) {
                    _tabIndexBasicToggle.value = index ?? 0;
                    print('switched to: ${_tabIndexBasicToggle.value}');
                    setState(() {});
                  },
                ),
              ),
            ),
            _tabIndexBasicToggle.value == 0
                ? YourProductsListShop(isEdit: isEdit)
                : YourServicesListShop(isEdit: isEdit),
            height(0.02.sh),
            PrimaryPostButton(
                title: AppStrings.postASideHustle,
                onPressed: () {
                  AppDialogues.postSideHustleDialogue(
                      context: contextBuilder,
                      body: PostYourSideHustleDialogueWidget(
                        isProductSelected: (v) {
                          isProductSelected = v;
                          print("prodcut: $isProductSelected");
                        },
                        onPressed: () {
                          print("pressed Dialogue");
                          if (isProductSelected) {
                            /// reset to Default Value
                            isProductSelected = true;
                            // Navigator.pop(contextBuilder);
                            AppDialogues.postSideHustleDialogue(
                                context: contextBuilder)
                                .dismiss();
                            Navigator.pushNamed(contextBuilder,
                                AppRoutes.postProductScreenRoute);
                          } else {
                            /// reset to Default Value
                            isProductSelected = true;
                            AppDialogues.postSideHustleDialogue(
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
        ),
      );
    });
  }
}
