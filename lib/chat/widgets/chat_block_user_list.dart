import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/state_management/models/chat_model.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';

class ChatBlockUsersList extends StatefulWidget {
  final List? itemList;

  const ChatBlockUsersList({super.key, this.itemList});

  @override
  State<ChatBlockUsersList> createState() => _ChatBlockUsersListState();
}

class _ChatBlockUsersListState extends State<ChatBlockUsersList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      return state.chatBlockedUsersLoading
          ? const SizedBox.shrink()
          : state.chatBlockedUsersModel?.chatList?.isEmpty ?? true
              // ? const Expanded(
              //     child: CustomErrorWidget(
              //         errorMessage: AppStrings.errorMessageEvent),
              //   )
              ? const SizedBox.shrink()
              : blockedUsersList(
                  itemList: state.searchingChatBlocked
                      ? state.chatBlockedTempList
                      : state.chatBlockedUsersModel?.chatList);
    });
  }

  Widget blockedUsersList({required List<ChatListData>? itemList}) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: itemList?.length ?? 0,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          return Material(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.chatOneToOneScreenRoute,
                    arguments: ChatOneToOne(
                      index: index,
                      isBlockedUser: true,
                    ));
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                  child: ChatAllUsersItem(
                    image: itemList?[index].userImage,
                    time: itemList?[index].createdAt,
                    name: itemList?[index].userName,
                    message: itemList?[index].message,
                  )),
            ),
          );
        },
      ),
    );
  }
}
