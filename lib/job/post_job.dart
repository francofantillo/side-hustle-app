import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/state_management/models/card_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/utils/validation/regular_expressions.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostJob extends StatefulWidget {
  final bool isEdit, isJobEditFromPostAdded;
  final int? id;

  const PostJob(
      {super.key,
      this.isEdit = false,
      this.isJobEditFromPostAdded = false,
      this.id});

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
    print("Job id: ${widget.id}");
    widget.id != null
        ? getJob()
        // : _bloc.state.editEventModel = EventsModel();
        : null;
    super.initState();
  }

  Future getJob() async {
    await _bloc
        .getEditJobCubit(context: context, mounted: mounted, jobId: widget.id)
        .then((value) {
      if (value != null) {
        final date = value.jobDate != null
            ? AppUtils.formatDateView(
                selectedDate: DateTime.parse(value.jobDate!))
            : "";
        final startTime =
            DateTimeConversions.convertTo12HourFormat(value.jobTime);
        final endTime =
            DateTimeConversions.convertTo12HourFormat(value.endTime);

        print("getEvent lat: ${value.lat}");
        print("getEvent lng: ${value.lng}");
        _bloc.dateTextController.text = date;
        _bloc.startTimeTextController.text = startTime;
        _bloc.endTimeTextController.text = endTime;
        if (value.jobTime != null) {
          TimeOfDay _startTime = AppUtils.convertToTimeOfDay(value.jobTime!);
          AppUtils.firstSelectedTime = _startTime;
        }
        if (value.endTime != null) {
          TimeOfDay _endTime = AppUtils.convertToTimeOfDay(value.endTime!);
          AppUtils.secondSelectedTime = _endTime;
        }
        _bloc.titleTextController.text = value.title ?? "";
        _bloc.locationTextController.text = value.location ?? "";
        _bloc.descriptionTextController.text = value.description ?? "";
        _bloc.additionalInfoTextController.text =
            value.additionalInformation ?? "";
        _bloc.areaCodeTextController.text = value.areaCode ?? "";
        _bloc.priceTextController.text = value.budget?.toStringAsFixed(2) ?? "";
        _bloc.totalHour();
      }
    });
  }

  Future getCards({required bool isEdit}) async {
    await _blocCard
        .getCardsCubit(context: context, mounted: mounted)
        .then((value) {
      if (value != null && value.isEmpty) {
        AppUtils.showToast(AppStrings.cardNotAddedError);
      } else if (value != null) {
        int? cardId;
        DataCard? dataCard;
        for (int i = 0;
            i < (_blocCard.state.cardModel?.data?.length ?? 0);
            i++) {
          if (_blocCard.state.cardModel?.data?[i].isDefault == 1) {
            cardId = _blocCard.state.cardModel?.data?[i].id;
            dataCard = _blocCard.state.cardModel?.data?[i];
          }
        }
        if (isEdit) {
          AppUtils.showBottomModalSheet(
              context: context,
              widget: ModalBottomSheetPackageTypePost(
                  isJob: true, defaultCardId: cardId));
        } else {
          AppUtils.showBottomModalSheet(
              context: context,
              widget: ModalBottomSheetPackageTypePost(
                  isJob: true, defaultCardId: cardId));
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
                              controller: _bloc.priceTextController,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.jobBudget),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(
                                    Constants.priceFieldCharacterLength),
                                RegularExpressions.PRICE_FORMATTER
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
                              keyboardType: TextInputType.phone,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.areaCode),
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(
                                    Constants.zipCodeFieldCharacterLength),
                                FilteringTextInputFormatter.digitsOnly,
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
                                  if (AppUtils.firstSelectedTime != null) {
                                    final String firstTime =
                                        AppUtils.formatTimeOfDay(
                                            AppUtils.firstSelectedTime!);
                                    _bloc.startTimeTextController.text =
                                        firstTime;
                                    print(
                                        "Start Time: ${_bloc.startTimeTextController.text}");
                                  }
                                  _bloc.totalHour();
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
                            /*             Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: textWidget(
                                  // text: AppStrings.totalHours,
                                  text:
                                      "Total Hours: ${state.totalHours != null ? "${state.totalHours} Hours" : ""}",
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeSmall,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold),
                            ),
                            height(0.01.sw),*/
                            Text(""),
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
                                  if (AppUtils.secondSelectedTime != null) {
                                    final String endTime =
                                        AppUtils.formatTimeOfDay(
                                            AppUtils.secondSelectedTime!);
                                    _bloc.endTimeTextController.text = endTime;
                                    print(
                                        "End Time: ${_bloc.endTimeTextController.text}");
                                  }
                                  _bloc.totalHour();
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
