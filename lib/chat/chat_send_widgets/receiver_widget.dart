import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ReceiverWidget extends StatelessWidget {
  final String? message, time;
  final double? bottomWidth;
  const ReceiverWidget({super.key, this.message, this.time, this.bottomWidth});

  @override
  Widget build(BuildContext context) {
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
}
