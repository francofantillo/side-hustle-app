import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ChatAllUsersItem extends StatelessWidget {
  final String? image, name, message, time;

  const ChatAllUsersItem(
      {super.key, this.image, this.name, this.message, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: AppDimensions.rootPadding,
                right: AppDimensions.rootPadding,
                top: AppDimensions.rootPadding),
            child: image == null
                ? Container(
                    width: 60.h, // Set your desired width
                    height: 60.h, // Set your desired height
                    decoration: const BoxDecoration(
                      color: AppColors.chatNameImageBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: textWidget(
                          text: name != null ? name!.characters.first : "",
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.textSizeNormal),
                    ),
                  )
                : CircularCacheImageWidget(
                    image: image,
                    showLoading: true,
                  )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: AppDimensions.rootPadding,
                      right: AppDimensions.rootPadding,
                      top: AppDimensions.rootPadding),
                  child: textWidget(
                      text: name ?? "",
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeVerySmall,
                      fontFamily: AppFont.gilroySemiBold,
                      fontWeight: FontWeight.w500)),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: AppDimensions.rootPadding,
                            right: AppDimensions.rootPadding,
                            top: 2),
                        child: textWidget(
                            text: message ?? "",
                            fontSize: AppDimensions.textSize10)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 2, right: AppDimensions.rootPadding, top: 2),
                      child: textWidget(
                          text: time ?? "",
                          fontSize: AppDimensions.textSizeTiny)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
