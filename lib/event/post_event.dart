import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/dropdown/dropdown.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostEvent extends StatefulWidget {
  const PostEvent({super.key});

  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  TextEditingController dateTextController = TextEditingController();
  TextEditingController firstTimeTextController = TextEditingController();
  TextEditingController secondTimeTextController = TextEditingController();
  String? formattedDate;

  final List<String> items = [
    PaymentTypeEnum.Cash.name,
    PaymentTypeEnum.Card.name,
  ];

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
      appBarTitle: AppStrings.postAnEvent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
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
                    text: AppStrings.eventName,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.eventNameHint,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventLocation,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.eventLocationHint,
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
                    text: AppStrings.eventDate,
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
                              text: AppStrings.eventTime,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sh),
                        CustomTextFormField(
                          controller: firstTimeTextController,
                          height: 45.h,
                          hintText: AppStrings.startTime,
                          suffixIcon: ImageIcon(
                            AssetImage(AssetsPath.time),
                            color: AppColors.blackColor,
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
                          hintText: AppStrings.endTime,
                          suffixIcon: ImageIcon(
                            AssetImage(AssetsPath.time),
                            color: AppColors.blackColor,
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
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventPurpose,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.eventPurposeHint,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventTheme,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.eventThemeHint,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventVendorList,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.eventVendorListHint,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventTicketPrice,
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
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.paymentType,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 1.sh,
                child: CustomDropDown(
                  items: items,
                  hintText: AppStrings.paymentTypeHint,
                  selectedValue: (v) {
                    print("selectedValue: $v");
                  },
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventAvailableAttractions,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 65.h,
                  hintText: AppStrings.eventAvailableAttractionsHint,
                  maxLines: 3,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    onPressed: () {},
                    color: AppColors.primaryColor,
                    name: AppStrings.postAnEvent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
