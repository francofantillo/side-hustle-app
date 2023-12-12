import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_one_to_one_list.dart';
import 'package:side_hustle/chat/widgets/chat_options_bottomsheet.dart';
import 'package:side_hustle/chat/widgets/custom_text_field_chat.dart';
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
  final String? userName;

  const ChatOneToOne(
      {super.key,
      this.userName,
      this.isBlockedUser = false,
      this.isOrderChat = false,
      this.isOrderService = false});

  @override
  State<ChatOneToOne> createState() => _ChatOneToOneState();
}

class _ChatOneToOneState extends State<ChatOneToOne> {
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
                    context: context, widget: const ChatOptionsBottomSheet());
                // AppUtils.showBottomModalSheet(context: context, widget: const BottomModalSheetDeliveryAddress());
              },
            ),
          ),
        )
      ],
      body: Material(
        // elevation: AppDimensions.cardElevation,
        elevation: 0,
        child: Column(
          children: [
            ChatOneToOneUsersList(
                isOrderChat: widget.isOrderChat,
                isOrderService: widget.isOrderService),
/*
            Container(
              width: 1.sw,
              height: 100,
              constraints: BoxConstraints(maxWidth: .95.sw),
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: Card(
                color: AppColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OrderItemWidget(
                    imageHeight: 3.sh,
                    imageWidth: 3.sh,
                  )
                ),
              ),
            ),
*/
            // Container(height: 100,
            // decoration: BoxDecoration(
            //   color: Colors.red,
            //
            // ),
            // ),
            /*SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  */
            /*    BubbleNormalImage(
                    id: 'id001',
                    image: _image(),
                    color: Colors.purpleAccent,
                    tail: true,
                    delivered: true,
                  ),
                  BubbleNormalAudio(
                    color: Color(0xFFE8E8EE),
                    duration: duration.inSeconds.toDouble(),
                    position: position.inSeconds.toDouble(),
                    isPlaying: isPlaying,
                    isLoading: isLoading,
                    isPause: isPause,
                    onSeekChanged: _changeSeek,
                    onPlayPauseButtonClick: _playAudio,
                    sent: true,
                  ),*/ /*
                  height(0.02.sh),
                  DateChip(
                    date: now,
                    color: Color(0xFFE8E8EE),
                  ),
                  BubbleNormal(
                    text: "${AppStrings.messageReceiveOne}\n${addTimeSpacing(textLength: AppStrings.messageReceiveOne.length)}03:00",
                    isSender: false,
                    // color: Color(0xFF1B97F3),
                    color: Colors.white,
                    tail: true,
                    textStyle: TextStyle(
                      fontSize: AppDimensions.textSizeSmall,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                  BubbleNormal(
                    text: AppStrings.messageReceiveOne,
                    isSender: true,
                    // color: Color(0xFFE8E8EE),
                    color: const Color(0xFF1B97F3),
                    tail: true,
                    // sent: true,
                    textStyle: TextStyle(
                      fontSize: AppDimensions.textSizeSmall,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  BubbleNormal(
                    constraints: BoxConstraints(minWidth: .5.sw, maxWidth: .9.sw),
                    text: AppStrings.messageReceiveTwo,
                    isSender: false,
                    // color: Color(0xFF1B97F3),
                    color: Colors.white,
                    tail: true,
                    textStyle: TextStyle(
                      fontSize: AppDimensions.textSizeSmall,
                      color: AppColors.textBlackColor,
                    ),
                  ),
                  height(0.15.sh),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      bottom: 20,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Color(0xFFE8E8EE),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(AppStrings.unblockUserMessage,
                        ),
                      ),
                    ),
                  ),
                  // DateChip(
                  //   date: new DateTime(now.year, now.month, now.day - 2),
                  // ),
                  // DateChip(
                  //   date: now,
                  // ),
                ],
              ),
            ),*/
            // MessageBar(
            //   onSend: (_) => print(_),
            //   actions: [
            //     Material(
            //       child: InkWell(
            //         child: const Padding(
            //           padding: EdgeInsets.only(right: 8),
            //           child: Icon(
            //             Icons.emoji_emotions_outlined,
            //             color: AppColors.greyColor,
            //             size: 24,
            //           ),
            //         ),
            //         onTap: () {},
            //       ),
            //     ),
            //   ],
            // ),

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
                    height(0.02.sh),
                    Row(
                      children: [
                        const Expanded(
                            child: CustomTextFieldChat(
                          hintText: AppStrings.typeAMessage,
                          // isSuffixIcon: true,
                          // suffixIcon: Icon(Icons.emoji_emotions_outlined),
                          // isPrefixIcon: true,
                          // prefixIconPath: AssetsPath.camera,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          // child: InkWell(
                          //   child: const Icon(
                          //     Icons.send,
                          //     color: AppColors.primaryColor,
                          //     size: 24,
                          //   ),
                          //   onTap: () {},
                          // ),
                          child: IconButtonWithBackground(
                            height: .15.sw,
                            width: .15.sw,
                            // width: .08.sh,
                            borderRadius: 30,
                            iconSize: 18,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                            onTap: () {
                              print("clicked minus");
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
