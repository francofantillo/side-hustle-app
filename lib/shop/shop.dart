import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/shop/widgets/product_list_shop.dart';
import 'package:side_hustle/shop/widgets/services_list_shop.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedCornersImage(
                    imageHeight: AppDimensions.imageHeightShop,
                    imageWidth: AppDimensions.imageWidthShop,
                    assetImage: AssetsPath.social,
                    boarderColor: AppColors.whiteColor,
                  ),
                  width(0.03.sw),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: textWidget(
                              text: AppStrings.shop,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeLarge + 2.sp,
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
                                size: 0.037.sw,
                                color: Color(0xFF565656),
                              ),
                            ),
                            width(0.02.sw),
                            Expanded(
                              child: textWidget(
                                  text: AppStrings.locationText,
                                  maxLines: 3,
                                  color: Color(0xFF565656),
                                  fontSize: AppDimensions.textSizeVerySmall),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              child: CustomMaterialButton(
                  onPressed: () {},
                  name: AppStrings.getDirections,
                  color: AppColors.greenColor,
                  borderRadius: 16,
                  // height: 9.h
              ),
            ),
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
                ? const ProductsListShop()
                : const ServicesListShop()
          ],
        ),
      );
    });
  }
}
