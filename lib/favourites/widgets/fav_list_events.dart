import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/fav_item_events.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class FavouritesListEvent extends StatefulWidget {
  const FavouritesListEvent({super.key});

  @override
  State<FavouritesListEvent> createState() => _FavouritesListEventState();
}

class _FavouritesListEventState extends State<FavouritesListEvent> {
  late final FavouritesCubit _bloc;
  late final EventsCubit _blocEvent;

  @override
  void initState() {
    _bloc = BlocProvider.of<FavouritesCubit>(context);
    _blocEvent = BlocProvider.of<EventsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
      return state.favouritesModelLoading
          ? const SizedBox.shrink()
          : state.favouritesModel?.favourites?.isEmpty ?? true
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
                    itemCount: state.favouritesModel?.favourites?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, top: 8),
                        child: FavItemEventsWidget(
                          onTapFav: () async {
                            final eventsData = _blocEvent
                                .state.eventsModel?.events
                                ?.where((element) => (element.eventId ==
                                    state.favouritesModel?.favourites?[index]
                                        .id));

                            int? eventIndex;
                            if (eventsData != null && eventsData.isNotEmpty) {
                              eventIndex = _blocEvent.state.eventsModel?.events
                                  ?.indexOf(eventsData.first);
                              print(
                                  "eventIndex: $eventIndex) eventsData: ${eventsData.first.eventId}");
                            }

                            await _bloc
                                .removeFromFavCubit(
                                    context: context,
                                    mounted: mounted,
                                    type: Favourites.Event.name,
                                    id: state
                                        .favouritesModel?.favourites?[index].id)
                                .then((value) {
                              if (value == 1) {
                                if (eventIndex != null) {
                                  _blocEvent.setFave(
                                      index: eventIndex, isFavourite: 0);
                                }
                              }
                            });
                          },
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.listItemFavEventsHeight,
                          boarderColor: AppColors.itemBGColor,
                          // title: AlphaAppData.favEventsList[index].title,
                          title: state.favouritesModel?.favourites?[index].name,
                          // location: AppStrings.locationText,
                          location: state
                              .favouritesModel?.favourites?[index].location,
                          imagePath:
                              // AlphaAppData.favEventsList[index].imagePath,
                              state.favouritesModel?.favourites?[index].image,
                          // price: AlphaAppData.favEventsList[index].price,
                          price:
                              "\$${state.favouritesModel?.favourites?[index].price?.toStringAsFixed(2)}",
                          // userName: AlphaAppData.favEventsList[index].userName,
                          userName: state.favouritesModel?.favourites?[index]
                              .ownerDetail?.name,
                          userRating:
                              // AlphaAppData.favEventsList[index].userRating,
                              state.favouritesModel?.favourites?[index]
                                  .ownerDetail?.rating,
                          userProfile:
                              // AlphaAppData.favEventsList[index].userProfile,
                              state.favouritesModel?.favourites?[index]
                                  .ownerDetail?.image,
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
