import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/wanted_job/widgets/applied_tab_list.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/completed_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/wanted_tab_list.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WantedJobScreen extends StatefulWidget {
  final int currentTabIndex;

  const WantedJobScreen({super.key, this.currentTabIndex = 0});

  @override
  State<WantedJobScreen> createState() => _WantedJobScreenState();
}

class _WantedJobScreenState extends State<WantedJobScreen> {
  // var index = 0;
  // bool isProductSelected = true;

  late final ValueNotifier<int> _tabIndexBasicToggle;

  @override
  void initState() {
    _tabIndexBasicToggle = ValueNotifier(widget.currentTabIndex);
    // isProductSelected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contextBuilder) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          // child: _tabIndexBasicToggle.value == 0
          //     ? PrimaryPostButton(
          //         title: AppStrings.postJob,
          //         onPressed: () {
          //           Navigator.pushNamed(context, AppRoutes.postJobScreenRoute);
          //         })
          //     : const SizedBox.shrink(),
          child: PrimaryPostButton(
              title: AppStrings.postJob,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.postJobScreenRoute);
              }),
        ),
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
                title: AppStrings.wantedJob,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding),
              child: SearchTextField(
                  hintText: AppStrings.searchJob,

                  suffixIcon:
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 0),
                    child: Material(
                        child: InkWell(
                            onTap: (){
                              print("onClicked Filter");
                            },
                            child: const ImageIcon(AssetImage(AssetsPath.searchFilter)))),
                  ),
                  onChanged: (search) {}),
            ),
            // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Scrollbar(
                child: Container(
                  margin: const EdgeInsets.only(left: 16, top: 6),
                  child: ToggleSwitch(
                    // customWidths: [110.0, 70.0, 70.0, 90.0],
                    isVertical: false,
                    animate: true,
                    animationDuration: 200,
                    minWidth: 90,
                    minHeight: 0.1.sw,
                    cornerRadius: 20.0,
                    changeOnTap: true,
                    activeBgColors: const [
                      [AppColors.primaryColor],
                      [AppColors.primaryColor],
                      [AppColors.primaryColor],
                      [AppColors.primaryColor],
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: AppColors.switchTabBackgroundColor,
                    inactiveFgColor: AppColors.greyColor,
                    initialLabelIndex: _tabIndexBasicToggle.value,
                    totalSwitches: 4,
                    labels: const [
                      "${AppStrings.wantedJob}s",
                      AppStrings.applied,
                      AppStrings.booked,
                      AppStrings.completed
                    ],
                    fontSize: 8.sp,
                    radiusStyle: true,
                    onToggle: (index) {
                      _tabIndexBasicToggle.value = index ?? 0;
                      print('switched to: ${_tabIndexBasicToggle.value}');
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            _tabIndexBasicToggle.value == 0
                ? const WantedTabList()
                : _tabIndexBasicToggle.value == 1
                    ? const AppliedTabList()
                    : _tabIndexBasicToggle.value == 2
                        ? const BookedTabList()
                        : _tabIndexBasicToggle.value == 3
                            ? const CompletedTabList()
                            : const SizedBox.shrink()
          ],
        ),
      );
    });
  }
}
