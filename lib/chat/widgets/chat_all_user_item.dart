import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ChatAllUsersItem extends StatelessWidget {
  const ChatAllUsersItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.rootPadding,
                right: AppDimensions.rootPadding,
                top: AppDimensions.rootPadding),
            child: const CircularCacheImageWidget(
              showLoading: false,
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
                      text: AppStrings.talanCalzoniChat,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeNormal,
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
                            text: AppStrings.chatUserHint,
                            fontSize: AppDimensions.textSizeVerySmall)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 2,
                          right: AppDimensions.rootPadding,
                          top: 2),
                      child: textWidget(
                          text: AppStrings.chatUserTime,
                          fontSize: AppDimensions.textSizeVerySmall)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
