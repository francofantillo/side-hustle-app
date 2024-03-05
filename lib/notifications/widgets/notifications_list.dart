import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/notifications/widgets/notifications_item.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class NotificationsList extends StatefulWidget {
  final List? itemList;

  const NotificationsList({super.key, this.itemList});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  int isPastIndex = -1;
  bool isPastData = false;

  void isPastDate({String? timeStamp, required int index}) {
    if (timeStamp != null) {
      final isPast = DateTimeConversions.isPastDate(timeStamp: timeStamp);
      if (isPast && !isPastData) {
        isPastIndex = index;
        isPastData = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
          itemCount: state.notificationsModel?.data?.length ?? 0,
          // Replace with your item count
          itemBuilder: (context, index) {
            // Replace with your horizontal list item
            isPastDate(
                timeStamp: state.notificationsModel?.data?[index].datetime,
                index: index);
            return Material(
              color: AppColors.whiteColor,
              child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, AppRoutes.chatOneToOneScreenRoute);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    index == isPastIndex
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: textWidget(
                                text: "Older",
                                color: AppColors.blackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                        child: NotificationsItem(
                          index: index,
                          totalItem: 5,
                          image:
                              state.notificationsModel?.data?[index].senderName,
                          time: isPastData
                              ? DateTimeConversions.notificationsDate(
                                  // timeStamp: "2024-01-11T19:46:13.00000Z")
                                  timeStamp: state.notificationsModel
                                      ?.data?[index].datetime)
                              : DateTimeConversions.notificationsTimeAMPM(
                                  // timeStamp: "2024-01-11T19:46:13.00000Z"),
                                  timeStamp: state.notificationsModel
                                      ?.data?[index].datetime),
                          name:
                              state.notificationsModel?.data?[index].senderName,
                          message: state
                              .notificationsModel?.data?[index].notification,
                        )),
                    index == 2
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: textWidget(
                                text: "Older",
                                color: AppColors.blackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
