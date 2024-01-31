import 'package:flutter/material.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/wanted_job/widgets/applied_tab_list.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/completed_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/wanted_job_tab.dart';
import 'package:side_hustle/wanted_job/widgets/wanted_tab_list.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

class WantedJobScreen extends StatefulWidget {
  final int currentTabIndex;

  const WantedJobScreen({super.key, this.currentTabIndex = 0});

  @override
  State<WantedJobScreen> createState() => _WantedJobScreenState();
}

class _WantedJobScreenState extends State<WantedJobScreen> {
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
      print("_tabIndexBasicToggle.value: ${_tabIndexBasicToggle.value}");
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
              // child: SearchTextField(
              //     hintText: AppStrings.searchJob,
              //     contentPaddingBottom: 10,
              //     height: AppDimensions.searchTextFieldHeight,
              //     suffixIcon: Padding(
              //       padding: const EdgeInsets.only(right: 12.0, left: 0),
              //       child: Material(
              //           child: InkWell(
              //               onTap: () {
              //                 print("onClicked Filter");
              //               },
              //               child: ImageIcon(
              //                 const AssetImage(AssetsPath.searchFilter),
              //                 size: AppDimensions.imageIconSizeTextFormField,
              //               ))),
              //     ),
              //     onChanged: (search) {}),
              child: SearchTextField(
                  // height: AppDimensions.searchTextFieldHeight,
                  contentPaddingBottom: 8,
                  hintText: AppStrings.searchJob,
                  onChanged: (search) {}),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
              child: WantedJobTab(
                currentTabIndex: widget.currentTabIndex,
                onChanged: (index) {
                  setState(() {
                    _tabIndexBasicToggle.value = index;
                  });
                },
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
