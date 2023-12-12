import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final bool? isPasswordField, isSuffixIcon, isReadonly;
  final bool isPrefixIcon, isShowShadow, isShowBoarder;
  final String? prefixIconPath;
  final Color? prefixIconColor;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final double? suffixIconScale;
  final int? maxLines;
  final Function()? onTap;
  final TextEditingController? controller;

  // final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double? height, top, bottom;
  final Function(String)? onFieldSubmitted;
  final Color? labelColor;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? containerColor;
  final bool? isForCard;
  final double? labelFontSize;
  final double? elevation;
  final double? errorFontSize;

  // final TextEditingController? controller;
  final String? Function(String?)? fieldValidator;
  final List<TextInputFormatter>? inputFormatter;

  const CustomTextFormField({
    super.key,
    this.label,
    this.onFieldSubmitted,
    this.isPrefixIcon = false,
    this.elevation,
    this.isShowShadow = false,
    this.isShowBoarder = true,
    this.isPasswordField = false,
    this.focusNode,
    this.prefixIconPath,
    this.prefixIconColor,
    this.keyboardType = TextInputType.text,
    this.isSuffixIcon = false,
    this.suffixIconScale,
    this.suffixIcon,
    this.hintText,
    this.maxLines,
    this.onChanged,
    // this.validator,
    this.onTap,
    this.controller,
    this.height,
    this.fieldValidator,
    this.top,
    this.bottom = 0,
    this.isReadonly = false,
    this.labelColor,
    this.fillColor,
    this.containerColor,
    this.isForCard,
    this.labelFontSize,
    this.inputFormatter,
    this.errorFontSize,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isvisible = false;
  bool textVisible = false;
  late FocusNode _focusNode;
  late bool _isFocused;

  bool isVisible = true;

  @override
  void initState() {
    textVisible = widget.isPasswordField!;
    super.initState();
    _isFocused = false;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {}

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              // border: widget.isShowBoarder
              //     ? Border.all(color: AppColors.fieldsOutlineColor)
              //     : null,
              boxShadow: widget.isShowShadow
                  ? [
                BoxShadow(
                  // color: Colors.grey.withOpacity(.15),
                  color: Colors.grey.withOpacity(.15),
                  blurRadius: 12.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: const Offset(
                    0.0, // Move to right 10  horizontally
                    9.0, // Move to bottom 10 Vertically
                  ),
                )
              ]
                  : [
                BoxShadow(
                  color: Colors.grey.withOpacity(.01),
                  blurRadius: 12.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: const Offset(
                    0.0, // Move to right 10  horizontally
                    9.0, // Move to bottom 10 Vertically
                  ),
                )
              ]),
          // : null),
          child: Card(
            // elevation: _isFocused
            //     ? AppDimensions.defaultFocusedTextFieldElevation
            //     : AppDimensions.defaultUnFocusedTextFieldElevation,
            elevation: widget.elevation ?? 2,
            // shadowColor: Colors.grey.withOpacity(0.35), // Lighten shadow color
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              side: widget.isShowBoarder
                  ? const BorderSide(
                  width: 1, color: AppColors.fieldsOutlineColor)
                  : BorderSide.none,
            ),
            child: Container(
              // padding: EdgeInsets.only(top: 4.h),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(AppDimensions.textFieldBorderRadius),
                border:
                Border.all(color: widget.fillColor ?? AppColors.whiteColor),
                color: widget.fillColor ?? AppColors.whiteColor,
              ),
              // height: widget.height ?? AppDimensions.textFieldHeight,
              child: textFormField(),
            ),
          ),
        ),
      ],
    );
  }

  Widget textFormField() {
    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: _focusNode,
      inputFormatters: widget.inputFormatter,
      validator: widget.fieldValidator,
      keyboardType: widget.keyboardType,
      obscureText: textVisible,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      controller: widget.controller,
      readOnly: widget.isReadonly!,
      maxLines: widget.maxLines ?? 1,
      style: TextStyle(fontSize: 14.sp, fontFamily: AppFont.gilroyMedium),
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.transparent,
        // fillColor: widget.fillColor ?? Colors.transparent,
        filled: true,
        contentPadding: const EdgeInsets.only(left: 8),
        prefixIcon: widget.isPrefixIcon!
            ? Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: _prefixIconWidget(),
        )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(
            fontSize: AppDimensions.textSizeSmall,
            fontFamily: AppFont.gilroyMedium),
        hintText: widget.label ?? widget.hintText,
        errorStyle: _errorTextStyle(),
        hintStyle: const TextStyle(
            color: AppColors.hintTextFieldColor,
            fontSize: 15,
            overflow: TextOverflow.visible),
        errorMaxLines: 3,
        suffixIcon: widget.isPasswordField!
            ? Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: _passwordSuffixIconWidget(),
        )
            : widget.isSuffixIcon!
            ? Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: _suffixIconWidget(),
        )
            : null,
        suffixIconConstraints: BoxConstraints.loose(const Size.fromRadius(76)),
        prefixIconConstraints: BoxConstraints.loose(const Size.fromRadius(76)),
      ),
    );
  }

  Transform _prefixIconWidget() {
    return Transform.scale(
      scale: 0.5,
      child: ImageIcon(
        AssetImage(widget.prefixIconPath!),
        color: widget.prefixIconColor ?? AppColors.primaryColor,
      ),
    );
  }

  GestureDetector _suffixIconWidget() {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.suffixIcon,
    );
  }

  Widget _label() {
    return textWidget(
      text: widget.label ?? '',
      color: widget.labelColor ?? AppColors.labelColor,
    );
  }

  TextStyle _errorTextStyle() {
    return TextStyle(
        fontSize: AppDimensions.textSizeVerySmall,
        color: AppColors.redColor,
        // height: .05);
        );
  }

  GestureDetector _passwordSuffixIconWidget() {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 0.w),
        child: ImageIcon(
          AssetImage(isVisible ? AssetsPath.eyeClosed : AssetsPath.eyeOpen),
          color: AppColors.blackColor,
          size: 18,
        ),
      ),
      onTap: () {
        setState(() {
          isVisible = !isVisible;
          textVisible = !textVisible;
        });
      },
    );
  }
}
