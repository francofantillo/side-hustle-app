import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/profile/widgets/jobs_widget.dart';
import 'package:side_hustle/profile/widgets/profile_items_widget.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final AuthCubit _bloc;
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    isProductSelected = true;
    getProfile();
    super.initState();
  }

  getProfile() async {
    await _bloc.getProfileCubit(context: context, mounted: mounted);
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
    return BlocBuilder<AuthCubit, AuthState>(builder: (contextBuilder, state) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding),
              child: CustomHomeAppBarWidget(
                contextBuilder: contextBuilder,
                title: AppStrings.profileResumePage,
                hideNotificationIcon: false,
                hideEditProfileIcon: true,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: AppDimensions.rootPadding,
              //       right: AppDimensions.rootPadding,
              //       top: AppDimensions.rootPadding),
              //   child: CustomHomeAppBarWidget(
              //     contextBuilder: contextBuilder,
              //     title: AppStrings.profileResumePage,
              //     hideNotificationIcon: false,
              //     hideEditProfileIcon: true,
              //   ),
              // ),
              // height(0.02.sw),
              Center(
                child: CircularCacheImageWidget(
                  showLoading: true,
                  // assetImage: AssetsPath.brandonProfile,
                  // image: state.resumeModel?.data?.profileImage,
                  image: state.userModel?.data?.image,
                  assetImage: AssetsPath.placeHolder,
                  boarderColor: AppColors.primaryColor,
                  imageHeight: 90.w,
                  imageWidth: 90.w,
                  borderWidth: .003.sw,
                ),
              ),
              height(0.01.sw),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: textWidget(
                      // text: AppStrings.davidHan,
                      text: state.userModel?.data?.name,
                      color: AppColors.textBlackColor,
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.textHeadingSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: textWidget(
                      // text: AppStrings.userEmail,
                      text: state.userModel?.data?.email,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeVerySmall),
                ),
              ),
              height(0.01.sw),
              Padding(
                padding: EdgeInsets.symmetric(
                    // horizontal: 28.w),
                    horizontal: 0.05.sw),
                child: SizedBox(
                  width: 1.sw,
                  height: 47.w,
                  child: CustomButtonWithIcon(
                      // borderRadius: 12,
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
              // height(0.01.sh),
              Padding(
                padding: EdgeInsets.only(
                    // left: 28.w, right: 28.w, top: 8.w),
                    left: 0.05.sw,
                    right: 0.05.sw,
                    top: 8.w),
                child: CustomMaterialButton(
                    // height: 6,
                    borderRadius: 12,
                    fontSize: AppDimensions.textSizeVerySmall,
                    color: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Navigator.pushNamed(
                          // context, AppRoutes.yourResumeEditScreenRoute);
                          context,
                          AppRoutes.yourResumeScreenRoute);
                    },
                    name: AppStrings.yourResume),
              ),
              // height(0.03.sh),
              Padding(
                padding: EdgeInsets.only(
                    left: 0.052.sw, right: 0.052.sw, top: 12, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ProfileJobsWidget(
                          name: AppStrings.myJobs,
                          myJobsCount:
                              state.profileModel?.data?.myJobs?.toString(),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.myJobsScreenRoute);
                          }),
                    ),
                    // width(8.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProfileJobsWidget(
                            name: AppStrings.jobsCompleted,
                            myJobsCount: state
                                .profileModel?.data?.completedJobs
                                ?.toString()),
                      ),
                    ),
                    Expanded(
                      child: ProfileJobsWidget(
                          name: AppStrings.myEvents,
                          myJobsCount:
                              state.profileModel?.data?.myEvents?.toString(),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.myEventsScreenRoute);
                          }),
                    ),
                  ],
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: AppDimensions.defaultHorizontalPadding + 4),
              //   child: Divider(),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultHorizontalPadding + 4,
                    vertical: 8),
                child: Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
              height(0.01.sw),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: AppDimensions.defaultHorizontalPadding + 4),
              //   child: textWidget(
              //       text: AppStrings.account.toUpperCase(),
              //       // color: AppColors.primaryColor,
              //       color: const Color(0xFF3896EE),
              //       fontFamily: AppFont.gilroyBold,
              //       fontSize: AppDimensions.textSizeSmall,
              //       fontWeight: FontWeight.bold),
              // ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.defaultHorizontalPadding),
                  child: ProfileItemsWidget(),
                ),
              ),
              height(0.03.sw),
            ],
          ),
        ),
      );
    });
  }
}
