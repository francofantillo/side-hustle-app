import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/image_slider/banner_item_alpha.dart';
import 'package:side_hustle/widgets/image_slider/camera_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSliderAlpha extends StatefulWidget {
  final List<String>? itemImages;
  final List<Images>? responseImages;
  final bool hideCameraIcon;
  final Function()? onTap;

  const BannerSliderAlpha(
      {super.key,
      this.itemImages,
      this.responseImages,
      this.onTap,
      this.hideCameraIcon = false});

  @override
  State<BannerSliderAlpha> createState() => _BannerSliderAlphaState();
}

class _BannerSliderAlphaState extends State<BannerSliderAlpha> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return bodyContent();
  }

  bodyContent() {
    return SizedBox(
      height: AppDimensions.productImageSliderHeight - 10,
      width: AppDimensions.productImageSliderWidth,
      child: Column(
        children: [
          pageViewWidget(),
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
          itemCount: widget.responseImages != null
              ? widget.responseImages?.length ?? 0
              : widget.itemImages?.length ?? 3,
          itemBuilder: (context, index) {
            return pageViewChild(index);
          }),
    );
  }

/*  dotIndicatorWidget() {
    return widget.responseImages == null
        ? const SizedBox.shrink()
        : Card(
            elevation: 2,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  AppDimensions.listItemImageRoundedBorder),
            ),
            child: SmoothPageIndicator(
              controller: pageController,
              count: widget.responseImages != null
                  ? widget.responseImages!.length
                  : widget.itemImages?.length ?? 3,
              effect: const ExpandingDotsEffect(
                dotHeight: 4,
                dotWidth: 7,
                activeDotColor: AppColors.primaryColor,
                dotColor: Color(0xFFA5A5A5),
              ),
            ),
          );
  }*/
  dotIndicatorWidget() {
    return Card(
      elevation: 2,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
      ),
      child: widget.responseImages != null
          ? widget.responseImages!.isEmpty
              ? const SizedBox.shrink()
              : SmoothPageIndicator(
                  controller: pageController,
                  count: widget.responseImages!.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 4,
                    dotWidth: 7,
                    activeDotColor: AppColors.primaryColor,
                    dotColor: Color(0xFFA5A5A5),
                  ),
                )
          : SmoothPageIndicator(
              controller: pageController,
              count: widget.responseImages != null
                  ? widget.responseImages!.length
                  : widget.itemImages?.length ?? 3,
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
    return Card(
      elevation: 2,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
      ),
      child: Stack(
        // fit: StackFit.expand,
        children: [
          BannerItemAlpha(
            imageHeight: AppDimensions.productImageSliderHeight,
            imageWidth: AppDimensions.productImageSliderWidth,
            assetImage: widget.responseImages == null
                ? widget.itemImages != null
                    ? widget.itemImages![index]
                    : AssetsPath.carpenterSlider
                : null,
            image: widget.responseImages?[index].image,
            // image: AssetsPath.leoLubinProfile,
            boarderColor: Colors.white,
          ),
          index == 0
              ? widget.hideCameraIcon
                  ? const SizedBox.shrink()
                  : Positioned(
                      left: AppDimensions.productImageSliderWidth - 0.24.sw,
                      // top: AppDimensions.productImageSliderHeight - 0.23.sw,
                      top: AppDimensions.productImageSliderHeight - 0.255.sw,
                      child: CameraButton(
                        onTap: widget.onTap,
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
