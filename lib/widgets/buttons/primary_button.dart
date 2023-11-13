import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class PrimaryPostButton extends StatelessWidget {
  final String? title;
  final void Function() onPressed;
  const PrimaryPostButton({super.key, this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: .13.sh,
      height: .11.sh,
      // height: 95.h,
      width: 1.sw,
      padding: EdgeInsets.only(
          top: 0.02.sh, bottom: 0.02.sh, right: 0.06.sw, left: 0.06.sw),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppDimensions.bottomButtonBGCurve),
            topLeft: Radius.circular(AppDimensions.bottomButtonBGCurve)),
      ),
      child: MaterialButton(
        minWidth: 1.sw,
        elevation: AppDimensions.defaultButtonElevation,
        // what are the Google Material Design guidelines text field, buttons and appBar elevation
        onPressed: onPressed,
        color: Colors.white,
        textColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(0.023.sh), // Adjust the radius as needed
        ),
        child: Text(
          title ?? "",
          style: const TextStyle(fontSize: 16),
        ),
      ),
      // child: Center(
      //   child: Container(
      //     width: 1.sw,
      //     height: 1.sh,
      //     decoration: BoxDecoration(
      //       color: AppColors.whiteColor,
      //       borderRadius: BorderRadius.all(Radius.circular(AppDimensions.bottomButtonBGCurve)
      //           ),
      //     ),
      //     child: Center(child: textWidget(text: AppStrings.postASideHustle, color: AppColors.primaryColor)),
      //   ),
      // ),
    );
  }
}
