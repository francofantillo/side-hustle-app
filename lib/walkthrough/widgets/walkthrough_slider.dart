import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkthroughSlider extends StatefulWidget {
  const WalkthroughSlider({super.key});

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
                  onTap: () {},
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
                if (currentIndex != 2) {
                  pageController.animateToPage(currentIndex + 1,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut);
                }
              },
              borderRadius: 12,
              name: currentIndex == 2 ? AppStrings.done : AppStrings.next,
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
          itemCount: 3,
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
        count: 3,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularCacheImageWidget(
                imageHeight: AppDimensions.walkthroughImageHeight,
                imageWidth: AppDimensions.walkthroughImageWidth,
                showLoading: false),
            height(0.05.sh),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: textWidget(
                  text: AppStrings.postYourSideHustle,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.textHeadingSize,
                  maxLines: 3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child:
                  textWidget(text: AppStrings.walkthroughSubTitle, maxLines: 3),
            ),
          ],
        ),
      ),
    );
  }
}
