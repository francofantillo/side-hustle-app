import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class YourResume extends StatefulWidget {
  const YourResume({super.key});

  @override
  State<YourResume> createState() => _YourResumeState();
}

class _YourResumeState extends State<YourResume> {

  final List<String> itemsList = [
    "Hobbies 1",
    "Hobbies 2",
    "Hobbies 3",
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.yourResume,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 8),
          child: CircularIconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.yourResumeEditScreenRoute);
            },
            width: 0.10.sw,
            height: 0.10.sw,
            icon: Icons.edit,
            backgroundColor: AppColors.backIconBackgroundColor,
            iconSize: 14,
            iconColor: AppColors.primaryColor,
          ),
        )
      ],
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
                  CircularCacheImageWidget(
                    showLoading: true,
                    image:
                        AlphaAppData.dpProfile,
                    boarderColor: AppColors.primaryColor,
                    imageHeight: 0.28.sw,
                    imageWidth: 0.28.sw,
                    borderWidth: .005.sw,
                  ),
                  width(0.02.sw),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                          text: AppStrings.davidHan,
                          maxLines: 1,
                          color: AppColors.textBlackColor,
                          fontSize: AppDimensions.textSizeNormal,
                          fontWeight: FontWeight.bold),
                      height(0.001.sh),
                      textWidget(
                          text: AppStrings.nickname,
                          maxLines: 1,
                          fontSize: AppDimensions.textSizeVerySmall),
                      height(0.01.sh),
                      textWidget(
                          text: AppStrings.profession,
                          maxLines: 1,
                          fontSize: AppDimensions.textSizeVerySmall),
                    ],
                  )
                ],
              ),
              height(0.05.sh),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 1.sw,
                    padding: const EdgeInsets.only(
                        left: 12, top: 12, right: 8, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 1, color: AppColors.borderColorResumePage)),
                    child: textWidget(
                      text: AppStrings.familyTies,
                      maxLines: 1,
                    ),
                  )),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 1.sw,
                    padding: const EdgeInsets.only(
                        left: 12, top: 12, right: 8, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 1, color: AppColors.borderColorResumePage)),
                    child: textWidget(
                      text: AppStrings.professionalBackgroundHint,
                      maxLines: 1,
                    ),
                  )),
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 8.0, // gap between lines
                  direction: Axis.horizontal,
                  children: [
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
                          child: textWidget(
                              text: itemsList[i],
                              maxLines: 2,
                              color: AppColors.whiteColor,
                              fontSize: AppDimensions.textSizeSmall),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 1.sw,
                    padding: const EdgeInsets.only(
                        left: 12, top: 12, right: 8, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 1, color: AppColors.borderColorResumePage)),
                    child: textWidget(
                      text: AppStrings.favoriteQuote,
                      maxLines: 1,
                    ),
                  )),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 1.sw,
                    padding: const EdgeInsets.only(
                        left: 12, top: 12, right: 8, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 1, color: AppColors.borderColorResumePage)),
                    child: textWidget(
                      text: AppStrings.jobDescText,
                      maxLines: 2,
                    ),
                  )),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.attachedResume,
                    maxLines: 1,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.02.sh),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.backIconBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Image.asset(
                          AssetsPath.pdf,
                          width: 24,
                          height: 24,
                        )),
                      ),
                      width(0.04.sw),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                              text: AppStrings.resumePdf,
                              fontSize: AppDimensions.textSizeSmall,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appTextBlackColor),
                          height(0.002.sh),
                          textWidget(
                            text: AppStrings.resumePdfSize,
                            fontSize: AppDimensions.textSizeVerySmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      customMaterialButton(
                          onPressed: () {},
                          width: 4,
                          borderRadius: 14,
                          name: AppStrings.view,
                          fontSize: AppDimensions.textSizeVerySmall)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
