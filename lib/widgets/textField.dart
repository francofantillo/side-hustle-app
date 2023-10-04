import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/text_widget.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final bool? isPasswordField, isSuffixIcon, isReadonly;
  final bool isPrefixIcon;
  final String? prefixIconPath;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final int? maxLines;
  final Function()? onTap;
  final TextEditingController? controller;

  // final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double? height, top, bottom;
  final Color? lableColor;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? containerColor;
  final bool? isForCard;
  final double? labelFontSize;
  final double? errorFontSize;

  // final TextEditingController? controller;
  final String? Function(String?)? fieldValidator;
  final List<TextInputFormatter>? inputFormatter;

  const CustomTextFormField({
    super.key,
    this.label,
    this.isPrefixIcon = false,
    this.isPasswordField = false,
    this.focusNode,
    this.prefixIconPath,
    this.keyboardType = TextInputType.text,
    this.isSuffixIcon = false,
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
    this.lableColor,
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

  // late bool texVisible;
  bool isVisible = true;

  @override
  void initState() {
    textVisible = widget.isPasswordField!;
    super.initState();
    _isFocused = false;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // setState(() {
    //   _isFocused = _focusNode.hasFocus;
    // });
  }

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
        Card(
          elevation: _isFocused
              ? AppDimensions.defaultFocusedTextFieldElevation
              : AppDimensions.defaultUnFocusedTextFieldElevation,
          // Adjust the elevation as needed
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.textFieldBorderRadius),
          ),
          child: Container(
            // padding: EdgeInsets.only(top: 10.h),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              border:
                  Border.all(color: widget.fillColor ?? AppColors.whiteColor),
              color: widget.fillColor ?? AppColors.whiteColor,
            ),
            height: widget.height ?? AppDimensions.textFieldHeight,
          ),
        ),
        textFormField(),
      ],
    );
  }

  Widget textFormField() {
    return TextFormField(
      focusNode: _focusNode,
      inputFormatters: widget.inputFormatter,
      validator: widget.fieldValidator,
      // focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      obscureText: textVisible,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      controller: widget.controller,
      readOnly: widget.isReadonly!,
      maxLines: widget.maxLines ?? 1,
      style: TextStyle(fontSize: 14.sp, fontFamily: AppFont.gilroy),
      decoration: InputDecoration(
        border: InputBorder.none,
        // fillColor: widget.fillColor ?? AppColors.whiteColor,
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.only(
          top: 8.h,
          bottom: 8.h,
          left: AppDimensions.textFieldHorizontalPadding,
          right: AppDimensions.textFieldHorizontalPadding,
        ),
        prefixIcon: widget.isPrefixIcon! ? _prefixIconWidget() : null,
        // border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        label: widget.label != null ? _label() : null,
        labelStyle: TextStyle(
          fontSize: 15.sp,
        ),
        hintText: widget.hintText,
        errorStyle: _errorTextStyle(),
        hintStyle: const TextStyle(
          color: AppColors.textFieldColor,
          fontSize: 15,
        ),
        errorMaxLines: 3,
        suffixIcon: widget.isPasswordField!
            ? _passwordSuffixIconWidget()
            : widget.isSuffixIcon!
                ? _suffixIconWidget()
                : null,
      ),
    );
  }

  Transform _prefixIconWidget() {
    return Transform.scale(
      scale: 0.5,
      child: ImageIcon(
        AssetImage(widget.prefixIconPath!),
        color: AppColors.primaryColor,
      ),
    );
  }

  GestureDetector _suffixIconWidget() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Transform.scale(
        scale: 0.6,
        child: widget.suffixIcon,
      ),
    );
  }

  // Widget _label() {
  //   return CustomText(
  //     text: widget.label,
  //     color: widget.lableColor ?? AppColors.labelColor,
  //     // fontWeight: FontWeight.bold,
  //     fontSize: widget.labelFontSize ?? 12,
  //     fontFamily: AppFont.jostRegular,
  //   );
  // }
  Widget _label() {
    return textWidget(
      text: widget.label ?? '',
      color: widget.lableColor ?? AppColors.labelColor,
      //  fontSize: 17.sp,
    );
  }

  TextStyle _errorTextStyle() {
    return TextStyle(
        fontSize: widget.errorFontSize ?? 15, color: AppColors.redColor);
  }

  GestureDetector _passwordSuffixIconWidget() {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Transform.scale(
          scale: 0.3,
          // child: Icon(
          //   // isVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          //   isVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          //   color: AppColors.eyeGreyColor,
          //   size: 40,
          // ),
          child: Image.asset(
            isVisible ? AssetsPath.eyeClosed : AssetsPath.eyeOpen,
            width: 40,
            height: 40,
            color: AppColors.eyeGreyColor,
          ),
          // child: ImageIcon(
          //   AssetImage(isVisible ? AssetPath.EYE_ICON : AssetPath.EYE_ICON),
          //   color: AppColors.greyColor,
          // ),
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
