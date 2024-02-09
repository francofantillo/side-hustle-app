import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/utils/validation/regular_expressions.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class ApplyForJobDialogue extends StatefulWidget {
  final int? jobId;

  const ApplyForJobDialogue({super.key, this.jobId});

  @override
  State<ApplyForJobDialogue> createState() => _ApplyForJobDialogueState();
}

class _ApplyForJobDialogueState extends State<ApplyForJobDialogue> {
  late final JobsCubit _bloc;
  final TextEditingController _priceController = TextEditingController();

  // final controller = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  // final controller = MoneyMaskedTextController(decimalSeparator: '.');

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    print("Apply Job Dialogue jobID: ${widget.jobId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              width(45.w),
              Expanded(
                child: textWidget(
                    text: AppStrings.applyForJob,
                    fontFamily: AppFont.gilroyBold,
                    textAlign: TextAlign.center,
                    fontSize: AppDimensions.textSizeNormal + 2.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor),
              ),
              // const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CustomIcon.cancel,
                  size: 24,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RoundedCornersImage(
                  // imageHeight: 0.2.sw,
                  // imageWidth: 0.2.sw,
                  image: (state.jobsDetailModel?.jobsDetailData?.images !=
                              null &&
                          state.jobsDetailModel!.jobsDetailData!.images!
                              .isNotEmpty)
                      ? state.jobsDetailModel!.jobsDetailData!.images![0].image
                      : null,
                  assetImage: AssetsPath.imageLoadError,
                  imageHeight: 80.w,
                  imageWidth: 80.w,
                  boarderColor: Colors.transparent,
                ),
                // width(0.02.sw),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                            // text: AppStrings.carpenter,
                            text: state.jobsDetailModel?.jobsDetailData?.title,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textHeadingSizeViewForms,
                            color: AppColors.blackColor),
                        // height(0.01.sh),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: textWidget(
                              // text: AppStrings.productPricingNumeric,
                              text: state.jobsDetailModel?.jobsDetailData
                                          ?.budget !=
                                      null
                                  ? "\$${state.jobsDetailModel?.jobsDetailData?.budget?.toStringAsFixed(2)}"
                                  : "",
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textPriceSizeViewForms,
                              color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // height(0.02.sh),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageIcon(
                  const AssetImage(AssetsPath.location),
                  color: const Color(0xFF565656),
                  // size: 0.025.sh,
                  size: AppDimensions.imageIconSizeTextFormField,
                ),
                width(0.02.sw),
                Expanded(
                  child: textWidget(
                      // text: AppStrings.locationText,
                      text: state.jobsDetailModel?.jobsDetailData?.location,
                      maxLines: 2,
                      fontSize: AppDimensions.textLocationSizeViewForms),
                ),
              ],
            ),
          ),
          // height(0.02.sh),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIcon(
                  const AssetImage(AssetsPath.calender),
                  color: const Color(0xFF565656),
                  size: AppDimensions.imageIconSizeTextFormField,
                  // size: 0.025.sh,
                ),
                width(0.02.sw),
                Expanded(
                  child: textWidget(
                      // text: AppStrings.jobDateText,
                      text:
                          state.jobsDetailModel?.jobsDetailData?.jobDate != null
                              ? AppUtils.formatDateView(
                                  selectedDate: DateTime.parse(state
                                      .jobsDetailModel!
                                      .jobsDetailData!
                                      .jobDate!))
                              : "",
                      fontSize: AppDimensions.textLocationSizeViewForms),
                ),
              ],
            ),
          ),
          // height(0.02.sh),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  size: AppDimensions.imageIconSizeTextFormField,
                  color: const Color(0xFF565656),
                ),
                width(0.02.sw),
                Expanded(
                  child: textWidget(
                      // text: AppStrings.jobTimeText,
                      text:
                          "Start at ${DateTimeConversions.convertTo12HourFormat(state.jobsDetailModel?.jobsDetailData?.jobTime)} to ${DateTimeConversions.convertTo12HourFormat(state.jobsDetailModel?.jobsDetailData?.endTime)}",
                      fontSize: AppDimensions.textLocationSizeViewForms),
                ),
              ],
            ),
          ),
          // height(0.05.sw),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: CustomTextFormField(
              // controller: controller,
              controller: _priceController,
              hintText: AppStrings.enterTheBidAmount,
              keyboardType:
                  // const TextInputType.numberWithOptions(signed: true, decimal: false),
                  const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
              inputFormatter: [
                LengthLimitingTextInputFormatter(
                    Constants.priceFieldCharacterLength),
                RegularExpressions.PRICE_FORMATTER
              ],
              // keyboardType: TextInputType.numberWithOptions(signed: false),
            ),
          ),
          // height(0.02.sh),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomMaterialButton(
                borderRadius: AppDimensions.defaultMaterialButtonRadiusHome,
                // height: AppDimensions.defaultMaterialButtonHeightHome,
                onPressed: () async {
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context,
                  //     AppRoutes.bottomTabsScreenRoute,
                  //     arguments: const BottomTabsScreen(
                  //       currentIndex: 1,
                  //       wantedTabCurrentIndex: 1,
                  //     ),
                  //     (route) => false);
                  FocusManager.instance.primaryFocus?.unfocus();
                  await _bloc.applyForJobCubit(
                      context: context,
                      mounted: mounted,
                      jobId: widget.jobId,
                      bidAmount: _priceController.text);
                },
                name: AppStrings.submit),
          ),
          height(0.02.sh),
        ],
      );
    });
  }
}
