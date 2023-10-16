import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final double? searchFieldSize;

  const SearchTextField({super.key, required this.onChanged, this.searchFieldSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: searchFieldSize ?? 60.h,
      child: Card(
        // elevation: AppDimensions.defaultSearchTextFieldElevation,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.textFieldBorderRadius),
            side: BorderSide(width: 1, color: AppColors.searchIconColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                top: 2.h,
                left: AppDimensions.textFieldHorizontalPadding,
                right: 6.w,
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 34,
                color: AppColors.searchIconColor,
              ),
              // border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                fontSize: 12.sp,
              ),
              hintText: AppStrings.searchHintText,
              // labelText: AppStrings.searchHintText,
              hintStyle: const TextStyle(
                color: AppColors.textFieldColor,
                fontSize: 12,
              ),
              errorMaxLines: 3,
            ),
          ),
        ),
      ),
    );
  }
}
