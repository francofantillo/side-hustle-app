import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/widgets/completed_job_list.dart';
import 'package:side_hustle/job/my_jobs/widgets/ongoing_job_list.dart';
import 'package:side_hustle/job/my_jobs/widgets/scheduled_job_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/custom_tab_bar/custom_tab_bar.dart';

import '../../utils/app_enums.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  late final JobsCubit _bloc;
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
    _bloc = BlocProvider.of(context);
    getMyJobs();
    super.initState();
  }

  getMyJobs() async {
    if (_tabIndexBasicToggle.value == 0) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getMYJobSCubit(
          context: context, mounted: mounted, type: MyJobsEnum.Pending.name);
    } else if (_tabIndexBasicToggle.value == 1) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getMYJobSCubit(
          context: context, mounted: mounted, type: MyJobsEnum.Ongoing.name);
    } else if (_tabIndexBasicToggle.value == 2) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getMYJobSCubit(
          context: context, mounted: mounted, type: MyJobsEnum.Completed.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contextBuilder) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return BackgroundWidget(
        showAppBar: true,
        appBarTitle: AppStrings.myJobs,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child:
              backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
            Padding(
                padding:
                    EdgeInsets.only(left: 0.04.sw, right: 0.0425.sw, top: 8),
                child: CustomTabBar(
                  currentTabIndex: 0,
                  tabNames: const [
                    AppStrings.scheduled,
                    AppStrings.ongoing,
                    AppStrings.completed,
                  ],
                  onChanged: (index) {
                    _tabIndexBasicToggle.value = index;
                    getMyJobs();
                    setState(() {});
                  },
                )),
            _tabIndexBasicToggle.value == 0
                ? const MyJobsScheduledList()
                : _tabIndexBasicToggle.value == 1
                    ? const MyJobsOnGoingList()
                    : _tabIndexBasicToggle.value == 2
                        ? const MyJobsCompletedList()
                        : const SizedBox.shrink(),
            // height(0.02.sh)
            _tabIndexBasicToggle.value == 0
                ? BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
                    return state.myJobsLoading
                        ? const SizedBox.shrink()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: PrimaryPostButton(
                                title: AppStrings.postJob,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.postJobScreenRoute);
                                }),
                          );
                  })
                : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }
}
