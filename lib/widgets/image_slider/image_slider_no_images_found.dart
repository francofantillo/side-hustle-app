import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/image_slider/camera_button.dart';

class NoImagesFoundWidget extends StatelessWidget {
  final bool showCameraAttachment;
  final Function()? onTap;

  const NoImagesFoundWidget({super.key, this.showCameraAttachment = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
      ),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 21 / 9,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.homeFirstItemWidgetCurve)),
                  border: Border.all(
                    color: Colors.white,
                    // Change the border color as needed
                    width: 0.h, // Use the provided border width
                  ),
                  image: const DecorationImage(
                      image: AssetImage(AssetsPath.imageLoadError),
                      fit: BoxFit.cover)),
            ),
          ),

          // Positioned(
          //     top: 70.w,
          //     left: 70.w,
          //     child: Center(child: textWidget(text: "Coming Soon", fontSize: 22.sp, color: AppColors.whiteColor))),
          /// Hide Camera Icon login
          showCameraAttachment
              ? Positioned(
                  left: AppDimensions.productImageSliderWidth - 0.24.sw,
                  // top: AppDimensions.productImageSliderHeight - 0.23.sw,
                  top: AppDimensions.productImageSliderHeight - 0.255.sw,
                  child: CameraButton(
                    onTap: onTap,
                    iconPath: AssetsPath.camera,
                    height: 0.12.sw,
                    width: 0.12.sw,
                    backgroundColor: AppColors.whiteColor,
                    iconColor: AppColors.primaryColor,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
