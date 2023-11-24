import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class PostYourSideHustleDialogueWidget extends StatefulWidget {
  final Function()? onTapClose;
  final Function() onPressed;
  final ValueChanged<bool> isProductSelected;

  const PostYourSideHustleDialogueWidget(
      {super.key,
      required this.onPressed,
      this.onTapClose,
      required this.isProductSelected});

  @override
  State<PostYourSideHustleDialogueWidget> createState() => _PostYourSideHustleDialogueWidgetState();
}

class _PostYourSideHustleDialogueWidgetState extends State<PostYourSideHustleDialogueWidget> {
  bool isItemOneSelected = true;

  @override
  void initState() {
    super.initState();
    isItemOneSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: widget.onTapClose,
                    child: const Icon(
                      // Icons.close,
                      CustomIcon.cancel,
                      size: 22,
                    ),
                  ),
                )
            ),
            // height(.02.sh),
            textWidget(
                text: "Post your Side Hustle",
                color: AppColors.textBlackColor,
                fontFamily: AppFont.gilroyBold,
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.dialogueTextHeadingSize),
            height(.01.sh),
            textWidget(
                text:
                    "Please select what would you like to post as your side hustle",
                fontSize: AppDimensions.textSizePerHead,
                maxLines: 2),
            height(.02.sh),
            InkWell(
              onTap: () {
                widget.isProductSelected(true);
                setState(() {
                  isItemOneSelected = true;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isItemOneSelected
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  // Adjust the radius as needed
                  color: AppColors.dialogueSelected,
                ),
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textWidget(
                        text: AppStrings.product,
                        color: AppColors.textBlackColor,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textSizeNormal),
                    // height(0.01.sw),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: textWidget(
                          text: AppStrings.productDesc,
                          fontSize: AppDimensions.textSizePerHead,
                          maxLines: 2),
                    ),
                  ],
                ),
              ),
            ),
            height(.02.sw),
            InkWell(
              onTap: () {
                widget.isProductSelected(false);
                setState(() {
                  isItemOneSelected = false;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isItemOneSelected
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  // Adjust the radius as needed
                  color: AppColors.dialogueSelected,
                ),
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textWidget(
                        text: AppStrings.service,
                        color: AppColors.textBlackColor,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textSizeNormal),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: textWidget(
                          text: AppStrings.productDesc,
                          fontSize: AppDimensions.textSizePerHead,
                          maxLines: 2),
                    ),
                  ],
                ),
              ),
            ),
            height(.03.sh),
            customMaterialButton(
              height: 10.h,
                name: AppStrings.continueText,
                color: AppColors.primaryColor,
                borderRadius: 12,
                onPressed: widget.onPressed),
          ],
        ),
      ),
    );
  }
}
