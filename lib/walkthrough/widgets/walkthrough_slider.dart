import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/custom_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkthroughSlider extends StatefulWidget {
  final List<ChatAllUsersItemModel>? items;

  const WalkthroughSlider({super.key, this.items});

  @override
  State<WalkthroughSlider> createState() => _WalkthroughSliderState();
}

class _WalkthroughSliderState extends State<WalkthroughSlider> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return bodyContent();
  }

  bodyContent() {
    return SizedBox(
      height: AppDimensions.walkthroughImageSliderHeight,
      width: AppDimensions.walkthroughImageSliderWidth,
      child: Column(
        children: [
          // currentIndex == 2
          // ? const Padding(
          //   padding: EdgeInsets.all(20))
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Material(
                elevation: 2,
                color: const Color(0xFFB5B5B5),
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        AppRoutes.bottomTabsScreenRoute, (route) => false);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    child: textWidget(
                        text: AppStrings.skip, color: AppColors.textWhiteColor),
                  ),
                ),
              ),
            ),
          ),
          pageViewWidget(),
          Center(child: dotIndicatorWidget()),
          height(0.03.sh),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: customMaterialButton(
              onPressed: () {
                // pageController.jumpToPage(currentIndex);
                if (currentIndex != 1) {
                  pageController.animateToPage(currentIndex + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut);
                } else {
                  Navigator.pushNamedAndRemoveUntil(context,
                      AppRoutes.bottomTabsScreenRoute, (route) => false);
                }
              },
              borderRadius: 12,
              name: AppStrings.next,
              color: AppColors.primaryColor,
              textColor: AppColors.textWhiteColor,
            ),
          ),
          height(0.02.sh),
        ],
      ),
    );
    // return pageViewWidget();
  }

  Widget pageViewWidget() {
    return Expanded(
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: pageController,
          itemCount: widget.items?.length ?? 0,
          onPageChanged: (index) {
            currentIndex = index;
            setState(() {});
          },
          itemBuilder: (context, index) {
            return pageViewChild(index);
          }),
    );
  }

  Widget dotIndicatorWidget() {
    return Card(
      elevation: 2,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
      ),
      child: SmoothPageIndicator(
        controller: pageController,
        count: widget.items?.length ?? 0,
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
        shadowColor: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircularCacheImageWidget(
            //     assetImage: AssetsPath.logo,
            //     imageHeight: AppDimensions.walkthroughImageHeight,
            //     imageWidth: AppDimensions.walkthroughImageWidth,
            //     showLoading: false),
            Center(
              child: CustomCacheImage(
                showLoading: false,
                imageHeight: AppDimensions.walkthroughSize,
                imageWidth: 1.sw,
                // assetImage: AssetsPath.walkthrough,
                assetImage: widget.items?[index].image,
              ),
            ),
            height(0.05.sh),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: textWidget(
                  // text: AppStrings.postYourSideHustle,
                  text: widget.items?[index].name,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.textHeadingSize,
                  maxLines: 3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: textWidget(
                  // text: AppStrings.walkthroughSubTitle,
                  text: widget.items?[index].message,
                  maxLines: 3),
            ),
          ],
        ),
      ),
    );
  }
}
