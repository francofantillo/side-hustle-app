import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_request_service.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
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
  final bool isEdit;

  const PostProduct({super.key, this.isEdit = false});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: widget.isEdit
          ? AppStrings.editYourSideHustle
          : AppStrings.postYourSideHustle,
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
              ImageSlider(
                itemImages: AlphaAppData.postProductImagesList,
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
                  text: AppStrings.uploadImagesBodyProduct,
                  fontSize: AppDimensions.textSizeVerySmall,
                  fontFamily: AppFont.gilroyMedium,
                  maxLines: 2,
                ),
              ),
              height(0.04.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.productName,
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
                  hintText: AppStrings.enterTheProductName,
                  fillColor: AppColors.textFieldBackgroundColor,
                ),
              ),
              height(AppDimensions.formFieldsBetweenSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.location,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CheckboxWidget(
                    onChanged: (newValue) {
                      print('Checkbox value changed: $newValue');
                    },
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: textWidget(
                            text: AppStrings.useYourShopLocation,
                            fontFamily: AppFont.gilroyMedium,
                            fontSize: AppDimensions.textSizeVerySmall),
                      )),
                ],
              ),
              // height(AppDimensions.formFieldsBetweenSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.productDescription,
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
                  hintText: AppStrings.enterTheProductDescription,
                  // fillColor: AppColors.productTextFieldColor,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.productPricing,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.zipCode,
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
                    text: AppStrings.deliveryOptions,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeSmall,
                    fontFamily: AppFont.gilroyBold,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 1.sw,
                child: CustomDropDown(
                  items: AppUtils.items,
                  selectedValue: (v) {
                    print("selectedValue: $v");
                  },
                ),
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
                  height: 45.h,
                  hintText: AppStrings.enterTheAdditionalInformation,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomMaterialButton(
                  onPressed: () {
                    if (widget.isEdit) {
                      Navigator.pop(context);
                    } else {
                      AppUtils.showBottomModalSheet(
                          context: context,
                          widget: const ModalBottomSheetPackageTypePost(
                            isProduct: true,
                          ));
                      // Navigator.pushReplacementNamed(
                      //     context, AppRoutes.postAddedScreenRoute,
                      //     arguments: const PostAdded(
                      //       isProduct: true,
                      //       title: AppStrings.sideHustlePosted,
                      //       subTitle: AppStrings.sideHustlePostedSubTitle,
                      //       buttonName: AppStrings.viewSideHustle,
                      //     ));
                    }
                  },
                  color: AppColors.primaryColor,
                  name: widget.isEdit
                      ? AppStrings.saveChanges
                      : AppStrings.addProduct,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
