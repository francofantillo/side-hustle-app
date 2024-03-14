import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/wanted_job/widgets/applied_tab_list.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/completed_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/wanted_job_tab.dart';
import 'package:side_hustle/wanted_job/widgets/wanted_tab_list.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

import '../utils/app_enums.dart';

class WantedJobScreen extends StatefulWidget {
  final int currentTabIndex;

  const WantedJobScreen({super.key, this.currentTabIndex = 0});

  @override
  State<WantedJobScreen> createState() => _WantedJobScreenState();
}

class _WantedJobScreenState extends State<WantedJobScreen> {
  late final JobsCubit _bloc;
  late final ValueNotifier<int> _tabIndexBasicToggle;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    _tabIndexBasicToggle = ValueNotifier(widget.currentTabIndex);
    // isProductSelected = true;
    // xyz
    getWantedJobs();
    super.initState();
  }

  getWantedJobs() async {
    if (_tabIndexBasicToggle.value == 0) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getWantedJobsCubit(
          context: context, mounted: mounted, type: JobsEnum.WantedJobs.name);
    } else if (_tabIndexBasicToggle.value == 1) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getWantedJobsCubit(
          context: context, mounted: mounted, type: JobsEnum.Applied.name);
    } else if (_tabIndexBasicToggle.value == 2) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getWantedJobsCubit(
          context: context, mounted: mounted, type: JobsEnum.Booked.name);
    } else if (_tabIndexBasicToggle.value == 3) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getWantedJobsCubit(
          context: context, mounted: mounted, type: JobsEnum.Completed.name);
    }
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
              child: SearchTextField(
                  // height: AppDimensions.searchTextFieldHeight,
                  contentPaddingBottom: 8,
                  hintText: AppStrings.searchJob,
                  onChanged: (search) {
                    _bloc.searchWantedJobs(value: search);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
              child: WantedJobTab(
                currentTabIndex: widget.currentTabIndex,
                onChanged: (index) {
                  _tabIndexBasicToggle.value = index;
                  getWantedJobs();
                  setState(() {});
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
