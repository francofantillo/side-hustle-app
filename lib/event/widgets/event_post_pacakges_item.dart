import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class EventPostPackagesItem extends StatelessWidget {
  final String? packageType;
  final double? packagePrice;
  final bool defaultPackage;
  final ValueChanged<bool?> onChanged;

  const EventPostPackagesItem(
      {super.key,
      this.packageType,
      this.packagePrice,
      required this.defaultPackage,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    print("widget.defaultCard : $defaultPackage ");
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textWidget(
                text: "\$${packagePrice?.toStringAsFixed(2) ?? ""}",
                color: AppColors.textBlackColor,
                fontFamily: AppFont.gilroyBold,
                fontSize: AppDimensions.textSizeNormal,
                fontWeight: FontWeight.bold),
            width(0.03.sw),
            Expanded(
              child: textWidget(
                  text: packageType ?? "",
                  color: AppColors.textBlackColor,
                  fontFamily: AppFont.gilroyBold,
                  fontSize: AppDimensions.textSizeNormal,
                  fontWeight: FontWeight.bold),
            ),
            // const Spacer(),
            Radio(value: defaultPackage, groupValue: true, onChanged: onChanged)
          ],
        ),
      ),
    );
  }
}
