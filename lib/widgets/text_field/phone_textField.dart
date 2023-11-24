import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';

class PhoneNumberTextField extends StatefulWidget {
  PhoneNumberTextField({
    Key? key,
    this.controller,
    this.validator,
    this.backgroundColor,
    this.borderColor,
    this.isBorder = true,
    this.isReadOnly = false,
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
  final Color? borderColor, iconColor, textColor;
  final bool? isBorder, isUnderLineBorder;
  final bool? isReadOnly;
  final double? textFieldBorderRadius;
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
        Card(
          elevation: AppDimensions.defaultFocusedTextFieldElevation,
          // Adjust the elevation as needed
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.textFieldBorderRadius),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppDimensions.textFieldBorderRadius),
              color: widget.backgroundColor ?? Colors.white,
            ),
            height: AppDimensions.textFieldHeight, // Set the height as needed
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: _phoneTextField(),
        ),
      ],
    );
  }

  Widget _phoneTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding ?? 16.0,
      ),
      child: IntlPhoneField(
        initialValue: null,
        validator: widget.validator,
        dropdownTextStyle: _textStyle(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.phone,
        dropdownIcon: Icon(
          Icons.arrow_drop_down,
          color: widget.iconColor ?? Colors.blue,
        ),
        dropdownIconPosition: IconPosition.trailing,
        autovalidateMode: AutovalidateMode.disabled,
        // controller: widget.controller,
        controller: _textEditingController,
        style: _textStyle(),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: AppFont.gilroyMedium
          ),

          floatingLabelBehavior: FloatingLabelBehavior.always,
          counter: const SizedBox.shrink(),
          border: InputBorder.none,
          fillColor: Colors.transparent,
          // label: _label(),
          filled: true,
          hintText: AppStrings.phoneNumber,

          contentPadding: const EdgeInsets.only(top: 15),
          errorMaxLines: 2,
          errorStyle: const TextStyle(
            color: Colors.red,
            height: 1,
          ),
        ),
        onChanged: widget.onChanged,
        onCountryChanged: widget.onCountryChanged,
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: widget.textColor ?? Colors.black, fontFamily: AppFont.gilroyMedium
    );
  }

  Widget _label() {
    return Padding(
      padding: EdgeInsets.only(top: showLabel ? 16.0 : 4.0),
      child: const Text(
        AppStrings.phoneNumber,
        style: TextStyle(
          color: Colors.grey,
          fontFamily: AppFont.gilroyMedium,
          fontSize: 17,
        ),
      ),
    );
  }
}
