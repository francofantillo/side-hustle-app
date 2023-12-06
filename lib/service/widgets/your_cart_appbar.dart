import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class YourCartAppBar extends StatelessWidget {
  final int itemsCount;
  const YourCartAppBar({super.key, this.itemsCount = 1});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: CircularIconButton(
                icon: CustomIcon.cancel,
                width: 40,
                height: 40,
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: AppColors.backIconBackgroundColor)),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textWidget(
                  text: AppStrings.yourCart,
                  fontFamily: AppFont.gilroyBold,
                  fontSize: AppDimensions.textSizeCartText,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlackColor),
              textWidget(text: "$itemsCount${AppStrings.yourCartItems}",
              fontSize: AppDimensions.textSizeSmall,
              fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ],
    );
  }
}
