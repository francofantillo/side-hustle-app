import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
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
    super.initState();
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
      body: Form(
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
                ImageSlider(
                  onTap: () async {
                    final getImages = await ImagePickerService
                        .selectMultipleImagesFromGallery();
                    print("getImages: ${getImages}");
                    if (getImages != null) {
                      images = [];
                      for (int i = 0; i < getImages.length; i++) {
                        final image = getImages[i].path;
                        images?.add(image);
                      }
                      print("images: ${images?[0]}");
                      setState(() {});
                    }
                  },
                  itemImages: images,
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
                    text: AppStrings.uploadImagesBodyService,
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
                    suffixIcon: Icon(
                      Icons.my_location,
                      size: AppDimensions.imageIconSizeTextFormField,
                      color: AppColors.greyColorNoOpacity,
                    ),
                    isSuffixIcon: true,
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
                    controller: dateTextController,
                    height: 45.h,
                    hintText: AppStrings.selectTheDate,
                    isReadonly: true,
                    suffixIcon: ImageIcon(const AssetImage(AssetsPath.calender),
                        size: AppDimensions.imageIconSizeTextFormField,
                        color: AppColors.greyColorNoOpacity),
                    isSuffixIcon: true,
                    onTap: () async {
                      formattedDate = await AppUtils.selectDate(
                          context: context, initialDate: DateTime.now());
                      setState(() {});
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
                            controller: firstTimeTextController,
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
                            onTap: () async {
                              await AppUtils.selectTime(context, true);
                              setState(() {});
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
                            controller: secondTimeTextController,
                            // height: 45.h,
                            hintText: AppStrings.totalHoursHint,
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
                            onTap: () async {
                              await AppUtils.selectTime(context, false);
                              setState(() {});
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
                    height: 65.h,
                    hintText: AppStrings.enterTheAdditionalInformation,
                    // maxLines: 2,
                    // fillColor: AppColors.productTextFieldColor,
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomMaterialButton(
                    borderRadius: 14,
                    onPressed: () {
                      AppUtils.showBottomModalSheet(
                          context: context,
                          widget: const ModalBottomSheetPackageTypePost(
                            isJob: true,
                          ));
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
      ),
    );
  }
}
