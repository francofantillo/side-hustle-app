import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class NotificationsItem extends StatelessWidget {
  final String? image, name, message, time;

  const NotificationsItem(
      {super.key, this.image, this.name, this.message, this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: AppDimensions.rootPadding,
                    right: AppDimensions.rootPadding,
                    top: AppDimensions.rootPadding),
                child: CircularCacheImageWidget(
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
                                text: message ?? "",
                                maxLines: 2,
                                fontSize: AppDimensions.textSizeVerySmall)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: EdgeInsets.only(
                  left: 2, right: AppDimensions.rootPadding, top: 2),
              child: textWidget(
                  text: time ?? "",
                  fontSize: AppDimensions.textSize10)),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: AppDimensions.rootPadding,
              right: AppDimensions.rootPadding,
          ),
          child: Divider(),
        )

      ],
    );
  }
}
