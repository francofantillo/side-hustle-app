import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/image_slider/camera_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  final List<File>? fileImages;
  final List<Images>? responseImages;
  final int? indicatorLength;
  final bool hideCameraIcon;
  final Function()? onTap;

  const ImageSlider(
      {super.key,
      this.fileImages,
      this.responseImages,
      this.indicatorLength,
      this.onTap,
      this.hideCameraIcon = false});

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
      height: AppDimensions.productImageSliderHeight - 10,
      width: AppDimensions.productImageSliderWidth,
      child: Column(
        children: [
          pageViewWidget(),
          // height(0.01.sw),
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
              : widget.fileImages?.length ?? 1,
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
    return widget.indicatorLength == null
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
              // count: widget.responseImages != null
              //     ? widget.responseImages!.length
              //     : widget.fileImages?.length ?? 1,
              count: widget.indicatorLength!,
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
    print("responseImages: ${widget.responseImages?[index].image}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Stack(
          // fit: StackFit.expand,
          children: [
            ImageSliderItem(
              imageHeight: AppDimensions.productImageSliderHeight,
              imageWidth: AppDimensions.productImageSliderWidth,
              fileImage: widget.fileImages?[index],
              image: widget.responseImages?[index].image,
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
      ),
    );
  }
}
