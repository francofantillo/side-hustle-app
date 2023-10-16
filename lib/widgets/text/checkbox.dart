import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;

  const CheckboxWidget({Key? key, this.onChanged}) : super(key: key);

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
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