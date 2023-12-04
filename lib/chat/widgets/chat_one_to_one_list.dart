import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/order_product_item.dart';
import 'package:side_hustle/chat/widgets/order_service_item.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ChatOneToOneUsersList extends StatefulWidget {
  final List? itemList;
  final bool isOrderChat, isOrderService;

  const ChatOneToOneUsersList(
      {super.key,
      this.itemList,
      this.isOrderChat = false,
      this.isOrderService = false});

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

  Widget orderServiceWidget(
      {String? image,
      String? name,
      String? subTitle,
      String? price,
      String? serviceDate,
      String? serviceTime,
      String? location,
      String? messageTime}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 1.sw,
        // height: 0.53.sh,
        // height: 0.86.sw,
        // height: 0.76.sw,
        // height: 0.86.sw,
        // height: 310.w,
        constraints: BoxConstraints(maxWidth: .95.sw),
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Card(
          shadowColor: Colors.transparent,
          color: AppColors.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(4)),
          ),
          child: Wrap(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 8),
                child: OrderServiceItemWidget(
                  imageHeight: AppDimensions.productOrderWidgetHeight,
                  imageWidth: 1.sw,
                  imagePath: image,
                  serviceDate: serviceDate,
                  serviceTime: serviceTime,
                  title: name,
                  subTitle: subTitle,
                  price: price,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 8.0, bottom: 8),
                child: textWidget(
                    maxLines: 4,
                    text: AppStrings.orderMessageService,
                    fontSize: AppDimensions.textSizeVerySmall,
                    color: AppColors.textWhiteColor),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 8.0, bottom: 8, top: 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.whiteColor,
                    ),
                    Expanded(
                      child: textWidget(
                          maxLines: 2,
                          text: location,
                          fontSize: AppDimensions.textSizeVerySmall,
                          color: AppColors.textWhiteColor),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 8),
                  child: textWidget(
                      text: messageTime,
                      fontSize: AppDimensions.textSizeChatMessageTime,
                      color: AppColors.textWhiteColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget orderProductWidget(
      {String? image,
      String? name,
      String? subTitle,
      String? price,
      String? deliveryType,
      int? productsQuantity,
      String? location,
      String? messageTime}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 1.sw,
        // height: 0.67.sw,
        // height: 0.79.sw,
        // height: 0.77.sw,
        constraints: BoxConstraints(maxWidth: .95.sw),
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Card(
          shadowColor: Colors.transparent,
          color: AppColors.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(4)),
          ),
          child: Wrap(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 8),
                child: OrderProductItemWidget(
                  // imageHeight: 0.21.sh,
                  productsQuantity: productsQuantity ?? 1,
                  imageHeight: AppDimensions.productOrderWidgetHeight,
                  imageWidth: 1.sw,
                  imagePath: image,
                  title: name,
                  subTitle: subTitle,
                  deliveryType: deliveryType,
                  price: price,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 8.0, bottom: 8),
                child: textWidget(
                    maxLines: 4,
                    text: AppStrings.orderMessageChatTextProduct,
                    fontSize: AppDimensions.textSizeVerySmall,
                    color: AppColors.textWhiteColor),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 8.0, bottom: 8, top: 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.whiteColor,
                    ),
                    Expanded(
                      child: textWidget(
                          maxLines: 2,
                          text: location,
                          fontSize: AppDimensions.textSizeVerySmall,
                          color: AppColors.textWhiteColor),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 8),
                  child: textWidget(
                      text: messageTime,
                      fontSize: AppDimensions.textSizeChatMessageTime,
                      color: AppColors.textWhiteColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getDirectionToMyLocation() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 5, right: 8),
        child: CustomMaterialButton(
            width: 20.w,
            height: 8,
            fontSize: AppDimensions.textSizeSmall,
            onPressed: () {},
            color: AppColors.greenColor,
            name: AppStrings.getDirectionToMyLocation,
            borderRadius: 12),
      ),
    );
  }

  Widget receiverWidget({String? message, String? time, double? bottomWidth}) {
    return Container(
      constraints: BoxConstraints(maxWidth: .85.sw),
      child: Padding(
        padding: EdgeInsets.only(left: 8.0, bottom: bottomWidth ?? 10),
        child: Card(
          shadowColor: Colors.transparent,
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight:
                    Radius.circular(AppDimensions.listItemImageRoundedBorder),
                bottomRight:
                    Radius.circular(AppDimensions.listItemImageRoundedBorder),
                bottomLeft:
                    Radius.circular(AppDimensions.listItemImageRoundedBorder)),
          ),
          child: Material(
            shadowColor: Colors.transparent,
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(AppDimensions.listItemImageRoundedBorder),
                  bottomRight:
                      Radius.circular(AppDimensions.listItemImageRoundedBorder),
                  bottomLeft: Radius.circular(
                      AppDimensions.listItemImageRoundedBorder)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BubbleNormal(
                  // text: AppStrings.messageReceiveOne,
                  text: message ?? "",
                  isSender: false,
                  // color: Color(0xFF1B97F3),
                  color: Colors.white,
                  tail: true,
                  textStyle: TextStyle(
                    fontSize: AppDimensions.textSizeSmall,
                    color: AppColors.textGreyColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: textWidget(
                      // text: "03:00",
                      text: time ?? "",
                      fontSize: AppDimensions.textSize10,
                      color: AppColors.appTextBlackColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget senderWidget({String? message, String? time}) {
    return Align(
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
                  topRight:
                      Radius.circular(AppDimensions.listItemImageRoundedBorder),
                  topLeft:
                      Radius.circular(AppDimensions.listItemImageRoundedBorder),
                  bottomLeft: Radius.circular(
                      AppDimensions.listItemImageRoundedBorder)),
            ),
            child: Material(
              shadowColor: Colors.transparent,
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
                    text: message ?? "",
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
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                    child: textWidget(
                        text: time ?? "",
                        fontSize: AppDimensions.textSize10,
                        color: AppColors.whiteColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        itemCount: 1,
        itemBuilder: (context, index) {
          final timeSpacing =
              addTimeSpacing(textLength: AppStrings.messageReceiveOne.length);
          return widget.isOrderChat
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: DateChip(
                        date: now,
                        color: const Color(0xFFE8E8EE),
                      ),
                    ),
                    widget.isOrderService
                        ? orderServiceWidget(
                            image: AssetsPath.plumber,
                            name: AppStrings.plumber,
                            subTitle: AppStrings.jobDescText,
                            price: AppStrings.productPricingNumeric,
                            serviceDate: "25-Sep-2023",
                            serviceTime: "10:00am to 5:00pm",
                            location: AppStrings.locationText,
                            messageTime: "03:00PM")
                        : orderProductWidget(
                            image: AssetsPath.watch,
                            name: AppStrings.watch,
                            productsQuantity: 4,
                            deliveryType: AppStrings.deliveryOptionCOD,
                            subTitle: AppStrings.jobDescText,
                            location: AppStrings.locationText,
                            price: AppStrings.productPricingNumeric,
                            messageTime: "03:00PM"),
                    widget.isOrderService
                        ? getDirectionToMyLocation()
                        : const SizedBox.shrink(),
                    receiverWidget(
                        message: widget.isOrderService
                            ? AppStrings.orderMessageChatTextService
                            : AppStrings.orderMessageChatTextProduct,
                        time: "03:12PM",
                        bottomWidth: 2),
                    // height(0.02.sh),
                  ],
                )
              : Column(
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
                    Center(
                      child: DateChip(
                        date: now,
                        color: Color(0xFFE8E8EE),
                      ),
                    ),
                    // I need to add timeStamp in next line after the end of the last letter of first line
                    // How to place text at end of last word in String then brake the line and place the text at end of the above line in new line
                    /*Container(
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
                                padding: const EdgeInsets.only(
                                    right: 8.0, bottom: 8),
                                child: textWidget(
                                    text: "03:00",
                                    fontSize: AppDimensions.textSizePerHead,
                                    color: AppColors.chatMessageTimeColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),*/
                    receiverWidget(
                        message: AppStrings.messageReceiveOne,
                        time: "03:00PM",
                        bottomWidth: 2),
                    senderWidget(
                        message: AppStrings.messageReceiveOne, time: "03:10PM"),
                    receiverWidget(
                        message: AppStrings.messageReceiveTwo,
                        time: "03:12PM",
                        bottomWidth: 2),
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
