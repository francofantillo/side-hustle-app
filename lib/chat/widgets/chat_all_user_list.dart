import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_item.dart';
import 'package:side_hustle/event/widgets/event_item.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class ChatAllUsersList extends StatefulWidget {
  const ChatAllUsersList({super.key});

  @override
  State<ChatAllUsersList> createState() => _ChatAllUsersListState();
}

class _ChatAllUsersListState extends State<ChatAllUsersList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: 10,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          return Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: ChatAllUsersItem()
          );
        },
      ),
    );
  }
}
