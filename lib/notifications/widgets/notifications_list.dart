import 'package:flutter/material.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_item.dart';
import 'package:side_hustle/notifications/widgets/notifications_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class NotificationsList extends StatefulWidget {
  final List? itemList;

  const NotificationsList({super.key, this.itemList});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: 6,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          return Material(
            color: AppColors.whiteColor,
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, AppRoutes.chatOneToOneScreenRoute);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                      child: NotificationsItem(
                        index: index,
                        totalItem: 5,
                        image: AlphaAppData.notificationsList[index].image,
                        time: AlphaAppData.notificationsList[index].time,
                        name: AlphaAppData.notificationsList[index].name,
                        message: AlphaAppData.notificationsList[index].message,
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
      ),
    );
  }
}
