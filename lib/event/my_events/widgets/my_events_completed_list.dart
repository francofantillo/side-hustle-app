import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/my_events/widgets/my_events_scheduled_item.dart';
import 'package:side_hustle/event/view_event_self.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class MyEventsCompletedList extends StatefulWidget {
  const MyEventsCompletedList({super.key});

  @override
  State<MyEventsCompletedList> createState() => _MyEventsCompletedListState();
}

class _MyEventsCompletedListState extends State<MyEventsCompletedList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
      return state.myEventsLoading
          ? const SizedBox.shrink()
          : state.myEventsModel?.events?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageNoItemsFound),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.myEventsModel?.events?.length ?? 0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, top: 8),
                        child: MyEventsScheduledItemsWidget(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.viewEventSelfScreenRoute,
                                arguments: ViewEventSelf(
                                  id: state
                                      .myEventsModel?.events?[index].eventId,
                                  showEdit: false,
                                ));
                          },
                          imageWidth: 1.sw,
                          imageHeight:
                              AppDimensions.listItemEventScheduledHeight,
                          boarderColor: AppColors.itemBGColor,
                          title: state.myEventsModel?.events?[index].name,
                          location:
                              state.myEventsModel?.events?[index].location,
                          imagePath: state.myEventsModel?.events?[index].image,
                          price: state.myEventsModel?.events?[index].price,
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
