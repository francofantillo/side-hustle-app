import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/custom_text_field_chat.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class ChatOneToOne extends StatefulWidget {
  const ChatOneToOne({super.key});

  @override
  State<ChatOneToOne> createState() => _ChatOneToOneState();
}

class _ChatOneToOneState extends State<ChatOneToOne> {
  double BUBBLE_RADIUS = 16;

  Duration duration = new Duration();
  Duration position = new Duration();
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

  void _changeSeek(double value) {
    // setState(() {
    //   audioPlayer.seek(new Duration(seconds: value.toInt()));
    // });
  }

  void _playAudio() async {
    //   final url =
    //       'https://file-examples.com/storage/fef1706276640fa2f99a5a4/2017/11/file_example_MP3_700KB.mp3';
    //   if (isPause) {
    //     await audioPlayer.resume();
    //     setState(() {
    //       isPlaying = true;
    //       isPause = false;
    //     });
    //   } else if (isPlaying) {
    //     await audioPlayer.pause();
    //     setState(() {
    //       isPlaying = false;
    //       isPause = true;
    //     });
    //   } else {
    //     setState(() {
    //       isLoading = true;
    //     });
    //     await audioPlayer.play(UrlSource(url));
    //     setState(() {
    //       isPlaying = true;
    //     });
    //   }
    //
    //   audioPlayer.onDurationChanged.listen((Duration d) {
    //     setState(() {
    //       duration = d;
    //       isLoading = false;
    //     });
    //   });
    //   audioPlayer.onPositionChanged.listen((Duration p) {
    //     setState(() {
    //       position = p;
    //     });
    //   });
    //   audioPlayer.onPlayerComplete.listen((event) {
    //     setState(() {
    //       isPlaying = false;
    //       duration = new Duration();
    //       position = new Duration();
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return BackgroundWidget(
      backgroundColor: Colors.white.withOpacity(0.01),
      showAppBar: true,
      appBarTitle: AppStrings.chatUserName,
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
              onPressed: () {},
            ),
          ),
        )
      ],
      body: Material(
        elevation: 6,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                  ),*/
                  height(0.02.sh),
                  DateChip(
                    date: now,
                    color: Color(0xFFE8E8EE),
                  ),
                  BubbleNormal(
                    text: "${AppStrings.messageReceiveOne}\n\n03:00",
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
                  // DateChip(
                  //   date: new DateTime(now.year, now.month, now.day - 2),
                  // ),
                  // DateChip(
                  //   date: now,
                  // ),
                ],
              ),
            ),
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                        height: .08.sh,
                        width: .13.sw,
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
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
