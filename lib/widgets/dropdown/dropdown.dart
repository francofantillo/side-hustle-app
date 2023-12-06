import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final ValueChanged<String?> selectedValue;

  const CustomDropDown(
      {super.key,
      required this.items,
      required this.selectedValue,
      this.hintText});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.w,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(AppDimensions.textFieldBorderRadius),
          // border: Border.all(color: AppColors.fieldsOutlineColor),
          boxShadow: [
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
      child: Card(
        shadowColor: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.textFieldBorderRadius),
          side: const BorderSide(width: 1, color: AppColors.fieldsOutlineColor)

        ),
        child: DropdownButtonHideUnderline(

          child: DropdownButton2<String>(
            iconStyleData:
                const IconStyleData(icon: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.blackColor,)),
            isExpanded: true,
            hint: Text(
              widget.hintText ?? 'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
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
    );
  }
}
