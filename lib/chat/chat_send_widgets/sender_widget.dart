import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class SenderWidget extends StatelessWidget {
  final String? message, time;

  const SenderWidget({super.key, this.time, this.message});

  @override
  Widget build(BuildContext context) {
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
}
