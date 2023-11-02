import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/profile/other_user_profile/widgets/shop_overview_list.dart';
import 'package:side_hustle/profile/widgets/jobs_widget.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({super.key});

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
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
        appBarTitle: AppStrings.userProfile,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultHorizontalPadding + 4,
              vertical: AppDimensions.defaultHorizontalPadding),
          child: SizedBox(
            width: 1.sw,
            height: 45.h,
            child: CustomButtonWithIcon(
                borderRadius: 12,
                onPressed: () {
                  // Navigator.pushNamed(context, AppRoutes.yourShopScreenRoute);
                  Navigator.pushNamed(
                      context, AppRoutes.otherUserShopScreenRoute);
                },
                iconSize: 12,
                backgroundColor: AppColors.primaryColor,
                iconPath: AssetsPath.sideHustle,
                name: AppStrings.viewShop),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child:
              backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 0.09.sw, // Adjust as needed
              height: 0.09.sw, // Adjust as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.backIconBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    CustomIcon.forward,
                    size: 0.05.sw,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircularCacheImageWidget(
                showLoading: true,
                boarderColor: AppColors.primaryColor,
                imageHeight: 90.w,
                imageWidth: 90.w,
                borderWidth: .003.sh,
              ),
            ),
            height(0.01.sh),
            Center(
              child: textWidget(
                  text: AppStrings.otherUserName,
                  color: AppColors.textBlackColor,
                  fontSize: AppDimensions.textSizeNormal,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: textWidget(
                  text: AppStrings.otherUserEmail,
                  fontSize: AppDimensions.textSizeVerySmall),
            ),
            height(0.02.sh),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileJobsWidget(
                      name: AppStrings.jobsPosted,
                      myJobsCount: "12",
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.otherUserJobsPostedScreenRoute);
                      }),
                  width(0.04.sw),
                  ProfileJobsWidget(
                      name: AppStrings.eventsPosted,
                      myJobsCount: "28",
                      onTap: () {
                        Navigator.pushNamed(context,
                            AppRoutes.otherUserEventsPostedScreenRoute);
                      }),
                ],
              ),
            ),
            height(0.02.sh),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultHorizontalPadding + 4),
              child: customMaterialButton(
                  height: 11.h,
                  onPressed: () {},
                  name: AppStrings.message,
                  borderRadius: 12),
            ),
            height(0.01.sh),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultHorizontalPadding + 4),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultHorizontalPadding + 4),
              child: textWidget(
                  text: AppStrings.shopOverview.toUpperCase(),
                  color: AppColors.primaryColor,
                  fontSize: AppDimensions.textSizeNormal,
                  fontWeight: AppDimensions.headingFontWeight),
            ),
            const ShopOverviewList(),
            height(0.03.sh),
          ],
        ),
      );
    });
  }
}
