import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/checkbox.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key});

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  TextEditingController dateTextController = TextEditingController();
  TextEditingController firstTimeTextController = TextEditingController();
  TextEditingController secondTimeTextController = TextEditingController();
  String? formattedDate;

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
      appBarTitle: AppStrings.postJob,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.rootPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ImageSlider(),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.uploadImages,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                  text: AppStrings.uploadImagesBodyService,
                  maxLines: 3,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.postJobTitle,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.enterTheJobTitle,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobLocation,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.enterJobLocation,
                  suffixIcon: const Icon(
                    Icons.my_location,
                    color: Colors.black,
                  ),
                  isSuffixIcon: true,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobDesc,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 75.h,
                  hintText: AppStrings.enterTheJobDesc,
                  maxLines: 2,
                ),
              ),
              height(0.02.sh),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.jobBudget,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sh),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.areaCode,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sh),
                        CustomTextFormField(
                          height: 45.h,
                          hintText: "00000",
                          keyboardType: TextInputType.number,
                          // fillColor: AppColors.productTextFieldColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobDate,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  controller: dateTextController,
                  height: 45.h,
                  hintText: AppStrings.selectTheDate,
                  isReadonly: true,
                  suffixIcon: const ImageIcon(AssetImage(AssetsPath.calender),
                      color: Colors.black),
                  isSuffixIcon: true,
                  onTap: () async {
                    formattedDate = await AppUtils.selectDate(
                        context: context, initialDate: DateTime.now());
                    setState(() {});
                  },
                ),
              ),
              height(0.02.sh),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.jobTime,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sh),
                        CustomTextFormField(
                          controller: firstTimeTextController,
                          height: 45.h,
                          hintText: AppStrings.jobTimeHint,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.totalHours,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sh),
                        CustomTextFormField(
                          controller: secondTimeTextController,
                          height: 45.h,
                          hintText: AppStrings.totalHoursHint,
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
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.additionalInformation,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 65.h,
                  hintText: AppStrings.enterTheAdditionalInformation,
                  maxLines: 2,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    onPressed: () {},
                    color: AppColors.primaryColor,
                    name: AppStrings.postJob),
              )
            ],
          ),
        ),
      ),
    );
  }
}
