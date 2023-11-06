import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class HomeLocationWidget extends StatelessWidget {
  const HomeLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Stack(
        children: [
          const IconButtonWithBackground(
            iconPath: AssetsPath.location,
            borderRadius: 30,
            height: 28,
            width: 28,
            backgroundColor: AppColors.primaryColor,
            iconColor: AppColors.whiteColor,
          ),
          Positioned(
            left: 0.078.sw,
            top: 0.010.sh,
            child: Container(
              width: .80.sw,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding:
                const EdgeInsets.only(left: 8.0, top: 2.5, bottom: 2.5, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: textWidget(
                          text: AppStrings.locationText,
                          color: AppColors.textWhiteColor,
                          fontSize: AppDimensions.textSizePerHead),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
