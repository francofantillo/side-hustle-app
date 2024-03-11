import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BannerSliderItem extends StatefulWidget {
  final String? image, assetImage, name, description;
  final double? imageHeight, imageWidth, loadingWidgetSize;
  final Color? boarderColor;

  const BannerSliderItem(
      {super.key,
      this.image,
      this.name,
      this.description,
      this.assetImage,
      this.imageHeight,
      this.imageWidth,
      this.loadingWidgetSize,
      this.boarderColor});

  @override
  State<BannerSliderItem> createState() => _BannerSliderItemState();
}

class _BannerSliderItemState extends State<BannerSliderItem> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          // 'https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg', // Testing Url
          widget.image == null
              ? "https://www.example.com/non_existent_image.jpg"
              : widget.image!,
      imageBuilder: (context, imageProvider) => Stack(
        children: [
          AspectRatio(
            aspectRatio: 21 / 9,
            child: Container(
              // width: imageWidth ?? 0.18.sw, // Set your desired width
              // height: imageHeight ?? 0.18.sw, // Set your desired height
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.bannerRadius)),
                border: Border.all(
                  // color: widget.boarderColor ?? AppColors.whiteColor,
                  color: Colors.transparent,
                  // Change the border color as needed
                  width: 1.8.h, // Use the provided border width
                ),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
              top: 100,
              left: 20,
              child: Material(
                elevation: 8,
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                child: textWidget(
                    text: widget.name != null
                        ? "${widget.name!.length > 40 ? "${widget.name!.substring(0, 40)}.." : widget.name}"
                        : null,
                    color: AppColors.bannerTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFont.gilroyRegular),
              )),
          Positioned(
              top: 123,
              left: 20,
              child: Material(
                elevation: 8,
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                child: textWidget(
                    text: widget.description != null
                        ? "${widget.description!.length > 40 ? "${widget.description!.substring(0, 40)}.." : widget.description}"
                        : null,
                    color: AppColors.bannerTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.gilroyRegular),
              )),
        ],
      ),
      placeholder: (context, url) {
        isLoading = true;
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: AspectRatio(
            aspectRatio: 21 / 9,
            child: Container(
              // width: imageWidth ?? 0.18.sw, // Set your desired width
              // height: imageHeight ?? 0.18.sw, // Set your desired height
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.bannerRadius)),
                border: Border.all(
                  color: widget.boarderColor ?? AppColors.whiteColor,
                  // Change the border color as needed
                  width: 1.8.h, // Use the provided border width
                ),
                image: const DecorationImage(
                    image: AssetImage(AssetsPath.plumber), fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Stack(
          children: [
            AspectRatio(
              aspectRatio: 21 / 9,
              child: Container(
                // width: imageWidth ?? 0.18.sw, // Set your desired width
                // height: imageHeight ?? 0.18.sw, // Set your desired height
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppDimensions.bannerRadius)),
                    border: Border.all(
                      color: widget.boarderColor ?? AppColors.whiteColor,
                      // Change the border color as needed
                      width: 0.h, // Use the provided border width
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                            widget.assetImage ?? AssetsPath.imageLoadError),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
                top: 100,
                left: 20,
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: textWidget(
                      // text: "70% Discount",
                      text: widget.name != null
                          ? "${widget.name!.length > 40 ? "${widget.name!.substring(0, 40)}.." : widget.name}"
                          : null,
                      color: AppColors.bannerTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFont.gilroyRegular),
                )),
            Positioned(
                top: 123,
                left: 20,
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: textWidget(
                      // text: "on all Products",
                      text: widget.description != null
                          ? "${widget.description!.length > 40 ? "${widget.description!.substring(0, 40)}.." : widget.description}"
                          : null,
                      color: AppColors.bannerTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.gilroyRegular),
                )),
          ],
        );
      },
    );
  }
}
