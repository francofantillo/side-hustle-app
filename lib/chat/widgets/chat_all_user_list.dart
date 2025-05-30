import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/state_management/models/chat_model.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';

class ChatAllUsersList extends StatefulWidget {
  final List? itemList;

  const ChatAllUsersList({super.key, this.itemList});

  @override
  State<ChatAllUsersList> createState() => _ChatAllUsersListState();
}

class _ChatAllUsersListState extends State<ChatAllUsersList> {
  late final ChatCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      return state.chatAllUsersLoading
          ? const SizedBox.shrink()
          : state.chatAllUsersModel?.chatList?.isEmpty ?? true
      // ? const Expanded(
      //     child: CustomErrorWidget(
      //         errorMessage: AppStrings.errorMessageEvent),
      //   )
          ? const SizedBox.shrink()
          : chatList(
          itemList: state.searchingChat
              ? state.chatTempList
              : state.chatAllUsersModel?.chatList);
    });
  }

  Widget chatList({required List<ChatListData>? itemList}) {
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
              onTap: () async {
                final UserModel? userModel = await _bloc.getUserData();
                int? uId = userModel?.data?.id;

                /// sender and receiver ids are same check this
                String? senderModel;
                if (itemList?[index].senderModel == ChatModelEnum.Seller.name) {
                  senderModel = ChatModelEnum.Seller.name;
                } else {
                  senderModel = ChatModelEnum.Buyer.name;
                }
                print(
                    "cUId: ${userModel?.data?.id}, senderId: ${itemList?[index]
                        .senderId}, receiverId: ${itemList?[index]
                        .receiverId}");
                int? receiverId;
                if (uId == itemList![index].senderId) {
                  receiverId = itemList[index].receiverId;
                  print("true: receiverId: $receiverId");
                } else {
                  receiverId = itemList[index].senderId;
                  print("false: receiverId: $receiverId");
                }
                if (mounted) {
                  Navigator.pushNamed(
                      context, AppRoutes.chatOneToOneScreenRoute,
                      arguments: ChatOneToOne(
                        index: index,
                        isBlockedUser: false,
                        customerId: receiverId,
                        userName: itemList[index].userName,
                        modelId: itemList[index].modelId,
                        modelName: itemList[index].modelName,
                        chatId: itemList[index].chatId,
                        senderModel: senderModel,
                        receiverModel: senderModel != ChatModelEnum.Seller.name
                            ? ChatModelEnum.Seller.name
                            : ChatModelEnum.Buyer.name,
                      ));
                }
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                  child: ChatAllUsersItem(
                    image: itemList?[index].userImage,
                    time: DateTimeConversions.formatDateString(
                        date: itemList?[index].createdAt),
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
