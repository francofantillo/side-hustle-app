import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/dialogue/apply_for_job_dialogue.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ApplyForJob extends StatefulWidget {
  final int? jobId;

  const ApplyForJob({super.key, this.jobId});

  @override
  State<ApplyForJob> createState() => _ApplyForJobState();
}

class _ApplyForJobState extends State<ApplyForJob> {
  late final JobsCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getJobDetail();
    super.initState();
  }

  getJobDetail() async {
    await _bloc.getJobsDetailCubit(
        context: context, mounted: mounted, jobId: widget.jobId?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.applyForJob,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<JobsCubit, JobsState>(builder: (contextBuilder, state) {
        return state.jobsDetailLoading
            ? const SizedBox.shrink()
            : state.jobsDetailModel?.jobsDetailData == null
                ? const CustomErrorWidget(errorMessage: AppStrings.errorMessage)
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Padding(
                      padding: EdgeInsets.all(AppDimensions.rootPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const ImageSliderAlpha(
                          //   hideCameraIcon: true,
                          // ),
                          state.jobsDetailModel!.jobsDetailData!.images!.isEmpty
                              ? const NoImagesFoundWidget()
                              : ImageSlider(
                                  hideCameraIcon: true,
                                  indicatorLength: state
                                              .jobsDetailModel
                                              ?.jobsDetailData
                                              ?.images
                                              ?.length ==
                                          null
                                      ? null
                                      : state.jobsDetailModel!.jobsDetailData!
                                              .images!.isEmpty
                                          ? null
                                          : state.jobsDetailModel!
                                              .jobsDetailData!.images!.length,
                                  // itemImages: itemImages,
                                  responseImages: state
                                      .jobsDetailModel?.jobsDetailData?.images),
                          height(0.02.sh),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: textWidget(
                                      // text: AppStrings.carpenter,
                                      text: state.jobsDetailModel
                                          ?.jobsDetailData?.title,
                                      fontFamily: AppFont.gilroyBold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimensions
                                          .textHeadingSizeViewForms,
                                      color: AppColors.textBlackColor),
                                ),
                                textWidget(
                                    // text: AppStrings.productPricingNumeric,
                                    text: state.jobsDetailModel?.jobsDetailData
                                                ?.budget !=
                                            null
                                        ? "\$${state.jobsDetailModel?.jobsDetailData?.budget?.toStringAsFixed(2)}"
                                        : "",
                                    fontFamily: AppFont.gilroyBold,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppDimensions.textPriceSizeViewForms,
                                    color: AppColors.textBlackColor),
                              ],
                            ),
                          ),
                          // height(0.02.sh),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ImageIcon(
                                  const AssetImage(AssetsPath.location),
                                  color: const Color(0xFF565656),
                                  size: AppDimensions.applyForJobIconSize,
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      text: state.jobsDetailModel
                                          ?.jobsDetailData?.location,
                                      maxLines: 2,
                                      color: const Color(0xFF565656),
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ImageIcon(
                                  const AssetImage(AssetsPath.calender),
                                  color: const Color(0xFF565656),
                                  size: AppDimensions.applyForJobIconSize,
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      text: state.jobsDetailModel
                                                  ?.jobsDetailData?.jobDate !=
                                              null
                                          ? AppUtils.formatDateView(
                                              selectedDate: DateTime.parse(state
                                                  .jobsDetailModel!
                                                  .jobsDetailData!
                                                  .jobDate!))
                                          : "",
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time_filled_rounded,
                                  color: const Color(0xFF565656),
                                  size: AppDimensions.applyForJobIconSize,
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      // text: AppStrings.jobTimeText,
                                      text:
                                          "Start at ${DateTimeConversions.convertTo12HourFormat(state.jobsDetailModel?.jobsDetailData?.jobTime)} to ${DateTimeConversions.convertTo12HourFormat(state.jobsDetailModel?.jobsDetailData?.endTime)}",
                                      color: const Color(0xFF565656),
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12),
                            child: Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: AppStrings.jobPostBy,
                                maxLines: 1,
                                fontFamily: AppFont.gilroyBold,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms,
                                color: AppColors.textBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes
                                                .otherUserProfileScreenRoute);
                                      },
                                      child: Row(
                                        children: [
                                          CircularCacheImageWidget(
                                            showLoading: false,
                                            // image: AssetsPath.userProfileJob,
                                            image: state
                                                .jobsDetailModel
                                                ?.jobsDetailData
                                                ?.userDetail
                                                ?.image,
                                            assetImage: AssetsPath.placeHolder,
                                            boarderColor:
                                                AppColors.primaryColor,
                                            imageHeight: .1.sw,
                                            imageWidth: .1.sw,
                                          ),
                                          width(.02.sw),
                                          Expanded(
                                            child: textWidget(
                                                text: state
                                                    .jobsDetailModel
                                                    ?.jobsDetailData
                                                    ?.userDetail
                                                    ?.name,
                                                fontFamily:
                                                    AppFont.gilroySemiBold,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    AppColors.textBlackColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IconButtonWithBackground(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.chatOneToOneScreenRoute);
                                  },
                                  iconPath: AssetsPath.message,
                                  height: 0.12.sw,
                                  width: 0.12.sw,
                                  iconSize: 20,
                                  backgroundColor: AppColors.primaryColor,
                                  iconColor: AppColors.whiteColor,
                                )
                              ],
                            ),
                          ),
                          height(0.03.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: AppStrings.jobDesc,
                                maxLines: 1,
                                fontFamily: AppFont.gilroyBold,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms,
                                color: AppColors.textBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          height(0.015.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                // text: AppStrings.jobDescText,
                                text: state.jobsDetailModel?.jobsDetailData
                                    ?.description,
                                maxLines: 100,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions
                                    .textSubHeadingTextSizeViewForms),
                          ),
                          height(0.03.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: AppStrings.additionalInformation,
                                maxLines: 1,
                                fontFamily: AppFont.gilroyBold,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms,
                                color: AppColors.textBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          height(0.015.sw),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: textWidget(
                                // text: AppStrings.additionalTextDesc,
                                text: state.jobsDetailModel?.jobsDetailData
                                    ?.additionalInformation,
                                maxLines: 100,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions
                                    .textSubHeadingTextSizeViewForms),
                          ),
                          height(0.05.sw),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomMaterialButton(
                                  // height: AppDimensions.defaultMaterialButtonHeightHome,
                                  borderRadius: AppDimensions
                                      .defaultMaterialButtonRadiusHome,
                                  onPressed: () {
                                    AppDialogues.noHeaderDialogue(
                                        context: contextBuilder,
                                        body: ApplyForJobDialogue(
                                          jobId: widget.jobId
                                        )).show();
                                  },
                                  name: AppStrings.applyForJob)),
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}
