import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final double? height;
  final Widget? suffixIcon;
  final String hintText;

  const SearchTextField(
      {super.key,
      required this.onChanged,
      this.height,
      required this.hintText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60.h,
      child: Card(
        // elevation: AppDimensions.defaultSearchTextFieldElevation,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.textFieldBorderRadius),
            side: BorderSide(width: 1, color: AppColors.searchIconColor)),
        child: TextFormField(
          keyboardType: TextInputType.text,
          onChanged: onChanged,
          maxLines: 1,
          style: TextStyle(fontSize: 14.sp, fontFamily: AppFont.gilroy),
          decoration: InputDecoration(
            border: InputBorder.none,
            // fillColor: widget.fillColor ?? AppColors.whiteColor,
            fillColor: Colors.transparent,
            filled: true,
            contentPadding: EdgeInsets.only(
              // top: 2.h,
              // left: AppDimensions.textFieldHorizontalPadding,
              right: 16.w,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 8),
              child: ImageIcon(AssetImage(AssetsPath.search), size: 18,),
            ),
            prefixIconConstraints:
                BoxConstraints.loose(const Size.fromRadius(76)),
            suffixIcon: suffixIcon,
            suffixIconConstraints:
                BoxConstraints.loose(const Size.fromRadius(8)),
            // border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: TextStyle(
              fontSize: 10.sp,
            ),
            hintText: hintText,
            // labelText: AppStrings.searchHintText,
            hintStyle: TextStyle(
              color: AppColors.textFieldColor,
              fontSize: 12.sp,
            ),
            errorMaxLines: 3,
          ),
        ),
      ),
    );
  }
}
