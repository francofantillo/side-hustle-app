import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class SelectPaymentTypeDropDown extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final int? cardNumber;
  final ValueChanged<String?> selectedValue;

  const SelectPaymentTypeDropDown(
      {super.key,
      required this.items,
      required this.selectedValue,
      this.cardNumber,
      this.hintText});

  @override
  State<SelectPaymentTypeDropDown> createState() =>
      _SelectPaymentTypeDropDownState();
}

class _SelectPaymentTypeDropDownState extends State<SelectPaymentTypeDropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppDimensions.defaultFocusedTextFieldElevation,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppDimensions.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: .14.sw, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    text: AppStrings.debitCreditCard,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  AssetsPath.debit,
                  height: 24,
                  width: 24,
                ),
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isDense: true,
                    isExpanded: true,
                    hint: Text(
                      widget.hintText ?? 'Select Item',
                      style: const TextStyle(
                        fontSize: 14,
                        // color: Theme.of(context).hintColor,
                        color: AppColors.blackColor,
                      ),
                    ),
                    items: widget.items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      widget.selectedValue(value);
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
