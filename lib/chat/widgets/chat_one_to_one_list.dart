import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/chat_all_user_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ChatOneToOneUsersList extends StatefulWidget {
  final List? itemList;

  const ChatOneToOneUsersList({super.key, this.itemList});

  @override
  State<ChatOneToOneUsersList> createState() => _ChatOneToOneUsersListState();
}

class _ChatOneToOneUsersListState extends State<ChatOneToOneUsersList> {
  List<bool> isSent = [false, true, false, true, false, true];

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

    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        reverse: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: 1,
        // Replace with your item count
        itemBuilder: (context, index) {
          final timeSpacing =
              addTimeSpacing(textLength: AppStrings.messageReceiveOne.length);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Center(
                child: DateChip(
                  date: now,
                  color: Color(0xFFE8E8EE),
                ),
              ),
              // I need to add timeStamp in next line after the end of the last letter of first line
              // How to place text at end of last word in String then brake the line and place the text at end of the above line in new line
              Container(
                constraints: BoxConstraints(maxWidth: .85.sw),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              AppDimensions.listItemImageRoundedBorder),
                          bottomRight: Radius.circular(
                              AppDimensions.listItemImageRoundedBorder),
                          bottomLeft: Radius.circular(
                              AppDimensions.listItemImageRoundedBorder)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BubbleNormal(
                          text: AppStrings.messageReceiveOne,
                          isSender: false,
                          // color: Color(0xFF1B97F3),
                          color: Colors.white,
                          tail: true,
                          textStyle: TextStyle(
                            fontSize: AppDimensions.textSizeSmall,
                            color: AppColors.textBlackColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                          child: textWidget(
                              text: "03:00",
                              fontSize: AppDimensions.textSizePerHead,
                              color: AppColors.chatMessageTimeColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints(maxWidth: .85.sw),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 10),
                    child: Card(
                      color: const Color(0xFF1B97F3),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                AppDimensions.listItemImageRoundedBorder),
                            topLeft: Radius.circular(
                                AppDimensions.listItemImageRoundedBorder),
                            bottomLeft: Radius.circular(
                                AppDimensions.listItemImageRoundedBorder)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, bottom: 8),
                            child: textWidget(
                                text: "03:10",
                                fontSize: AppDimensions.textSizePerHead,
                                color: AppColors.whiteColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: .85.sw),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              AppDimensions.listItemImageRoundedBorder),
                          bottomRight: Radius.circular(
                              AppDimensions.listItemImageRoundedBorder),
                          bottomLeft: Radius.circular(
                              AppDimensions.listItemImageRoundedBorder)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BubbleNormal(
                          text: AppStrings.messageReceiveOne,
                          isSender: false,
                          // color: Color(0xFF1B97F3),
                          color: Colors.white,
                          tail: true,
                          textStyle: TextStyle(
                            fontSize: AppDimensions.textSizeSmall,
                            color: AppColors.textBlackColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                          child: textWidget(
                              text: "03:00",
                              fontSize: AppDimensions.textSizePerHead,
                              color: AppColors.chatMessageTimeColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // height(0.15.sh),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 7,
              //     bottom: 20,
              //   ),
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(6)),
              //       color: Color(0xFFE8E8EE),
              //     ),
              //     child: const Padding(
              //       padding: EdgeInsets.all(5.0),
              //       child: Text(AppStrings.unblockUserMessage,
              //       ),
              //     ),
              //   ),
              // ),
              // DateChip(
              //   date: new DateTime(now.year, now.month, now.day - 2),
              // ),
              // DateChip(
              //   date: now,
              // ),
            ],
          );

          /// This is the actual chat model

          /**
              return Column(
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
              !isSent[index]
              ? BubbleNormal(
              text: "${AppStrings.messageReceiveOne}\n${addTimeSpacing(textLength: AppStrings.messageReceiveOne.length)}03:00",
              isSender: false,
              // color: Color(0xFF1B97F3),
              color: Colors.white,
              tail: true,
              textStyle: TextStyle(
              fontSize: AppDimensions.textSizeSmall,
              color: AppColors.textBlackColor,
              ),
              )
              :
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
              /*BubbleNormal(
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
              ),*/
              // height(0.15.sh),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 7,
              //     bottom: 20,
              //   ),
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(6)),
              //       color: Color(0xFFE8E8EE),
              //     ),
              //     child: const Padding(
              //       padding: EdgeInsets.all(5.0),
              //       child: Text(AppStrings.unblockUserMessage,
              //       ),
              //     ),
              //   ),
              // ),
              // DateChip(
              //   date: new DateTime(now.year, now.month, now.day - 2),
              // ),
              // DateChip(
              //   date: now,
              // ),
              ],
              );
           */
        },
      ),
    );
  }
}
