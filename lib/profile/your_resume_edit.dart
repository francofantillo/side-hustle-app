import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class YourResumeEdit extends StatefulWidget {
  const YourResumeEdit({super.key});

  @override
  State<YourResumeEdit> createState() => _YourResumeEditState();
}

class _YourResumeEditState extends State<YourResumeEdit> {
  final TextEditingController _textEditingControllerHobbies =
      TextEditingController();

  final List<String> itemsList = [
    "Hobbies 1",
    "Hobbies 2",
    "Hobbies 3",
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.editYourResume,
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
              Row(
                children: [
                  Stack(
                    children: [
                      CircularCacheImageWidget(
                        showLoading: true,
                        // image: AlphaAppData.dpProfile,
                        assetImage: AssetsPath.brandonProfile,
                        boarderColor: AppColors.primaryColor,
                        imageHeight: 0.28.sw,
                        imageWidth: 0.28.sw,
                        borderWidth: .005.sw,
                      ),
                      Positioned(
                        left: 0.2.sw,
                        top: 0.2.sw,
                        child: IconButtonWithBackground(
                          // height: .074.sh,
                          height: .08.sw,
                          // width: .13.sw,
                          width: .08.sw,
                          borderRadius: 40,
                          backgroundColor: AppColors.primaryColor,
                          iconColor: AppColors.whiteColor,
                          iconSize: 14,
                          onTap: () {
                            print("clicked minus");
                          },
                          iconPath: AssetsPath.edit,
                        ),
                      )
                    ],
                  ),
                  width(0.02.sw),
                  Container(
                    padding: const EdgeInsets.all(7.2),
                    decoration: const BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      children: [
                        Material(
                          color: AppColors.greenColor,
                          child: InkWell(
                            onTap: () {},
                            child: textWidget(
                                text: AppStrings.uploadResume,
                                color: AppColors.whiteColor,
                                fontSize: AppDimensions.textSizeSmall),
                          ),
                        ),
                        width(0.015.sw),
                        Material(
                          color: AppColors.greenColor,
                          child: InkWell(
                            onTap: () {},
                            child: const Icon(
                              CustomIcon.cancel,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.actualName,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.actualNameHint,
                  // fillColor: AppColors.productTextFieldColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.callSignOrNickname,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.callSignOrNicknameHint,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.familyTies,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.familyTiesHint,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.professionalBackground,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.professionalBackgroundHint,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.hobbies,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  controller: _textEditingControllerHobbies,
                  height: 45.h,
                  // inputFormatter: [
                  //   LengthLimitingTextInputFormatter(40),
                  // ],
                  hintText: AppStrings.hobbiesHint,
                  isSuffixIcon: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_textEditingControllerHobbies.text.isNotEmpty) {
                        itemsList.add(_textEditingControllerHobbies.text);
                        _textEditingControllerHobbies.clear();
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: 33,
                    ),
                  ),
                ),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 8.0, // gap between lines
                  direction: Axis.horizontal,
                  children: <Widget>[
                    for (int i = 0; i < itemsList.length; i++)
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Container(
                          // width: .35.sw,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Row(
                            children: [
                              textWidget(
                                  text: itemsList[i],
                                  maxLines: 2,
                                  color: AppColors.whiteColor,
                                  fontSize: AppDimensions.textSizeSmall),
                              width(0.015.sw),
                              Material(
                                color: AppColors.primaryColor,
                                child: InkWell(
                                  onTap: () {
                                    itemsList.removeAt(i);
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    CustomIcon.cancel,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.favoriteQuote,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.favoriteQuoteHint,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.whatDoYou,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CustomTextFormField(
                  height: 45.h,
                  hintText: AppStrings.whatDoYouHint,
                ),
              ),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    borderRadius: 14,
                    fontSize: AppDimensions.textSizeNormal,
                    height: 10.h,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.bottomTabsScreenRoute,
                          arguments: const BottomTabsScreen(
                            currentIndex: 4,
                          ),
                          (route) => false);
                    },
                    color: AppColors.primaryColor,
                    name: AppStrings.saveResume),
              )
            ],
          ),
        ),
      ),
    );
  }
}
