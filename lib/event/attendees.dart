import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/event/widgets/attendees_confirmed_list.dart';
import 'package:side_hustle/event/widgets/attendees_interested_list.dart';
import 'package:side_hustle/event/widgets/attendees_tab.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_list.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';

class AttendeesEvent extends StatefulWidget {
  final int? eventId;

  const AttendeesEvent({super.key, this.eventId});

  @override
  State<AttendeesEvent> createState() => _AttendeesEventState();
}

class _AttendeesEventState extends State<AttendeesEvent> {
  late final EventsCubit _bloc;
  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    getAttendees();
  }

  getAttendees() async {
    await _bloc.getAttendeesCubit(
        context: context,
        mounted: mounted,
        type: _tabIndexBasicToggle.value == 0
            ? AttendeesEnum.Interested.name
            : AttendeesEnum.Confirmed.name,
        eventId: widget.eventId?.toString());
  }

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
              child: AttendeesTab(
                currentTabIndex: 0,
                onChanged: (index) {
                  _tabIndexBasicToggle.value = index;
                  getAttendees();
                  setState(() {});
                },
              ),
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
