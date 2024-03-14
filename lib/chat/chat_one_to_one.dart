import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_one_to_one_list.dart';
import 'package:side_hustle/chat/widgets/custom_text_field_chat.dart';
import 'package:side_hustle/chat/widgets/message_options_bottomsheet.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/state_management/service/socket_ibis_service.dart';
import 'package:side_hustle/utils/api_path.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';

import 'package:path/path.dart' as p;

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
      this.chatId = 0,
      this.receiverModel});

  @override
  State<ChatOneToOne> createState() => _ChatOneToOneState();
}

class _ChatOneToOneState extends State<ChatOneToOne> {
  final TextEditingController chatController = TextEditingController();
  late final ChatCubit _bloc;
  bool showEmoji = false;
  final emojiC = TextEditingController();
  late final bool isBlockedUser;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    isBlockedUser = widget.isBlockedUser;
    printData();
    setReceiverId();
    connectUser();
    getChatMessages();
  }

  printData() {
    /*index: index,
    isBlockedUser: false,
    customerId: itemList?[index].receiverId,
    userName: itemList?[index].userName,
    modelId: itemList?[index].modelId,
    modelName: itemList?[index].modelName,
    chatId: itemList?[index].chatId,
    senderModel: senderModel,
    receiverModel: senderModel != ChatModelEnum.Seller.name
    ? ChatModelEnum.Seller.name
        : ChatModelEnum.Buyer.name,*/
    print(
        "index: ${widget.index}, isBlocked: ${widget.isBlockedUser}, customerId: ${widget.customerId} ");
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

  void sendMessageSender({String message = ""}) async {
    final UserModel? userModel = await _bloc.getUserData();
    int? uId = userModel?.data?.id;

    /// Seller or Buyer

    /// Send message json
    /// message_type = 1 for text and 2 for image
    final json = {
      "message_type": 1,
      "sender_id": uId,
      "receiver_id": widget.customerId,
      "model_id": widget.modelId,
      "chat_id": widget.chatId,
      "sender_model": widget.senderModel,
      "receiver_model": widget.receiverModel,
      "created_at": DateTime.now().toUtc().toIso8601String(),
      "message": message,
    };

    print("sendMessage: $json");

    /// connect users
    SocketService.instance?.socketEmitMethod(
        eventName: API.SEND_MESSAGE_EVENT, eventParameters: json);

    chatController.clear();
  }

  void sendImageSocket({String? imagePath}) async {
    final UserModel? userModel = await _bloc.getUserData();
    int? uId = userModel?.data?.id;

    /// Seller or Buyer

    /// Send message json
    /// message_type = 1 for text and 2 for image
    final json = {
      "message_type": 2,
      "sender_id": uId,
      "receiver_id": widget.customerId,
      "model_id": widget.modelId,
      "chat_id": widget.chatId,
      "sender_model": widget.senderModel,
      "file_path": imagePath,
      "receiver_model": widget.receiverModel,
      "created_at": DateTime.now().toIso8601String(),
    };

    print("sendMessage: $json");

    /// connect users
    SocketService.instance?.socketEmitMethod(
        eventName: API.SEND_MESSAGE_EVENT, eventParameters: json);

    chatController.clear();
  }

  dynamic attachImage({String? imagePath}) async {
    if (imagePath != null) {
      final UserModel? userModel = await _bloc.getUserData();
      int? uId = userModel?.data?.id;

      final bytes = File(imagePath).readAsBytesSync();
      String img64 = base64Encode(bytes);
      if (mounted) {
        await _bloc
            .uploadImageCubit(
              context: context,
              mounted: mounted,
              senderId: uId,
              receiverId: widget.customerId,
              modelId: widget.modelId,
              chatId: widget.chatId,
              senderModel: widget.senderModel,
              receiverModel: widget.receiverModel,
              fileType: p.extension(img64),
              imageBase64: img64,
            )
            .then((value) => {
                  if (value != null) {sendImageSocket(imagePath: value)}
                });
      }
    }
  }

  void sendImage({
    required String imageBase64,
  }) async {
    final UserModel? userModel = await _bloc.getUserData();
    int? uId = userModel?.data?.id;

    /// Seller or Buyer

    /// message_type = 1 for text and 2 for image
    final json = {
      "message_type": 2,
      "sender_id": uId,
      "receiver_id": widget.customerId,
      "model_id": widget.modelId,
      "chat_id": widget.chatId,
      "sender_model": widget.senderModel,
      "receiver_model": widget.receiverModel,
      "created_at": DateTime.now().toIso8601String(),
      "file_type": "",
      "image": imageBase64,
    };

    print("sendMessage: $json");

    /// send message
    SocketService.instance?.socketEmitMethod(
        eventName: API.SEND_MESSAGE_EVENT, eventParameters: json);
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

  _onBackspacePressed() {
    chatController
      ..text = chatController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatController.text.length));
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
      appBarTitle: widget.userName ?? "",
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
                        // if (widget.isBlockedUser) {
                        if (isBlockedUser) {
                          await _bloc
                              .unBlockUserChatCubit(
                                  context: context,
                                  mounted: mounted,
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
                                  index: widget.index)
                              .then((value) {
                            if (value == 1) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                      // textBlockedUserOrUnBlockedUser: widget.isBlockedUser
                      textBlockedUserOrUnBlockedUser: isBlockedUser
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
            // _image(),
            ChatOneToOneUsersList(
              isOrderChat: widget.isOrderChat,
              isOrderService: widget.isOrderService,
              modelId: widget.modelId,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // widget.isBlockedUser
                    //     ? Center(
                    //         child: Material(
                    //           child: InkWell(
                    //             onTap: () {
                    //               print("clicked");
                    //             },
                    //             child: Container(
                    //               decoration: const BoxDecoration(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(6)),
                    //                 color: Color(0xFFE8E8EE),
                    //               ),
                    //               child: const Padding(
                    //                 padding: EdgeInsets.all(5.0),
                    //                 child: Text(
                    //                   AppStrings.unblockUserMessage,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox.shrink(),
                    height(0.03.sw),
                    isBlockedUser
                    ? const SizedBox.shrink()
                    : Row(
                      children: [
                        Expanded(
                            child: CustomTextFieldChat(
                          controller: chatController,
                          hintText: AppStrings.typeAMessage,
                          onTapEmoji: () {
                            print("clicked emoji");
                            _bloc.showEmoji();
                          },
                          onTap: () {
                            _bloc.hideEmoji();
                          },
                          onTapAttachment: () async {
                            final image = await ImagePickerService
                                .selectImageFromGallery();

                            if (image != null) {
                              await attachImage(imagePath: image.path);
                            }
                          },
                          onTapCamera: () async {
                            final image = await ImagePickerService.openCamera();

                            if (image != null) {
                              await attachImage(imagePath: image.path);
                            }
                          },
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
                                sendMessageSender(message: chatController.text);
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
            BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              return Offstage(
                // offstage: showEmoji,
                offstage: state.showEmoji,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    onEmojiSelected: (Category? category, Emoji? emoji) {
                      print(" emoji!.emoji: ${emoji!.emoji}");
                      emojiC.text = emoji.emoji;
                      String temp = chatController.text + emojiC.text;
                      chatController.text = temp;
                    },
                    onBackspacePressed: _onBackspacePressed(),
                    textEditingController: emojiC,
                    config: const Config(
                      columns: 7,
                      emojiSizeMax: 30,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: Colors.white,
                      indicatorColor: Color(0xffAC61E7),
                      iconColor: Colors.grey,
                      iconColorSelected: Color(0xffAC61E7),
                      backspaceColor: Color(0xffAC61E7),
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      recentTabBehavior: RecentTabBehavior.RECENT,
                      recentsLimit: 28,
                      noRecents: Text(
                        'No Recent',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      loadingIndicator: SizedBox.shrink(),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
