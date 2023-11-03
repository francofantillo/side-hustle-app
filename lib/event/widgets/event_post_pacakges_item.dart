import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
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
          color: AppColors.itemBGColor,
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
                fontWeight: FontWeight.w500),
            width(0.03.sw),
            Expanded(
              child: textWidget(
                  text: packageType ?? "",
                  color: AppColors.textBlackColor,
                  fontWeight: FontWeight.w500),
            ),
            // const Spacer(),
            Radio(value: defaultPackage, groupValue: true, onChanged: onChanged)
          ],
        ),
      ),
    );
  }
}
