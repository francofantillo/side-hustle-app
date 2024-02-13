import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/widgets/rating_dialogue_text_field.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class RateAndReviewDialogue extends StatefulWidget {
  final int index;

  const RateAndReviewDialogue({super.key, this.index = 0});

  @override
  State<RateAndReviewDialogue> createState() => _RateAndReviewDialogueState();
}

class _RateAndReviewDialogueState extends State<RateAndReviewDialogue> {
  late final JobsCubit _bloc;
  double userRating = 4;
  final TextEditingController additionalComments = TextEditingController();

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    userRating = 4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
      return Wrap(
        children: [
          height(0.01.sw),
          Center(
            child: CircularCacheImageWidget(
              showLoading: true,
              assetImage: AssetsPath.placeHolder,
              image: state.myJobsModel?.myJobs?[widget.index].userDetail?.image,
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
                  text:
                      state.myJobsModel?.myJobs?[widget.index].userDetail?.name,
                  color: AppColors.textBlackColor,
                  fontSize: AppDimensions.textSizeNormal,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: textWidget(
                text: state.myJobsModel?.myJobs?[widget.index].title,
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
                userRating = rating;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
            child: RatingTextFormField(
              controller: additionalComments,
              isShowBoarder: false,
              height: 100.w,
              hintText: AppStrings.additionalComments,
              fillColor: AppColors.ratingTextFieldColor,
              // maxLines: 3,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 12),
            child: CustomMaterialButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus!.unfocus();
                  await _bloc.reviewCubit(
                      context: context,
                      mounted: mounted,
                      taskerId: state.myJobsModel?.myJobs?[widget.index]
                          .userDetail?.userid,
                      rating: userRating,
                      review: additionalComments.text);
                },
                name: AppStrings.submitReview,
                fontSize: AppDimensions.textSizeSmall,
                borderRadius: 18),
          ),
        ],
      );
    });
  }
}
