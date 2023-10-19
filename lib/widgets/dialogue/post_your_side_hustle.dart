import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class PostYourSideHustle extends StatefulWidget {
  final Function()? onTapClose;
  final Function() onPressed;
  final ValueChanged<bool> isProductSelected;

  const PostYourSideHustle(
      {super.key,
      required this.onPressed,
      this.onTapClose,
      required this.isProductSelected});

  @override
  State<PostYourSideHustle> createState() => _PostYourSideHustleState();
}

class _PostYourSideHustleState extends State<PostYourSideHustle> {
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: widget.onTapClose,
                  child: const Icon(
                    Icons.close,
                    size: 22,
                  ),
                )),
            height(.02.sh),
            textWidget(
                text: "Post your Side Hustle",
                color: AppColors.textBlackColor,
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.dialogueTextHeadingSize),
            height(.01.sh),
            textWidget(
                text:
                    "Please select what would you like to post as your side hustle",
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
                  borderRadius: BorderRadius.circular(10.0),
                  // Adjust the radius as needed
                  color: AppColors.itemBGColor,
                ),
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textWidget(
                        text: AppStrings.product,
                        color: AppColors.textBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.dialogueTextHeadingSize),
                    height(0.01.sh),
                    textWidget(
                        text: AppStrings.productDesc,
                        maxLines: 2,
                        fontSize: 16),
                  ],
                ),
              ),
            ),
            height(.02.sh),
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
                  borderRadius: BorderRadius.circular(10.0),
                  // Adjust the radius as needed
                  color: AppColors.itemBGColor,
                ),
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textWidget(
                        text: AppStrings.service,
                        color: AppColors.textBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.dialogueTextHeadingSize),
                    height(0.01.sh),
                    textWidget(
                        text: AppStrings.productDesc,
                        maxLines: 2,
                        fontSize: 16),
                  ],
                ),
              ),
            ),
            height(.03.sh),
            customMaterialButton(
                name: AppStrings.continueText,
                color: AppColors.primaryColor,
                onPressed: widget.onPressed),
          ],
        ),
      ),
    );
  }
}
