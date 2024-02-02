import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_alpha.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostJob extends StatefulWidget {
  final bool isEdit;

  const PostJob({super.key, this.isEdit = false});

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  late final JobsCubit _bloc;
  late final CardCubit _blocCard;
  final _jobFormKey = GlobalKey<FormState>();
  List<String>? images;
  TextEditingController dateTextController = TextEditingController();
  TextEditingController firstTimeTextController = TextEditingController();
  TextEditingController secondTimeTextController = TextEditingController();
  String? formattedDate;

  @override
  void initState() {
    AppUtils.firstSelectedTime = null;
    AppUtils.secondSelectedTime = null;
    _bloc = BlocProvider.of(context);
    _blocCard = BlocProvider.of(context);
    _bloc.initPostJobControllers();
    super.initState();
  }

  Future getCards({required bool isEdit}) async {
    await _blocCard
        .getCardsCubit(context: context, mounted: mounted)
        .then((value) {
      if (value != null && value.isEmpty) {
        AppUtils.showToast(AppStrings.cardNotAddedError);
      } else if (value != null) {
        if (isEdit) {
          AppUtils.showBottomModalSheet(
              context: context,
              widget: const ModalBottomSheetPackageTypePost(
                isJob: true,
              ));
        } else {
          AppUtils.showBottomModalSheet(
              context: context,
              widget: const ModalBottomSheetPackageTypePost(
                isJob: true,
              ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    dateTextController.text = formattedDate ?? "";
    firstTimeTextController.text = AppUtils.firstSelectedTime != null
        ? AppUtils.firstSelectedTime!.format(context)
        : "";
    secondTimeTextController.text = AppUtils.secondSelectedTime != null
        ? AppUtils.secondSelectedTime!.format(context)
        : "";

    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: widget.isEdit ? AppStrings.editJob : AppStrings.postJob,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
        backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
        return Form(
          key: _jobFormKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.rootPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ImageSliderAlpha(
                  //   onTap: () async {
                  //     final getImages = await ImagePickerService
                  //         .selectMultipleImagesFromGallery();
                  //     print("getImages: ${getImages}");
                  //     if (getImages != null) {
                  //       images = [];
                  //       for (int i = 0; i < getImages.length; i++) {
                  //         final image = getImages[i].path;
                  //         images?.add(image);
                  //       }
                  //       print("images: ${images?[0]}");
                  //       setState(() {});
                  //     }
                  //   },
                  //   itemImages: images,
                  // ),
                  ImageSlider(
                    // itemImages: itemImages,
                    fileImages: state.itemImagesFile,
                    indicatorLength: state.itemImagesFile?.length,
                    onTap: () async {
                      await _bloc.selectMultiImages();
                    },
                  ),
                  height(0.02.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                        text: AppStrings.uploadImages,
                        maxLines: 1,
                        color: AppColors.textBlackColor,
                        fontSize: AppDimensions.textSizeSmall,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold),
                  ),
                  height(0.01.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                      text: AppStrings.uploadImagesBodyJob,
                      fontSize: AppDimensions.textSizeVerySmall,
                      fontFamily: AppFont.gilroyMedium,
                      maxLines: 3,
                    ),
                  ),
                  height(0.04.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                        text: AppStrings.postJobTitle,
                        maxLines: 1,
                        color: AppColors.textBlackColor,
                        fontSize: AppDimensions.textSizeSmall,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold),
                  ),
                  height(0.01.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CustomTextFormField(
                      height: 45.h,
                      hintText: AppStrings.enterTheJobTitle,
                      // fillColor: AppColors.fieldsOutlineColor,
                      fillColor: AppColors.textFieldBackgroundColor,
                      controller: _bloc.titleTextController,
                      fieldValidator: (value) =>
                          value?.validateEmpty(AppStrings.postJobTitle),
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(
                            Constants.singleFieldCharacterLength),
                      ],
                    ),
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                        text: AppStrings.jobLocation,
                        maxLines: 1,
                        color: AppColors.textBlackColor,
                        fontSize: AppDimensions.textSizeSmall,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold),
                  ),
                  height(0.01.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CustomTextFormField(
                      height: 45.h,
                      hintText: AppStrings.enterJobLocation,
                      isReadonly: true,
                      onTap: () async {
                        await _bloc.selectLocation(
                            context: context, mounted: mounted);
                      },
                      suffixIcon: Icon(
                        Icons.my_location,
                        size: AppDimensions.imageIconSizeTextFormField,
                        color: AppColors.greyColorNoOpacity,
                      ),
                      isSuffixIcon: true,
                      controller: _bloc.locationTextController,
                      fieldValidator: (value) =>
                          value?.validateEmpty(AppStrings.jobLocation),
                    ),
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                        text: AppStrings.jobDesc,
                        maxLines: 1,
                        color: AppColors.textBlackColor,
                        fontSize: AppDimensions.textSizeSmall,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold),
                  ),
                  height(0.01.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CustomTextFormField(
                      height: 75.h,
                      hintText: AppStrings.enterTheJobDesc,
                      controller: _bloc.descriptionTextController,
                      fieldValidator: (value) =>
                          value?.validateEmpty(AppStrings.jobDesc),
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(
                            Constants.descriptionFieldCharacterLength),
                      ],
                    ),
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: textWidget(
                                  text: AppStrings.jobBudget,
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeSmall,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold),
                            ),
                            height(0.01.sw),
                            CustomTextFormField(
                              height: 45.h,
                              hintText: "\$\$\$",
                              keyboardType:
                              const TextInputType.numberWithOptions(
                                  signed: false, decimal: true),
                              controller: _bloc.priceTextController,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.jobBudget),
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(
                                    Constants.priceFieldCharacterLength),
                              ],
                              // fillColor: AppColors.productTextFieldColor,
                            ),
                          ],
                        ),
                      ),
                      width(0.01.sw),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: textWidget(
                                  text: AppStrings.areaCode,
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeSmall,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold),
                            ),
                            height(0.01.sw),
                            CustomTextFormField(
                              height: 45.h,
                              hintText: "00000",
                              controller: _bloc.areaCodeTextController,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.areaCode),
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(
                                    Constants.zipCodeFieldCharacterLength),
                              ],
                              // keyboardType: TextInputType.number,
                              // fillColor: AppColors.productTextFieldColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                        text: AppStrings.jobDate,
                        maxLines: 1,
                        color: AppColors.textBlackColor,
                        fontSize: AppDimensions.textSizeSmall,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold),
                  ),
                  height(0.01.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CustomTextFormField(
                      height: 45.h,
                      hintText: AppStrings.selectTheDate,
                      isReadonly: true,
                      suffixIcon: ImageIcon(
                          const AssetImage(AssetsPath.calender),
                          size: AppDimensions.imageIconSizeTextFormField,
                          color: AppColors.greyColorNoOpacity),
                      isSuffixIcon: true,
                      controller: _bloc.dateTextController,
                      fieldValidator: (value) =>
                          value?.validateEmpty(AppStrings.jobDate),
                      // onTap: () async {
                      //   formattedDate = await AppUtils.selectDate(
                      //       context: context, initialDate: DateTime.now());
                      //   setState(() {});
                      // },
                      onTap: () async {
                        final String? formattedDate = await AppUtils.selectDate(
                            context: context, initialDate: DateTime.now());
                        if (formattedDate != null) {
                          _bloc.dateTextController.text = formattedDate ?? "";
                        }
                      },
                    ),
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: textWidget(
                                  text: AppStrings.jobTime,
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeSmall,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold),
                            ),
                            height(0.01.sw),
                            CustomTextFormField(
                              // height: 45.h,
                              hintText: AppStrings.jobTimeHint,
                              // suffixIcon: ImageIcon(
                              //   const AssetImage(AssetsPath.time),
                              //   size: AppDimensions.imageIconSizeTextFormField,
                              //   color: AppColors.greyColorNoOpacity,
                              // ),
                              suffixIcon: Icon(
                                Icons.access_time_filled_rounded,
                                size: AppDimensions.imageIconSizeTextFormField,
                                color: AppColors.greyColorNoOpacity,
                              ),
                              isSuffixIcon: true,
                              isReadonly: true,
                              controller: _bloc.startTimeTextController,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.jobTime),
                              // onTap: () async {
                              //   await AppUtils.selectTime(context, true);
                              //   setState(() {});
                              // },
                              onTap: () async {
                                await AppUtils.selectTime(context, true);
                                print(
                                    "selected time: ${AppUtils.firstSelectedTime}");
                                if (mounted) {
                                  _bloc.startTimeTextController.text =
                                  AppUtils.firstSelectedTime != null
                                      ? AppUtils.firstSelectedTime!
                                      .format(context)
                                      : "";
                                }
                                // setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      width(0.01.sw),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: textWidget(
                                  text: AppStrings.totalHours,
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeSmall,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold),
                            ),
                            height(0.01.sw),
                            CustomTextFormField(
                              // height: 45.h,
                              hintText: AppStrings.totalHoursHint,
                              // suffixIcon: ImageIcon(
                              //   const AssetImage(AssetsPath.time),
                              //   size: AppDimensions.imageIconSizeTextFormField,
                              //   color: AppColors.greyColorNoOpacity,
                              // ),
                              controller: _bloc.endTimeTextController,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.jobTime),
                              suffixIcon: Icon(
                                Icons.access_time_filled_rounded,
                                size: AppDimensions.imageIconSizeTextFormField,
                                color: AppColors.greyColorNoOpacity,
                              ),
                              isSuffixIcon: true,
                              isReadonly: true,
                              onTap: () async {
                                await AppUtils.selectTime(context, false);
                                if (mounted) {
                                  _bloc.endTimeTextController.text =
                                  AppUtils.secondSelectedTime != null
                                      ? AppUtils.secondSelectedTime!
                                      .format(context)
                                      : "";
                                }
                              },
                              // fillColor: AppColors.productTextFieldColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                        text: AppStrings.additionalInformation,
                        maxLines: 1,
                        color: AppColors.textBlackColor,
                        fontSize: AppDimensions.textSizeSmall,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold),
                  ),
                  height(0.01.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CustomTextFormField(
                      hintText: AppStrings.enterTheAdditionalInformation,
                      controller: _bloc.additionalInfoTextController,
                      fieldValidator: (value) => value
                          ?.validateEmpty(AppStrings.additionalInformation),
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(
                            Constants.descriptionFieldCharacterLength),
                      ],
                      // maxLines: 2,
                      // fillColor: AppColors.productTextFieldColor,
                    ),
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomMaterialButton(
                      borderRadius: 14,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_jobFormKey.currentState!.validate()) {
                          await getCards(isEdit: false);
                        }
                      },
                      color: AppColors.primaryColor,
                      name: widget.isEdit
                          ? AppStrings.saveChanges
                          : AppStrings.postJob,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
