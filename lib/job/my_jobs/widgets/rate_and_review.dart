import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class RateAndReviewDialogue extends StatefulWidget {
  const RateAndReviewDialogue({super.key});

  @override
  State<RateAndReviewDialogue> createState() => _RateAndReviewDialogueState();
}

class _RateAndReviewDialogueState extends State<RateAndReviewDialogue> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        height(0.02.sw),
        Center(
          child: CircularCacheImageWidget(
            showLoading: true,
            // image: AlphaAppData.dpProfile,
            assetImage: AssetsPath.brandonProfile,
            boarderColor: AppColors.primaryColor,
            imageHeight: 90.w,
            imageWidth: 90.w,
            borderWidth: .003.sh,
          ),
        ),
        height(0.3.sw),
        Center(
          child: textWidget(
              text: AppStrings.brandonLubin,
              color: AppColors.textBlackColor,
              fontSize: AppDimensions.textSizeNormal,
              fontWeight: FontWeight.bold),
        ),
        height(0.05.sw),
        Center(
          child: textWidget(
              text: AppStrings.carpenter,
              fontSize: AppDimensions.textSizeVerySmall),
        ),
        height(0.07.sw),
        Center(
          child: textWidget(
              text: AppStrings.howIsYourService,
              color: AppColors.textBlackColor,
              fontSize: AppDimensions.textSizeNormal,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold),
        ),
        height(0.07.sw),
        Center(
          child: textWidget(
              text: AppStrings.howIsYourServiceHint,
              fontSize: AppDimensions.textSizeVerySmall,
              maxLines: 2,
              textAlign: TextAlign.center),
        ),
        height(0.13.sw),
        Center(
          child: RatingBar.builder(
            // wrapAlignment: WrapAlignment.start,
            unratedColor: AppColors.unratedColor,
            initialRating: 4,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemSize: 40,
            glow: false,
            itemCount: 5,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              // color: Colors.amber,
              color: AppColors.ratingColor,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        height(0.16.sw),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CustomTextFormField(
            height: .3.sw,
            hintText: AppStrings.additionalComments,
            fillColor: AppColors.ratingTextFieldColor,
            maxLines: 3,
          ),
        ),
        height(0.36.sw),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: CustomMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              }, name: AppStrings.submitReview, fontSize: AppDimensions.textSizeSmall, borderRadius: 18),
        ),
        height(0.2.sw),
      ],
    );
  }
}
