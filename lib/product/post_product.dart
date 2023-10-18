import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/dropdown/dropdown.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/checkbox.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({super.key});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  final PageController pageController = PageController();

  final List<String> items = [
    'Pickup',
    'Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.postYourSideHustle,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: backButton(onPressed: () => () {}, iconSize: 16),
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
                  text: AppStrings.uploadImagesBodyProduct,
                  maxLines: 2,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.productName,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.enterTheProductName,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.location,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.enterTheLocation,
                  suffixIcon: const Icon(
                    Icons.my_location,
                    color: Colors.black,
                  ),
                  isSuffixIcon: true,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              Row(
                children: [
                  CheckboxWidget(
                    onChanged: (newValue) {
                      print('Checkbox value changed: $newValue');
                    },
                  ),
                  Expanded(
                      child: textWidget(text: AppStrings.useYourShopLocation)),
                ],
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.productDescription,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.enterTheProductDescription,
                  // fillColor: AppColors.productTextFieldColor,
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
                              text: AppStrings.productPricing,
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
                              text: AppStrings.zipCode,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sh),
                        CustomTextFormField(
                          height: 45.h,
                          hintText: "00000",
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
                    text: AppStrings.deliveryOptions,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 1.sw,
                child: CustomDropDown(
                  items: items,
                  selectedValue: (v) {
                    print("selectedValue: $v");
                  },
                ),
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
                  height: 45.h,
                  hintText: AppStrings.enterTheAdditionalInformation,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    onPressed: () {},
                    color: AppColors.primaryColor,
                    name: AppStrings.addProduct),
              )
            ],
          ),
        ),
      ),
    );
  }
}
