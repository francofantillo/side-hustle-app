import 'package:flutter/material.dart';
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
  const WantedJobScreen({super.key});

  @override
  State<WantedJobScreen> createState() => _WantedJobScreenState();
}

class _WantedJobScreenState extends State<WantedJobScreen> {
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
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
          child: PrimaryPostButton(
              title: AppStrings.postJob,
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
                      const ImageIcon(AssetImage(AssetsPath.searchFilter)),
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
                    inactiveFgColor: Colors.black,
                    initialLabelIndex: _tabIndexBasicToggle.value,
                    totalSwitches: 4,
                    labels: const [
                      "${AppStrings.wantedJob}s",
                      AppStrings.applied,
                      AppStrings.booked,
                      AppStrings.completed
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
