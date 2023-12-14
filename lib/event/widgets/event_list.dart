import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/view_event.dart';
import 'package:side_hustle/event/widgets/event_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.14.sh),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: state.eventsModel?.events?.length ?? 0, // Replace with your item count
              // itemCount: 4,
              itemBuilder: (context, index) {
                // Replace with your horizontal list item
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                  child: EventItemsWidget(
                    onTap: () {
                      // Navigator.pushNamed(context, AppRoutes.viewEventScreenRoute);
                      Navigator.pushNamed(context, AppRoutes.viewEventScreenRoute, arguments: ViewEvent(
                        id: state.eventsModel?.events?[index].eventId,
                      ));
                    },
                    imageWidth: 1.sw,
                    imageHeight: AppDimensions.listItemHeight,
                    boarderColor: AppColors.itemBGColor,
                    // title: AlphaAppData.eventsList[index].title,
                    title: state.eventsModel?.events?[index].name,
                    location:
                    // AlphaAppData.eventsList[index].subTitle,
                    state.eventsModel?.events?[index].location,
                    // imagePath: AlphaAppData.eventsList[index].imagePath,
                    imagePath: state.eventsModel?.events?[index].image,
                    // price: AlphaAppData.eventsList[index].price,
                    price: state.eventsModel?.events?[index].price,
                    userName:
                    // AlphaAppData.eventsList[index].userName,
                    state.eventsModel?.events?[index].eventOwnerDetail?.name,
                    // userRating: AlphaAppData.eventsList[index].userRating,
                    userRating: state.eventsModel?.events?[index].eventOwnerDetail?.rating,
                    // userProfile: AlphaAppData.eventsList[index].userProfile,
                    userProfile: state.eventsModel?.events?[index].eventOwnerDetail?.image,
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}
