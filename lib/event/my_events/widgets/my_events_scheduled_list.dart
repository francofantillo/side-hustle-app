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

class MyEventsScheduledList extends StatefulWidget {
  const MyEventsScheduledList({super.key});

  @override
  State<MyEventsScheduledList> createState() => _MyEventsScheduledListState();
}

class _MyEventsScheduledListState extends State<MyEventsScheduledList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
      return state.myEventsLoading
          ? const SizedBox.shrink()
          : state.myEventsModel?.events?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageEvent),
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
                                  index: index,
                                ));
                          },
                          imageWidth: 1.sw,
                          imageHeight:
                              AppDimensions.listItemEventScheduledHeight,
                          boarderColor: AppColors.itemBGColor,
                          // title: AlphaAppData.favEventsList[index].title,
                          title: state.myEventsModel?.events?[index].name,
                          // subTitle: AlphaAppData.favEventsList[index].subTitle,
                          location:
                              state.myEventsModel?.events?[index].location,
                          imagePath:
                              // AlphaAppData.favEventsList[index].imagePath,
                              state.myEventsModel?.events?[index].image,
                          // imagePath: AssetsPath.imageLoadError,
                          // price: AlphaAppData.favEventsList[index].price,
                          price: state.myEventsModel?.events?[index].price?.toStringAsFixed(2),
                          // userName: AlphaAppData.favEventsList[index].userName,
                          // userRating:
                          //     AlphaAppData.favEventsList[index].userRating,
                          // userProfile:
                          //     AlphaAppData.favEventsList[index].userProfile,
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
