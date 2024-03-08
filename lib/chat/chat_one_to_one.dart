import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_one_to_one_list.dart';
import 'package:side_hustle/chat/widgets/chat_options_bottomsheet.dart';
import 'package:side_hustle/chat/widgets/custom_text_field_chat.dart';
import 'package:side_hustle/chat/widgets/message_options_bottomsheet.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/state_management/service/socket_ibis_service.dart';
import 'package:side_hustle/utils/api_path.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class ChatOneToOne extends StatefulWidget {
  final bool isBlockedUser;
  final bool isOrderChat, isOrderService;
  final int index;
  final String? userName;
  final int? customerId;
  final int? modelId;
  final int? chatId;
  final String? modelName;
  final String? senderModel;
  final String? receiverModel;

  const ChatOneToOne(
      {super.key,
      this.customerId,
      this.modelId,
      this.modelName,
      this.senderModel,
      this.userName,
      this.index = 0,
      this.isBlockedUser = false,
      this.isOrderChat = false,
      this.isOrderService = false,
      this.chatId,
      this.receiverModel});

  @override
  State<ChatOneToOne> createState() => _ChatOneToOneState();
}

class _ChatOneToOneState extends State<ChatOneToOne> {
  final TextEditingController chatController = TextEditingController();
  late final ChatCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    setReceiverId();
    connectUser();
    getChatMessages();
  }

  setReceiverId() {
    _bloc.setReceiverId(receiverId: widget.customerId);
  }

  getChatMessages() async {
    await _bloc.getMessagesCubit(
        context: context,
        mounted: mounted,
        customerId: widget.customerId,
        modelId: widget.modelId,
        modelName: widget.modelName);
  }

  void sendMessage({int? messageType, String message = ""}) async {
    final UserModel? userModel = await _bloc.getUserData();
    int? uId = userModel?.data?.id;

    /// Seller or Buyer

    /// Send message json
    /// message_type = 1 for text and 2 for image
    final json = {
      "message_type": messageType,
      "sender_id": uId,
      "receiver_id": widget.customerId,
      "model_id": widget.modelId,
      "chat_id": widget.chatId,
      "sender_model": widget.senderModel,
      "receiver_model": widget.receiverModel,
      "created_at": DateTime.now().toIso8601String(),
      "message": message,
    };
    // final json = {
    //   "message_type": messageType,
    //   "user_id": 38,
    //   "receiver_id": 18,
    //   "chat_id": 11,
    //   "sender_model": "Seller",
    //   "receiver_model": "Buyer",
    //   "message": message,
    // };

    print("sendMessage: $json");

    /// connect users
    SocketService.instance?.socketEmitMethod(
        eventName: API.SEND_MESSAGE_EVENT, eventParameters: json);

    chatController.clear();
  }

  void connectUser() async {
    final UserModel? userModel = await _bloc.getUserData();
    int? uId = userModel?.data?.id;

    /// Connect User
    final json = {
      "user_id": uId,
      "user_model": widget.senderModel,
    };

    print("connectUser: $json");

    /// connect users
    SocketService.instance
        ?.socketEmitMethod(eventName: API.CONNECT_EVENT, eventParameters: json);
  }

  double BUBBLE_RADIUS = 16;

  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  Widget _image() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 20.0,
        minWidth: 20.0,
      ),
      child: CachedNetworkImage(
        imageUrl: 'https://i.ibb.co/JCyT1kT/Asset-1.png',
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  String addTimeSpacing({required int textLength}) {
    String x = "     ";
    for (int i = 0; i < textLength; i++) {
      x += "";
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return BackgroundWidget(
      backgroundColor: Colors.white.withOpacity(0.01),
      showAppBar: true,
      appBarTitle: widget.userName ?? AppStrings.chatUserName,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 0.09.sw, // Adjust as needed
            height: 0.09.sw, // Adjust as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backIconBackgroundColor,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.more_vert_sharp,
                size: 0.055.sw,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                AppUtils.showBottomModalSheet(
                    context: context,
                    widget: MessageOptionsBottomSheet(
                      onTap: () async {
                        print("clicked");
                        if (widget.isBlockedUser) {
                          await _bloc
                              .unBlockUserChatCubit(
                                  context: context,
                                  mounted: mounted,
                                  chatId: 8,
                                  index: widget.index)
                              .then((value) {
                            if (value == 1) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          });
                        } else {
                          await _bloc
                              .blockUserChatCubit(
                                  context: context,
                                  mounted: mounted,
                                  chatId: 8,
                                  index: widget.index)
                              .then((value) {
                            if (value == 1) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          });
                        }
                        // Navigator.pushNamed(
                        //     context, AppRoutes.chatBlockUsersScreenRoute);
                      },
                      textBlockedUserOrUnBlockedUser: widget.isBlockedUser
                          ? AppStrings.unBlockUser
                          : AppStrings.blockUser,
                    ));
                // AppUtils.showBottomModalSheet(context: context, widget: const BottomModalSheetDeliveryAddress());
              },
            ),
          ),
        )
      ],
      body: Material(
        elevation: 0,
        child: Column(
          children: [
            ChatOneToOneUsersList(
                isOrderChat: widget.isOrderChat,
                isOrderService: widget.isOrderService),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.isBlockedUser
                        ? Center(
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  print("clicked");
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    color: Color(0xFFE8E8EE),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      AppStrings.unblockUserMessage,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    height(0.03.sw),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextFieldChat(
                          controller: chatController,
                          hintText: AppStrings.typeAMessage,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: IconButtonWithBackground(
                            height: .15.sw,
                            width: .15.sw,
                            borderRadius: 30,
                            iconSize: 18,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                            onTap: () {
                              print("clicked minus");
                              if (chatController.text.trim().isNotEmpty) {
                                sendMessage(
                                    messageType: 1,
                                    message: chatController.text);
                              }
                            },
                            iconPath: AssetsPath.send,
                          ),
                        ),
                      ],
                    ),
                    height(0.02.sw),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
