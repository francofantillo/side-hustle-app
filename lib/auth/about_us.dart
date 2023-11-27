import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                    text: AppStrings.aboutUs,
                    color: AppColors.blackColor,
                    fontSize: AppDimensions.textHeadingSizeHome,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: textWidget(
                  maxLines: 5,
                  text: AppStrings.aboutUsTextOne,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: textWidget(
                  maxLines: 15,
                  text: AppStrings.aboutUsTextTwo,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: textWidget(
                  maxLines: 15,
                  text: AppStrings.aboutUsTextThree,
                  color: AppColors.greyColor,
                  fontSize: AppDimensions.textSizeVerySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
