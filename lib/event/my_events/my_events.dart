import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_completed_list.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_onging_list.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_scheduled_list.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
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
        appBarTitle: AppStrings.myEvents,
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
                /*        child: SizedBox(
                width: 1.sw,
                child: ToggleSwitch(
                  customWidths: [.3.sw, .3.sw, .305.sw],
                  minHeight: AppDimensions.tabBarHeight,
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
                  fontSize: AppDimensions.tabBarFontSize + 2.sp,
                  inactiveBgColor: AppColors.switchTabBackgroundColor,
                  inactiveFgColor: AppColors.greyColor,
                  activeFgColor: Colors.white,
                  borderWidth: 1,
                  borderColor: [AppColors.tabOutlineColor],
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
              ),*/
                child: CustomTabBar(
                  currentTabIndex: 0,
                  tabNames: const [
                    AppStrings.scheduled,
                    AppStrings.ongoing,
                    AppStrings.completed,
                  ],
                  onChanged: (index) {
                    setState(() {
                      _tabIndexBasicToggle.value = index;
                    });
                  },
                )),
            _tabIndexBasicToggle.value == 0
                ? const MyEventsScheduledList()
                : _tabIndexBasicToggle.value == 1
                    ? const MyEventsOngoingList()
                    : _tabIndexBasicToggle.value == 2
                        ? const MyEventsCompletedList()
                        : const SizedBox.shrink(),
            height(0.02.sh)
          ],
        ),
      );
    });
  }
}
