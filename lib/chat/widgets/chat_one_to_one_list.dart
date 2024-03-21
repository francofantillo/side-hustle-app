import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:side_hustle/chat/chat_send_widgets/receiver_widget.dart';
import 'package:side_hustle/chat/chat_send_widgets/sender_widget.dart';
import 'package:side_hustle/chat/order_detail.dart';
import 'package:side_hustle/chat/widgets/order_product_item.dart';
import 'package:side_hustle/chat/widgets/order_service_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/state_management/models/chat_messages_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:intl/src/intl/date_format.dart';

class ChatOneToOneUsersList extends StatefulWidget {
  final List? itemList;
  final bool isOrderChat, isOrderService;
  final int? modelId;

  const ChatOneToOneUsersList(
      {super.key,
      this.itemList,
      this.isOrderChat = false,
      this.modelId,
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
      int? orderId,
      String? subTitle,
      String? price,
      String? deliveryType,
      String? message,
      int? productsQuantity,
      String? location,
      String? messageTime}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 1.sw,
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
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.orderDetailScreenRoute,
                        arguments: OrderDetail(
                          orderId: widget.modelId,
                        ));
                  },
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
                    // text: AppStrings.orderMessageChatTextProduct,
                    text: message,
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

  Widget getDirectionToMyLocation(
      {double? lat, double? lng, String? shopName}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 5, right: 8),
        child: CustomMaterialButton(
            width: 20.w,
            height: 8,
            fontSize: AppDimensions.textSizeSmall,
            onPressed: () async {
              await AppUtils.launchMap(lng: lng, lat: lat, shopName: shopName);
            },
            color: AppColors.greenColor,
            name: AppStrings.getDirectionToMyLocation,
            borderRadius: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      return messagesList(
          itemList: state.chatMessagesModel?.messagesData?.messages,
          currentUserId: state.userModel?.data?.id);
    });
  }

  Widget messagesList(
      {List<ChatMessages>? itemList, required int? currentUserId}) {
    // final now = DateTime.now();
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        // reverse: true,
        reverse: false,
        scrollDirection: Axis.vertical,
        itemCount: itemList?.length ?? 0,
        itemBuilder: (context, index) {
          // final timeSpacing =
          //     addTimeSpacing(textLength: AppStrings.messageReceiveOne.length);

          // print(
          //     "currentUserId: $currentUserId, senderId: ${itemList?[index].senderId} receiverId: ${itemList?[index].receiverId}");

          print("createdAt: ${itemList?[index].createdAt}");

          String? createdAt = itemList?[index].createdAt;

          if(createdAt != null) {
            // String dateTimeString = "2024-03-14 07:45:53";
            String dateTimeString = createdAt;
            dateTimeString = dateTimeString.replaceFirst(' ', 'T');
            print("dateTimeString: $dateTimeString"); // Output: 2024-03-14T07:45:53
            createdAt = dateTimeString;
          }


          final time = DateTimeConversions.convertTo12HourFormatChat(
              timestamp: createdAt ?? itemList?[index].createdAt);

          if (itemList?[index].productType != null) {
            print("productType: ${itemList?[index].productType}");
            if (itemList?[index].productType == OrderTypeEnum.Product.name) {
              print("OrderTypeEnum: ${itemList?[index].productType}");

              return itemList?[index].deliveryType ==
                      DeliveryTypeEnum.Pickup.name
                  ? orderProductWidget(
                      message: itemList?[index].message,
                      image: itemList?[index].image,
                      name: itemList?[index].name,
                      subTitle: itemList?[index].description,
                      deliveryType: itemList?[index].deliveryType,
                      productsQuantity: itemList?[index].productCount != null
                          ? int.parse(itemList![index].productCount!)
                          : null,
                      location: itemList?[index].location,
                      messageTime: time)
                  : Column(
                      children: [
                        orderProductWidget(
                            message: itemList?[index].message,
                            image: itemList?[index].image,
                            name: itemList?[index].name,
                            subTitle: itemList?[index].description,
                            deliveryType: itemList?[index].deliveryType,
                            productsQuantity:
                                itemList?[index].productCount != null
                                    ? int.parse(itemList![index].productCount!)
                                    : null,
                            location: itemList?[index].location,
                            messageTime: time),
                        getDirectionToMyLocation(
                            lat: itemList?[index].lat != null
                                ? double.parse(itemList![index].lat!)
                                : null,
                            lng: itemList?[index].lng != null
                                ? double.parse(itemList![index].lng!)
                                : null,
                            shopName: itemList?[index].shopName)
                      ],
                    );
            } else if (itemList?[index].productType ==
                OrderTypeEnum.Service.name) {
              print("OrderTypeEnum: ${itemList?[index].productType}");
              return int.parse(itemList?[index].productCount ?? "0") > 1
                  ? Column(
                      children: [
                        orderProductWidget(
                            image: itemList?[index].image,
                            name: itemList?[index].name,
                            subTitle: itemList?[index].description,
                            productsQuantity:
                                itemList?[index].productCount != null
                                    ? int.parse(itemList![index].productCount!)
                                    : null,
                            orderId: itemList?[index].id,
                            deliveryType: itemList?[index].deliveryType,
                            location: itemList?[index].location,
                            messageTime: time),
                        getDirectionToMyLocation(
                            lat: itemList?[index].lat != null
                                ? double.parse(itemList![index].lat!)
                                : null,
                            lng: itemList?[index].lng != null
                                ? double.parse(itemList![index].lng!)
                                : null,
                            shopName: itemList?[index].shopName)
                      ],
                    )
                  : Column(
                      children: [
                        orderServiceWidget(
                            image: itemList?[index].image,
                            name: itemList?[index].name,
                            subTitle: itemList?[index].description,
                            serviceDate: itemList?[index].serviceDate,
                            serviceTime: "service time needed",
                            location: itemList?[index].location,
                            messageTime: time),
                        getDirectionToMyLocation(
                            lat: itemList?[index].lat != null
                                ? double.parse(itemList![index].lat!)
                                : null,
                            lng: itemList?[index].lng != null
                                ? double.parse(itemList![index].lng!)
                                : null,
                            shopName: itemList?[index].shopName)
                      ],
                    );
            }
          } else if (itemList?[index].senderId == currentUserId) {
            if (itemList?[index].messageType == 2) {
              return BubbleNormalImage(
                // id: 'id001',
                id: itemList?[index].id?.toString() ?? 'id001',
                image: _image(image: itemList?[index].filePath),
                isSender: true,
                // color: AppColors.primaryColor,
                color: Colors.transparent,
                tail: false,
              );
            } else if (itemList?[index].messageType == 1) {
              return SenderWidget(
                message: itemList?[index].message,
                time: time,
              );
            }
          } else {
            if (itemList?[index].messageType == 2) {
              return BubbleNormalImage(
                // id: 'id001',
                id: itemList?[index].id?.toString() ?? 'id001',
                image: _image(image: itemList?[index].filePath),
                color: Colors.transparent,
                isSender: false,
                tail: false,
              );
            } else if (itemList?[index].messageType == 1) {
              return ReceiverWidget(
                  message: itemList?[index].message,
                  time: time,
                  bottomWidth: 2);
            }
          }
        },
      ),
    );
  }

  Widget _image({String? image}) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 150.0.w,
        minWidth: 150.0.w,
      ),
      child: CachedNetworkImage(
        // imageUrl: 'https://i.ibb.co/JCyT1kT/Asset-1.png',
        imageUrl: image ?? "https://",
        progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
          height: 10,
          width: 10,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        ),
        // errorWidget: (context, url, error) => const Icon(Icons.error),
        errorWidget: (context, url, error) => Image.asset(
          AssetsPath.imageLoadError,
          fit: BoxFit.cover,
          height: 150.w,
        ),
      ),
    );
  }
}
