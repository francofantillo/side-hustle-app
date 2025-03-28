import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({
    Key? key,
    this.controller,
    this.initialValue,
    this.validator,
    this.backgroundColor,
    this.borderColor,
    this.isBorder = true,
    this.isReadOnly = false,
    this.isShowShadow = false,
    this.isUnderLineBorder = true,
    this.textFieldBorderRadius,
    this.contentPadding,
    this.iconColor,
    this.textColor,
    this.onCountryChanged,
    this.onChanged,
    this.horizontalPadding,
    this.verticalPadding,
  }) : super(key: key);

  final Color? backgroundColor;
  final String? initialValue;
  final Color? borderColor, iconColor, textColor;
  final bool? isBorder, isUnderLineBorder;
  final bool? isReadOnly;
  final double? textFieldBorderRadius;
  final bool isShowShadow;
  final EdgeInsets? contentPadding;
  final double? horizontalPadding, verticalPadding;
  final TextEditingController? controller;
  final ValueChanged<Country?>? onCountryChanged;
  final ValueChanged<PhoneNumber?>? onChanged;
  final Future<String?> Function(PhoneNumber?)? validator;

  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  bool showLabel = true;
  late TextEditingController _textEditingController;
  double emptyLabelPadding = 16;
  double notEmptyPadding = 16;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      showLabel = _textEditingController.text.isEmpty;
    });
  }

  @override
  void dispose() {
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
              boxShadow: widget.isShowShadow
                  ? [
                      BoxShadow(
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
          height: 55.w,
          child: Card(
            elevation: 2,
            // shadowColor: Colors.grey.withOpacity(0.35), // Lighten shadow color
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDimensions.textFieldBorderRadius),
            ),
            child: Container(
              // padding: EdgeInsets.only(top: 4.h),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.textFieldBorderRadius),
                border: Border.all(color: AppColors.whiteColor),
                color: AppColors.whiteColor,
              ),
              child: _phoneTextField(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _phoneTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10),
      child: IntlPhoneField(
        initialValue: widget.initialValue,

        validator: widget.validator,
        dropdownTextStyle: _textStyle(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.phone,
        dropdownIcon: const Icon(
          Icons.keyboard_arrow_down,
          // color: widget.iconColor ?? AppColors.greyColor,
          color: Color(0xff757575),
        ),
        dropdownIconPosition: IconPosition.trailing,
        autovalidateMode: AutovalidateMode.disabled,
        // controller: widget.controller,
        controller: _textEditingController,
        style: _textStyle(),
        decoration: InputDecoration(
          hintStyle:
              const TextStyle(color: Colors.grey, fontFamily: AppFont.gilroyMedium, height: .9),

          floatingLabelBehavior: FloatingLabelBehavior.always,
          counter: const SizedBox.shrink(),
          border: InputBorder.none,
          fillColor: Colors.transparent,
          // label: _label(),
          filled: true,
          hintText: AppStrings.phoneNumber,

          // contentPadding: const EdgeInsets.only(top: 7),
          errorMaxLines: 2,
          // errorStyle: TextStyle(
          //   color: Colors.red,
          //   height: 1,
          // ),
          errorStyle: _errorTextStyle(),
        ),
        onChanged: widget.onChanged,
        onCountryChanged: widget.onCountryChanged,
      ),
    );
  }

  TextStyle _errorTextStyle() {
    return TextStyle(
        fontSize: AppDimensions.textSizeVerySmall, color: AppColors.redColor, height: 0.01);
  }

  TextStyle _textStyle() {
    return TextStyle(
        color: widget.textColor ?? Colors.black,
        fontFamily: AppFont.gilroyMedium);
  }
}
