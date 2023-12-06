import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/widgets/rating_dialogue_text_field.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
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
        height(0.01.sw),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: textWidget(
                text: AppStrings.brandonLubin,
                color: AppColors.textBlackColor,
                fontSize: AppDimensions.textSizeNormal,
                fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: textWidget(
              text: AppStrings.carpenter,
              color: AppColors.textBlackColor,
              fontSize: AppDimensions.textSizeSmall),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: textWidget(
                text: AppStrings.howIsYourService,
                color: AppColors.textBlackColor,
                fontFamily: AppFont.gilroyBold,
                fontSize: 24.sp,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: textWidget(
                text: AppStrings.howIsYourServiceHint,
                fontFamily: AppFont.gilroyMedium,
                fontSize: AppDimensions.textSizeNormal,
                fontWeight: FontWeight.w400,
                maxLines: 2,
                textAlign: TextAlign.center),
          ),
        ),
        // height(0.13.sw),
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
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        //   child: RatingTextFormField(
        //       hintText: AppStrings.additionalComments,
        //     // keyboardType: TextInputType.numberWithOptions(signed: false),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
          child: RatingTextFormField(
            isShowBoarder: false,
            height: 100.w,
            hintText: AppStrings.additionalComments,
            fillColor: AppColors.ratingTextFieldColor,
            // maxLines: 3,
          ),
      /*    child:    Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(AppDimensions.textFieldBorderRadius),
                color: AppColors.fieldsOutlineColor,
              // border: Border.all(color: AppColors.fieldsOutlineColor, width: 0,),
                // border: Border.all(color: AppColors.fieldsOutlineColor),
            ),
            child: Card(
              elevation: AppDimensions.defaultUnFocusedTextFieldElevation,
              // shadowColor: Colors.grey.withOpacity(0.35), // Lighten shadow color
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,

                  hintText: AppStrings.additionalComments,
                  // fillColor: AppColors.ratingTextFieldColor,
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 8),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                      fontSize: AppDimensions.textSizeSmall,
                      fontFamily: AppFont.gilroyMedium),
                  // hintText: ,
                  hintStyle: const TextStyle(
                    color: AppColors.hintTextFieldColor, fontSize: 15,),
                  errorMaxLines: 3,
                  suffixIconConstraints:
                  BoxConstraints.loose(const Size.fromRadius(76)),
                  prefixIconConstraints:
                  BoxConstraints.loose(const Size.fromRadius(76)),
                ),
              ),
            ),
          ),*/
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 12),
          child: CustomMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              }, name: AppStrings.submitReview, fontSize: AppDimensions.textSizeSmall, borderRadius: 18),
        ),
      ],
    );
  }
}
