import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_navigation/bottom_nav.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/drawer/app_drawer.dart';
import 'package:side_hustle/home/widgets/home_first_item_list.dart';
import 'package:side_hustle/home/widgets/home_widgets.dart';
import 'package:side_hustle/home/widgets/items_widget.dart';
import 'package:side_hustle/home/widgets/jobs_events_item_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/wanted_job/widgets/applied_job.dart';
import 'package:side_hustle/wanted_job/widgets/applied_tab_list.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/completed_job.dart';
import 'package:side_hustle/wanted_job/widgets/completed_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/wanted_tab_list.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
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
  int _switchTabTextIndexSelected = 0;

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
              child: Scrollbar(
                child: Container(
                  margin: const EdgeInsets.only(left: 16, top: 6),
                  child: ToggleSwitch(
                    // customWidths: [110.0, 70.0, 70.0, 90.0],
                    isVertical: false,
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
