import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class HomeFirstItemWidget extends StatelessWidget {
  final String? image, assetImage, title;
  final Color? boarderColor;

  const HomeFirstItemWidget(
      {super.key, this.image, this.title, this.assetImage, this.boarderColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedCornersImage(
          imageHeight: 0.09.sh,
          imageWidth: 0.09.sh,
          assetImage: assetImage,
          image: image,
          boarderColor: boarderColor,
        ),
        height(5.h),
        Container(
            padding: const EdgeInsets.only(left: 4),
            width: 0.18.sw,
            child: textWidget(
                text: title ?? "", textAlign: TextAlign.start, maxLines: 1))
      ],
    );
  }
}
