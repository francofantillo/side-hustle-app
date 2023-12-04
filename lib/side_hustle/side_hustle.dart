import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/side_hustle/widgets/products_list.dart';
import 'package:side_hustle/side_hustle/widgets/services_list.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SideHustle extends StatefulWidget {
  const SideHustle({super.key});

  @override
  State<SideHustle> createState() => _SideHustleState();
}

class _SideHustleState extends State<SideHustle> {
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
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding),
              child: CustomHomeAppBarWidget(
                contextBuilder: contextBuilder,
                title: AppStrings.sideHustle,
                hideNotificationIcon: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding - 8.w),
              child: SearchTextField(
                  height: AppDimensions.searchTextFieldHeight,
                  contentPaddingBottom: 8,
                  hintText: _tabIndexBasicToggle.value == 0
                      ? AppStrings.searchSideHustleProductsHintText
                      : AppStrings.searchSideHustleServicesHintText,
                  onChanged: (search) {}),
            ),
            Padding(
              // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              padding: EdgeInsets.only(
                  left: 0.04.sw, right: 0.0425.sw, top: 0.02.sw),
              child: SizedBox(
                width: 1.sw,
                child: ToggleSwitch(
                  customWidths: [.5.sw, .41.sw],
                  animate: true,
                  animationDuration: 200,
                  isVertical: false,
                  minWidth: 90,
                  // minHeight: 0.13.sw,
                  minHeight: AppDimensions.tabBarHeight,
                  cornerRadius: 12.0.w,
                  changeOnTap: true,
                  activeBgColors: const [
                    [AppColors.primaryColor],
                    [AppColors.primaryColor]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: AppColors.switchTabBackgroundColor,
                  inactiveFgColor: AppColors.greyColor,
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
            // height(0.02.sw),
            _tabIndexBasicToggle.value == 0
                ? const ProductsList()
                : const ServicesList()
          ],
        ),
      );
    });
  }
}
