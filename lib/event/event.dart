import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/event/widgets/event_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late final EventsCubit _bloc;
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    print("initState Events");
    _bloc = BlocProvider.of<EventsCubit>(context);
    isProductSelected = true;
    getEvents();
    super.initState();
  }

  getEvents() async {
    await _bloc.getEventsCubit(context: context, mounted: mounted);
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
              title: AppStrings.postAnEvent,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.postEventScreenRoute);
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
                title: AppStrings.events,
              ),
            ),
            BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
              return state.eventsLoading
                  ? const SizedBox.shrink()
                  : state.eventsModel?.events?.isEmpty ?? true
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.only(
                              left: AppDimensions.rootPadding,
                              right: AppDimensions.rootPadding,
                              top: AppDimensions.rootPadding),
                          child: SearchTextField(
                              // height: AppDimensions.searchTextFieldHeight,
                              contentPaddingBottom: 8,
                              hintText: AppStrings.searchEvent,
                              onChanged: (search) {
                                _bloc.searchEvents(value: search);
                              }),
                        );
            }),
            // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
            const EventList(),
            height(0.07.sw),
          ],
        ),
      );
    });
  }
}
