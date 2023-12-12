import 'package:flutter/material.dart';
import 'package:side_hustle/event/widgets/attendees_confirmed_list.dart';
import 'package:side_hustle/event/widgets/attendees_interested_list.dart';
import 'package:side_hustle/event/widgets/attendees_tab.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_list.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';

class AttendeesEvent extends StatefulWidget {
  const AttendeesEvent({super.key});

  @override
  State<AttendeesEvent> createState() => _AttendeesEventState();
}

class _AttendeesEventState extends State<AttendeesEvent> {
  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.attendees,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.rootPadding),
        child: Column(
          children: [
            // Padding(padding: EdgeInsets.all(8)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          /*    child: SizedBox(
                width: 1.sw,
                child: ToggleSwitch(
                  // customWidths: [.45.sw, .47.sw],
                  customWidths: [.5.sw, .38.sw],
                  animate: true,
                  animationDuration: 200,
                  minHeight: AppDimensions.tabBarHeight,
                  isVertical: false,
                  minWidth: 90,
                  cornerRadius: 20.0,
                  changeOnTap: true,
                  activeBgColors: const [
                    [AppColors.primaryColor],
                    [AppColors.primaryColor]
                  ],
                  activeFgColor: Colors.white,
                    inactiveBgColor: AppColors.switchTabBackgroundColor,
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: _tabIndexBasicToggle.value,
                  totalSwitches: 2,
                  labels: [
                    AttendeesEnum.Interested.name,
                    AttendeesEnum.Confirmed.name,
                  ],
                  radiusStyle: true,
                  onToggle: (index) {
                    _tabIndexBasicToggle.value = index ?? 0;
                    print('switched to: ${_tabIndexBasicToggle.value}');
                    setState(() {});
                  },
                ),
              ),*/
              child: AttendeesTab(currentTabIndex: 0, onChanged: (index) {
                setState(() {
                  _tabIndexBasicToggle.value = index;
                });
              },),
            ),
            Builder(builder: (context) {
              return Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.rootPadding, vertical: 8),
                    child: _tabIndexBasicToggle.value == 0
                        ? AttendeesInterestedList(
                            itemsList: AppList.attendeesList,
                          )
                        : AttendeesConfirmedList(
                            itemsList: AppList.attendeesList,
                          )),
              );
            })
          ],
        ),
      ),
    );
  }
}
