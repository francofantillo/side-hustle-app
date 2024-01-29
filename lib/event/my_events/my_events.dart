import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_completed_list.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_onging_list.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_scheduled_list.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  late final EventsCubit _bloc;
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
    _bloc = BlocProvider.of(context);
    getMyEvents();
    super.initState();
  }

  getMyEvents() async {
    if (_tabIndexBasicToggle.value == 0) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getMyEventsCubit(
          context: context, mounted: mounted, status: Events.Scheduled.name);
    } else if (_tabIndexBasicToggle.value == 1) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getMyEventsCubit(
          context: context, mounted: mounted, status: Events.Ongoing.name);
    } else if (_tabIndexBasicToggle.value == 2) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getMyEventsCubit(
          context: context, mounted: mounted, status: Events.Completed.name);
    }
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
                    getMyEvents();
                    setState(() {});
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
