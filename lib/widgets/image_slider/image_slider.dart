import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/image_slider/camera_button.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  final List<String>? itemImages;

  const ImageSlider({super.key, this.itemImages});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return bodyContent();
  }

  bodyContent() {
    return SizedBox(
      height: AppDimensions.productImageSliderHeight,
      width: AppDimensions.productImageSliderWidth,
      child: Column(
        children: [
          pageViewWidget(),
          height(0.01.sh),
          dotIndicatorWidget(),
        ],
      ),
    );
  }

  Widget pageViewWidget() {
    return Expanded(
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: pageController,
          itemCount: widget.itemImages?.length ?? 3,
          itemBuilder: (context, index) {
            return pageViewChild(index);
          }),
    );
  }

  dotIndicatorWidget() {
    return Card(
      elevation: 2,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
      ),
      child: SmoothPageIndicator(
        controller: pageController,
        count: widget.itemImages?.length ?? 3,
        effect: const ExpandingDotsEffect(
          dotHeight: 4,
          dotWidth: 7,
          activeDotColor: AppColors.primaryColor,
          dotColor: Color(0xFFA5A5A5),
        ),
      ),
    );
  }

  pageViewChild(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Stack(
          children: [
            RoundedCornersImage(
              imageHeight: AppDimensions.productImageSliderHeight,
              imageWidth: AppDimensions.productImageSliderWidth,
              assetImage: widget.itemImages?[index] ?? AssetsPath.carpenter,
              // image: AssetsPath.carpenterProfile,
              boarderColor: Colors.white,
            ),
            index == 0
                // ? Positioned(
                //     left: AppDimensions.productImageSliderWidth - 0.26.sw,
                //     top: AppDimensions.productImageSliderHeight - 0.23.sw,
                //     child: Container(
                //         height: 0.12.sw,
                //         width: 0.12.sw,
                //         padding: const EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           shape: BoxShape.rectangle,
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         child: Image.asset(
                //           AssetsPath.camera,
                //           height: 2,
                //           width: 2,
                //           scale: .1,
                //         )))
                ? Positioned(
                    left: AppDimensions.productImageSliderWidth - 0.26.sw,
                    top: AppDimensions.productImageSliderHeight - 0.23.sw,
                    // child: IconButtonWithBackground(
                    //   onTap: () {
                    //     print("Clicked");
                    //   },
                    //   iconPath: AssetsPath.camera,
                    //   height: 0.12.sw,
                    //   width: 0.12.sw,
                    //   backgroundColor: AppColors.whiteColor,
                    //   iconColor: AppColors.primaryColor,
                    // ),
                    child: CameraButton(
                      onTap: () {
                        print("Clicked");
                      },
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
      ),
    );
  }
}
