import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final double? height, contentPaddingBottom;
  final Widget? suffixIcon;
  final String hintText;

  const SearchTextField(
      {super.key,
      required this.onChanged,
      this.height,
      this.contentPaddingBottom,
      required this.hintText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    // print("design Size Width: ${ScreenUtil.defaultSize.height}");
    return Card(
      color: AppColors.fieldsOutlineColor.withOpacity(0.1),
      shadowColor: Colors.transparent,
      // elevation: AppDimensions.defaultSearchTextFieldElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.textFieldBorderRadius),
          side: const BorderSide(width: 2, color: AppColors.fieldsOutlineColor)),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        maxLines: 1,
        style: TextStyle(
            fontSize: AppDimensions.textSizeSmall,
            fontFamily: AppFont.gilroyMedium),
        decoration: InputDecoration(
          border: InputBorder.none,
          // fillColor: widget.fillColor ?? AppColors.whiteColor,
          fillColor: Colors.transparent,
          filled: true,
          // contentPadding: EdgeInsets.only(
          //     // top: suffixIcon != null ? 3.h : 0,
          //     // bottom: contentPaddingBottom ?? .003.sw,
          //     // left: AppDimensions.textFieldHorizontalPadding,
          //     right: 16.w,
          //     top: suffixIcon == null ? 2 : 5),
          contentPadding: const EdgeInsets.only(left: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 8),
            child: ImageIcon(
              AssetImage(AssetsPath.search),
              size: 18,
            ),
          ),
          // prefixIcon: ImageIcon(
          //   AssetImage(AssetsPath.search),
          //   size: 18,
          // ),
          prefixIconConstraints:
              BoxConstraints.loose(const Size.fromRadius(76)),
          // suffixIcon: const Padding(
          //   padding: EdgeInsets.only(left: 16.0, right: 8),
          //   child: ImageIcon(
          //     AssetImage(AssetsPath.searchFilter),
          //     size: 18,
          //   ),
          // ),
          suffixIcon: suffixIcon,
          suffixIconConstraints:
          BoxConstraints.loose(const Size.fromRadius(76)),
          // BoxConstraints.loose(const Size.fromRadius(5)),
          // border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: TextStyle(
              fontSize: AppDimensions.textSizeSmall,
              fontFamily: AppFont.gilroyMedium),
          hintText: hintText,
          // labelText: AppStrings.searchHintText,
          hintStyle: TextStyle(
              color: AppColors.textFieldColor,
              fontSize: AppDimensions.textSizeSmall,
              fontFamily: AppFont.gilroyMedium),
          errorMaxLines: 3,
        ),
      ),
    );
  }
}
