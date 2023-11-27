import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BulletedListItem extends StatelessWidget {
  final String text;
  final int? maxLines;

  BulletedListItem({required this.text, this.maxLines});

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   contentPadding: EdgeInsets.zero,
    //   // Remove horizontal padding
    //   leading: Container(
    //     margin: const EdgeInsets.only(left: 8), // Adjust margin as needed
    //     child: const Icon(
    //       Icons.brightness_1,
    //       // size: 12.0,
    //       size: 10.0,
    //       color: AppColors.textBlackColor,
    //     ), // Bullet point
    //   ),
    //   title: textWidget(
    //     text: text,
    //     textAlign: TextAlign.start,
    //   ),
    // );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 8), // Adjust margin as needed
            child: const Icon(
              Icons.brightness_1,
              // size: 12.0,
              size: 5.0,
              color: AppColors.textBlackColor,
            )),
        width(0.02.sw),
        Expanded(
          child: textWidget(
            text: text,
            textAlign: TextAlign.start,
            fontSize: AppDimensions.textSizeVerySmall,
            maxLines: maxLines ?? 1
          ),
        ), // Bullet po// int
      ],
    );
  }
}
