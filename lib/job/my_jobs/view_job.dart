import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/job_request.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_alpha.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewJob extends StatefulWidget {
  final int? jobId;

  const ViewJob({super.key, this.jobId});

  @override
  State<ViewJob> createState() => _ViewJobState();
}

class _ViewJobState extends State<ViewJob> {
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
      appBarTitle: AppStrings.viewJob,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
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
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(
                                    text: state
                                        .jobsDetailModel?.jobsDetailData?.title,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFont.gilroyBold,
                                    fontSize:
                                        AppDimensions.textHeadingSizeViewForms,
                                    color: AppColors.textBlackColor),
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
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ImageIcon(
                                  const AssetImage(AssetsPath.location),
                                  size: AppDimensions.applyForJobIconSize,
                                  color: const Color(0xFF565656),
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
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ImageIcon(
                                  const AssetImage(AssetsPath.calender),
                                  size: AppDimensions.applyForJobIconSize,
                                  color: const Color(0xFF565656),
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
                                      color: const Color(0xFF565656),
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time_filled_rounded,
                                  size: AppDimensions.applyForJobIconSize,
                                  color: const Color(0xFF565656),
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      text:
                                          "Start at ${DateTimeConversions.convertTo12HourFormat(state.jobsDetailModel?.jobsDetailData?.jobTime)} to ${DateTimeConversions.convertTo12HourFormat(state.jobsDetailModel?.jobsDetailData?.endTime)}",
                                      color: const Color(0xFF565656),
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          height(0.01.sw),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: AppColors.greyColor,
                            ),
                          ),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: AppStrings.jobDesc,
                                maxLines: 2,
                                fontFamily: AppFont.gilroyBold,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms,
                                color: AppColors.textBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          height(0.01.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: state.jobsDetailModel?.jobsDetailData
                                    ?.description,
                                maxLines: 30,
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
                                maxLines: 2,
                                fontFamily: AppFont.gilroyBold,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms,
                                color: AppColors.textBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          height(0.01.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: state.jobsDetailModel?.jobsDetailData
                                    ?.additionalInformation,
                                maxLines: 30,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions
                                    .textSubHeadingTextSizeViewForms),
                          ),
                          height(0.05.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomMaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.jobRequestScreenRoute,
                                      arguments: JobRequest(
                                        jobId: widget.jobId,
                                      ));
                                },
                                name: AppStrings.viewRequest,
                                color: AppColors.greenColor),
                          ),
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}
