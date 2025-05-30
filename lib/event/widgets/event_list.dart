import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/event/view_event.dart';
import 'package:side_hustle/event/widgets/event_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  late final FavouritesCubit _blocFav;
  late final EventsCubit _blocEvent;

  @override
  void initState() {
    _blocFav = BlocProvider.of<FavouritesCubit>(context);
    _blocEvent = BlocProvider.of<EventsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
      return state.eventsLoading
          ? const SizedBox.shrink()
          : state.eventsModel?.events?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageEvent),
                )
              : eventsList(
                  itemList: state.searching
                      ? state.eventsTempList
                      : state.eventsModel?.events);
    });
  }

  Widget eventsList({required List<EventsData>? itemList}) {
    return itemList?.isEmpty ?? true
        ? const Expanded(
            child:
                CustomErrorWidget(errorMessage: AppStrings.errorMessageEvent),
          )
        : Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.14.sw),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                shrinkWrap: true,
                // reverse: true,
                scrollDirection: Axis.vertical,
                itemCount: itemList?.length ?? 0,
                itemBuilder: (context, index) {
                  // Replace with your horizontal list item
                  print("isFavourite: ${itemList?[index].isFavourite}");
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    child: EventItemsWidget(
                      onTapChat: () {
                        print(
                            "clicked chat, id receiver: ${itemList?[index].eventOwnerDetail?.id}");
                        Navigator.pushNamed(
                            context, AppRoutes.chatOneToOneScreenRoute,
                            arguments: ChatOneToOne(
                              // index: index,
                              isBlockedUser: false,
                              customerId: itemList?[index].eventOwnerDetail?.id,
                              userName: itemList?[index].eventOwnerDetail?.name,
                              modelId: itemList?[index].eventId,
                              modelName: ChatEnum.Event.name,
                              chatId: 0,
                              senderModel: ChatModelEnum.Buyer.name,
                              receiverModel: ChatModelEnum.Seller.name,
                            ));
                      },
                      onTapFav: () async {
                        print("Event Id: ${itemList?[index].eventId}");
                        if (itemList?[index].isFavourite == 0) {
                          await _blocFav
                              .addToFavCubit(
                                  context: context,
                                  mounted: mounted,
                                  type: Favourites.Event.name,
                                  id: itemList?[index].eventId)
                              .then((value) async {
                            if (value == 1) {
                              await _blocEvent.setFave(
                                  index: index, isFavourite: value);
                            }
                          });
                        } else {
                          await _blocFav
                              .removeFromFavCubit(
                                  context: context,
                                  mounted: mounted,
                                  type: Favourites.Event.name,
                                  id: itemList?[index].eventId)
                              .then((value) async {
                            if (value == 1) {
                              await _blocEvent.setFave(
                                  index: index, isFavourite: 0);

                              /// 0 to unFav
                            }
                          });
                        }
                      },
                      onTap: () {
                        // Navigator.pushNamed(context, AppRoutes.viewEventScreenRoute);
                        Navigator.pushNamed(
                            context, AppRoutes.viewEventScreenRoute,
                            arguments: ViewEvent(
                              id: itemList?[index]
                                  .eventId, // make a separate class for selecting an image and user
                            ));
                      },
                      isFavourite: itemList?[index].isFavourite ?? 0,
                      imageWidth: 1.sw,
                      imageHeight: AppDimensions.listItemHeight,
                      boarderColor: AppColors.itemBGColor,
                      // title: AlphaAppData.eventsList[index].title,
                      title: itemList?[index].name,
                      location:
                          // AlphaAppData.eventsList[index].subTitle,
                          itemList?[index].location,
                      // imagePath: AlphaAppData.eventsList[index].imagePath,
                      imagePath: itemList?[index].image,
                      // price: AlphaAppData.eventsList[index].price,
                      price: itemList?[index].price?.toStringAsFixed(2),
                      userName:
                          // AlphaAppData.eventsList[index].userName,
                          itemList?[index].eventOwnerDetail?.name,
                      // userRating: AlphaAppData.eventsList[index].userRating,
                      userRating: itemList?[index].eventOwnerDetail?.rating,
                      // userProfile: AlphaAppData.eventsList[index].userProfile,
                      userProfile: itemList?[index].eventOwnerDetail?.image,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
