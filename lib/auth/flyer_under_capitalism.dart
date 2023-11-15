import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class FlyerUnderCapitalismScreen extends StatefulWidget {
  const FlyerUnderCapitalismScreen({super.key});

  @override
  State<FlyerUnderCapitalismScreen> createState() => _FlyerUnderCapitalismScreenState();
}

class _FlyerUnderCapitalismScreenState extends State<FlyerUnderCapitalismScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
        backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: textWidget(
                    text: AppStrings.unitedCapitalism,
                    color: AppColors.blackColor,
                    fontSize: AppDimensions.textHeadingSizeHome,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: textWidget(
                    text: AppStrings.unitedCapitalismSubText,
                    color: AppColors.blackColor,
                    maxLines: 2,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: textWidget(
                  maxLines: 5,
                  text: AppStrings.flyerUnderCapitalismTextOne,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: textWidget(
                  maxLines: 15,
                  text: AppStrings.flyerUnderCapitalismTextTwo,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: textWidget(
                  maxLines: 15,
                  text: AppStrings.flyerUnderCapitalismTextThree,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: textWidget(
                  maxLines: 15,
                  text: AppStrings.flyerUnderCapitalismTextFour,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: textWidget(
                  maxLines: 15,
                  text: AppStrings.flyerUnderCapitalismTextFive,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: textWidget(
                  maxLines: 15,
                  text: AppStrings.flyerUnderCapitalismTextSix,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              height(0.1.sw)
            ],
          ),
        ),
      ),
    );
  }
}
