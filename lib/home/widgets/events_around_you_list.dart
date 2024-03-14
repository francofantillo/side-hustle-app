import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/event/view_event.dart';
import 'package:side_hustle/home/widgets/home_items_widget.dart';
import 'package:side_hustle/job/apply_job.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class EventsAroundYouList extends StatefulWidget {
  final String? title;
  final List<ItemList>? itemsList;
  final double horizontalListSize;
  final Function()? onTapLabel;
  final FavouritesCubit blocFav;
  final AuthCubit blocAuth;

  const EventsAroundYouList(
      {super.key,
      this.title,
      this.itemsList,
      this.onTapLabel,
      required this.blocFav,
      required this.blocAuth,
      required this.horizontalListSize});

  @override
  State<EventsAroundYouList> createState() => _EventsAroundYouListState();
}

class _EventsAroundYouListState extends State<EventsAroundYouList> {
  late final FavouritesCubit blocFav;
  late final AuthCubit blocAuth;

  @override
  void initState() {
    blocFav = BlocProvider.of<FavouritesCubit>(context);
    blocAuth = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return state.dashboardLoading
          ? const SizedBox.shrink()
          : state.dashboardModel?.data?.events?.isEmpty ?? true
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: widget.onTapLabel,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(
                                text: widget.title,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: AppDimensions.itemsArrowForwardIconSize,
                            )
                          ],
                        ),
                      ),
                    ),
                    // Horizontal ListView
                    SizedBox(
                      height:
                          widget.horizontalListSize, // Set the desired height
                      width: 1.sw,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            state.dashboardModel?.data?.events?.length ?? 0,
                        // Replace with your item count
                        itemBuilder: (context, index) {
                          // Replace with your horizontal list item
                          return Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: HomeItemsWidget(
                              onTapMessage: () {
                                print(
                                    "clicked chat, id receiver: ${state.dashboardModel?.data?.events?[index].userDetail?.userid}");
                                Navigator.pushNamed(
                                    context, AppRoutes.chatOneToOneScreenRoute,
                                    arguments: ChatOneToOne(
                                      // index: index,
                                      isBlockedUser: false,
                                      customerId: state.dashboardModel?.data
                                          ?.events?[index].userDetail?.userid,
                                      userName: state.dashboardModel?.data
                                          ?.events?[index].userDetail?.name,
                                      modelId: state.dashboardModel?.data
                                          ?.events?[index].eventId,
                                      modelName: ChatEnum.Event.name,
                                      chatId: 0,
                                      senderModel: ChatModelEnum.Buyer.name,
                                      receiverModel: ChatModelEnum.Seller.name,
                                    ));
                              },
                              perHead: AppStrings.perHead,
                              isFav: state.dashboardModel?.data?.events?[index]
                                      .isFavourite ??
                                  0,
                              onTapFav: () async {

                                if (state.dashboardModel?.data?.events?[index]
                                        .isFavourite ==
                                    0) {
                                  await blocFav
                                      .addToFavCubit(
                                          context: context,
                                          mounted: true,
                                          type: Favourites.Event.name,
                                          id: state.dashboardModel?.data
                                              ?.events?[index].eventId)
                                      .then((value) async {
                                    if (value == 1) {
                                      await blocAuth.setFavEvents(
                                          index: index, isFavourite: value);
                                    }
                                  });
                                }
                              },
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.viewEventScreenRoute,
                                    arguments: ViewEvent(
                                      id: state
                                          .dashboardModel
                                          ?.data
                                          ?.events?[index]
                                          .eventId, // make a separate class for selecting an image and user
                                    ));
                              },
                              commentIconPath: AssetsPath.comment,
                              imageWidth: 1.sw,
                              imageHeight: widget.horizontalListSize,
                              boarderColor: AppColors.itemBGColor,
                              title: state
                                  .dashboardModel?.data?.events?[index].name,
                              desc: state
                                  .dashboardModel?.data?.events?[index].purpose,
                              imagePath: state
                                  .dashboardModel?.data?.events?[index].image,
                              price: state
                                  .dashboardModel?.data?.events?[index].price
                                  ?.toStringAsFixed(2),
                              userName: state.dashboardModel?.data
                                  ?.events?[index].userDetail?.name,
                              userRating: state.dashboardModel?.data
                                          ?.events?[index].userDetail?.rating !=
                                      null
                                  ? state.dashboardModel!.data!.events![index]
                                              .userDetail!.rating ==
                                          0.0
                                      ? "0"
                                      : (state.dashboardModel?.data
                                          ?.events?[index].userDetail?.rating
                                          ?.toStringAsFixed(1))
                                  : "0",
                              userProfile: state.dashboardModel?.data
                                  ?.events?[index].userDetail?.image,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
    });
  }
}
