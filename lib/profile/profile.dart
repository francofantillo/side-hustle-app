import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/drawer/drawer_item.dart';
import 'package:side_hustle/event/widgets/event_list.dart';
import 'package:side_hustle/profile/widgets/jobs_widget.dart';
import 'package:side_hustle/profile/widgets/profile_items_widget.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/circular_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
/*        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: PrimaryPostButton(
              title: AppStrings.postAnEvent,
              onPressed: () {
                AppDialogues.postSideHustleDialogue(
                        context: contextBuilder,
                        body: PostYourSideHustle(
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
                        ))
                    // ..show()
                    .show();
              }),
        ),*/
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: AppDimensions.rootPadding,
                    right: AppDimensions.rootPadding,
                    top: AppDimensions.rootPadding),
                child: CustomHomeAppBarWidget(
                  contextBuilder: contextBuilder,
                  title: AppStrings.profileResumePage,
                  hideNotificationIcon: true,
                  hideProfileIcon: false,
                ),
              ),
              height(0.02.sh),
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
                    text: AppStrings.userName,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeNormal,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: textWidget(
                    text: AppStrings.userEmail,
                    fontSize: AppDimensions.textSizeVerySmall),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultHorizontalPadding + 4),
                child: SizedBox(
                  width: 1.sw,
                  child: CustomButtonWithIcon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.yourShopScreenRoute);
                      },
                      iconSize: 12,
                      backgroundColor: AppColors.greenColor,
                      iconPath: AssetsPath.sideHustle,
                      name: AppStrings.yourShop),
                ),
              ),
              height(0.01.sh),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileJobsWidget(
                        name: AppStrings.myJobs,
                        myJobsCount: "12",
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.myJobsScreenRoute);
                        }),
                    ProfileJobsWidget(
                        name: AppStrings.jobsCompleted,
                        myJobsCount: "12",
                        onTap: () {}),
                    ProfileJobsWidget(
                        name: AppStrings.myEvents,
                        myJobsCount: "12",
                        onTap: () {}),
                  ],
                ),
              ),
              height(0.01.sh),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultHorizontalPadding + 4),
                child: Divider(),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultHorizontalPadding + 4),
                child: textWidget(
                    text: AppStrings.account,
                    color: AppColors.primaryColor,
                    fontSize: AppDimensions.textSizeNormal,
                    fontWeight: AppDimensions.headingFontWeight),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultHorizontalPadding),
                child: ProfileItemsWidget(),
              ),
              height(0.03.sh),
            ],
          ),
        ),
      );
    });
  }
}
