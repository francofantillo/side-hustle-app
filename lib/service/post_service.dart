import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/checkbox.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostService extends StatefulWidget {
  final bool isEdit;

  const PostService({super.key, this.isEdit = false});

  @override
  State<PostService> createState() => _PostServiceState();
}

class _PostServiceState extends State<PostService> {
  final PageController pageController = PageController();

  final List<String> items = [
    'Pickup',
    'Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: widget.isEdit
          ? AppStrings.editYourSideHustleService
          : AppStrings.postYourSideHustleService,
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
                itemImages: AlphaAppData.postServiceImagesList,
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
                  maxLines: 2,
                ),
              ),
              height(0.04.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.serviceName,
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
                  hintText: AppStrings.enterTheServiceName,
                  // fillColor: AppColors.productTextFieldColor,
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
                  suffixIcon: Icon(
                    Icons.my_location,
                    color: Colors.black,
                    size: AppDimensions.imageIconSizeTextFormField,
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
              // height(0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.serviceDescription,
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
                  hintText: AppStrings.enterServiceDescription,
                ),
              ),
              height(AppDimensions.formFieldsBetweenSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.howWouldYouLikeToSellService,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeSmall,
                    fontFamily: AppFont.gilroyBold,
                    fontWeight: FontWeight.bold),
              ),
              Row(
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
                    text: AppStrings.hourlyRate,
                    fontSize: AppDimensions.textSizeSmall,
                    fontFamily: AppFont.gilroySemiBold,
                  ),
                      )),
                  CheckboxWidget(
                    onChanged: (newValue) {
                      print('Checkbox value changed: $newValue');
                    },
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: textWidget(
                    text: AppStrings.fixedRate,
                    fontSize: AppDimensions.textSizeSmall,
                    fontFamily: AppFont.gilroyMedium,
                  ),
                      )),
                ],
              ),
              // height(0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.serviceHourlyRate,
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
              height(AppDimensions.formFieldsBetweenSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.additionalInformation,
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
                  hintText: AppStrings.pleaseEnterAdditionalInformation,
                  maxLines: 2,
                  // fillColor: AppColors.productTextFieldColor,
                ),
                // child: RatingTextFormField(
                //   isShowBoarder: true,
                //   height: 60.w,
                //   hintText: AppStrings.pleaseEnterAdditionalInformation,
                //   fillColor: AppColors.backgroundColor,
                //   // maxLines: 3,
                // ),
              ),
              height(AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomMaterialButton(
                    onPressed: () {
                      if (widget.isEdit) {
                        Navigator.pop(context);
                      } else {
                        // Navigator.pushReplacementNamed(
                        //     context, AppRoutes.postAddedScreenRoute,
                        //     arguments: const PostAdded(
                        //       isService: true,
                        //       title: AppStrings.sideHustlePosted,
                        //       subTitle: AppStrings.sideHustlePostedSubTitle,
                        //       buttonName: AppStrings.viewSideHustle,
                        //     ));
                        AppUtils.showBottomModalSheet(
                            context: context,
                            widget: const ModalBottomSheetPackageTypePost(
                              isService: true,
                            ));
                      }
                    },
                    color: AppColors.primaryColor,
                    name: widget.isEdit
                        ? AppStrings.saveChanges
                        : AppStrings.addService),
              )
            ],
          ),
        ),
      ),
    );
  }
}
