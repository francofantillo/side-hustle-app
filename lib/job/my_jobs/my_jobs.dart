import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/favourites/widgets/fav_list_events.dart';
import 'package:side_hustle/favourites/widgets/fav_list_jobs.dart';
import 'package:side_hustle/favourites/widgets/fav_list_shops.dart';
import 'package:side_hustle/job/my_jobs/widgets/completed_job_list.dart';
import 'package:side_hustle/job/my_jobs/widgets/ongoing_job_list.dart';
import 'package:side_hustle/job/my_jobs/widgets/scheduled_job_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/wanted_job/widgets/applied_tab_list.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/completed_job_list.dart';
import 'package:side_hustle/wanted_job/widgets/wanted_tab_list.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
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
              padding: EdgeInsets.only(left: 0.04.sw, right: 0.0425.sw),
              child: SizedBox(
                width: 1.sw,
                child: ToggleSwitch(
                  customWidths: [.3.sw, .3.sw, .305.sw],
                  animate: true,
                  animationDuration: 200,
                  isVertical: false,
                  // minWidth: 90,
                  cornerRadius: 12.0.w,
                  changeOnTap: true,
                  activeBgColors: const [
                    [AppColors.primaryColor],
                    [AppColors.primaryColor],
                    [AppColors.primaryColor]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: AppColors.whiteColor,
                  borderWidth: 1,
                  borderColor: [AppColors.tabOutlineColor],
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: _tabIndexBasicToggle.value,
                  totalSwitches: 3,
                  labels: const [
                    AppStrings.scheduled,
                    AppStrings.ongoing,
                    AppStrings.completed,
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
            _tabIndexBasicToggle.value == 0
                ? const MyJobsScheduledList()
                : _tabIndexBasicToggle.value == 1
                    ? const MyJobsOnGoingList()
                    : _tabIndexBasicToggle.value == 2
                        ? const MyJobsCompletedList()
                        : const SizedBox.shrink(),
            height(0.02.sh)
          ],
        ),
      );
    });
  }
}
