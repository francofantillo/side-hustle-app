import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class CheckboxWidget extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  final bool isChecked;

  const CheckboxWidget({Key? key, this.onChanged, this.isChecked = false})
      : super(key: key);

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.checkBoxRadius),
      ),
      // value: isChecked,
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
        // Call the onChanged callback if it's provided
        if (widget.onChanged != null) {
          widget.onChanged!(isChecked);
        }
      },
    );
  }
}
