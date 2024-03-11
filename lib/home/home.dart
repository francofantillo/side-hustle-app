import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/home/widgets/events_around_you_list.dart';
import 'package:side_hustle/home/widgets/home_appbar.dart';
import 'package:side_hustle/home/widgets/home_first_item_list.dart';
import 'package:side_hustle/home/widgets/home_location_widget.dart';
import 'package:side_hustle/home/widgets/jobs_around_you_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/image_slider/banner_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthCubit _bloc;
  late final SideHustleCubit _blocSideHustle;
  var index = 0;
  bool isProductSelected = true;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    _blocSideHustle = BlocProvider.of<SideHustleCubit>(context);
    isProductSelected = true;
    getCurrentLocation();
    getDashboard();
    super.initState();
  }

  getDashboard() async {
    await _bloc.getDashboardCubit(context: context, mounted: mounted);
  }

  getCurrentLocation() async {
    await _bloc.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (contextBuilder, state) {
      return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: PrimaryPostButton(
              title: AppStrings.postASideHustle,
              onPressed: () {
                AppDialogues.noHeaderDialogue(
                        context: context,
                        body: PostYourSideHustleDialogueWidget(
                          isProductSelected: (v) {
                            isProductSelected = v;
                            print("prodcut: $isProductSelected");
                          },
                          onPressed: () {
                            print("pressed Dialogue");
                            _blocSideHustle.setIsProductOrServiceFromYourShop(
                                isProductOrServiceFromYourShop: false);
                            if (isProductSelected) {
                              /// reset to Default Value
                              isProductSelected = true;
                              // Navigator.pop(contextBuilder);
                              AppDialogues.noHeaderDialogue(context: context)
                                  .dismiss();
                              Navigator.pushNamed(
                                  context, AppRoutes.postProductScreenRoute);
                            } else {
                              /// reset to Default Value
                              isProductSelected = true;
                              AppDialogues.noHeaderDialogue(context: context)
                                  .dismiss();
                              // Navigator.pop(contextBuilder);
                              Navigator.pushNamed(
                                  context, AppRoutes.postServiceScreenRoute);
                            }
                          },
                          onTapClose: () {
                            Navigator.pop(context);
                          },
                        ))
                    // ..show()
                    .show();
              }),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Padding(
                padding: EdgeInsets.only(
                    left: AppDimensions.rootPadding,
                    right: AppDimensions.rootPadding,
                    top: AppDimensions.rootPadding),
                child: HomeAppBar(
                  contextBuilder: contextBuilder,
                ),
              )),
          body: state.dashboardLoading
              ? const SizedBox.shrink()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppDimensions.rootPadding + 6,
                                right: AppDimensions.rootPadding,
                                top: AppDimensions.rootPadding),
                            child: const HomeLocationWidget(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppDimensions.rootPadding + 10.w,
                                right: AppDimensions.rootPadding,
                                top: AppDimensions.rootPadding + 0),
                            child: Row(
                              children: [
                                textWidget(
                                    text: AppStrings.blessTheseBusinesses,
                                    fontSize: AppDimensions.textSizeNormal,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFont.gilroyBold,
                                    color: AppColors.textBlackColor),
                              ],
                            ),
                          ),
                          state.dashboardModel?.data?.banners?.isEmpty ?? true
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: AppDimensions.rootPadding,
                                      right: AppDimensions.rootPadding,
                                      top: AppDimensions.rootPadding - 8.w),
                                  child: const NoImagesFoundWidget(),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: AppDimensions.rootPadding,
                                      right: AppDimensions.rootPadding,
                                      top: AppDimensions.rootPadding - 8.w),
                                  child: BannerSlider(
                                    hideCameraIcon: true,
                                    indicatorLength: state
                                        .dashboardModel?.data?.banners?.length,
                                    responseImages:
                                        state.dashboardModel?.data?.banners,
                                  ),
                                ),
                          // Horizontal ListView
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppDimensions.rootPadding,
                              right: AppDimensions.rootPadding,
                            ),
                            child: FirstHomeListItemWidget(
                              horizontalListSize:
                                  AppDimensions.homeFirstHorizontalListSize,
                              itemsList: AlphaAppData.homeFirstList,
                              onTapLabel: () {
                                print("Clicked");
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppDimensions.rootPadding,
                                right: AppDimensions.rootPadding,
                                bottom: 6),
                            child: JobsAroundYouList(
                              title: "Jobs around you",
                              horizontalListSize: AppDimensions.listItemHeight,
                              itemsList: AlphaAppData
                                  .jobsAndEventsList[index].itemList,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppDimensions.rootPadding,
                                right: AppDimensions.rootPadding,
                                bottom: 6),
                            child: EventsAroundYouList(
                              title: "Events around you",
                              horizontalListSize: AppDimensions.listItemHeight,
                              itemsList: AlphaAppData
                                  .jobsAndEventsList[index].itemList,
                            ),
                          ),
                          height(100),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
