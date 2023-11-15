import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/checkbox.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostService extends StatefulWidget {
  const PostService({super.key});

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
      appBarTitle: AppStrings.postYourSideHustleService,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
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
              ImageSlider(itemImages: AlphaAppData.postServiceImagesList,),
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
                    text: AppStrings.serviceName,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.enterTheServiceName,
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
                    text: AppStrings.serviceDescription,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.enterServiceDescription,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.howWouldYouLikeToSellService,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
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
                      child: textWidget(text: AppStrings.hourlyRate)),
                  CheckboxWidget(
                    onChanged: (newValue) {
                      print('Checkbox value changed: $newValue');
                    },
                  ),
                  Expanded(
                      child: textWidget(text: AppStrings.fixedRate)),
                ],
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.serviceHourlyRate,
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
                  hintText: AppStrings.pleaseEnterAdditionalInformation,
                  maxLines: 2,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.postAddedScreenRoute,
                          arguments: const PostAdded(
                            isService: true,
                            title: AppStrings.sideHustlePosted,
                            subTitle: AppStrings.sideHustlePostedSubTitle,
                            buttonName: AppStrings.viewSideHustle,
                          ));
                    },
                    color: AppColors.primaryColor,
                    name: AppStrings.addService),
              )
            ],
          ),
        ),
      ),
    );
  }
}
