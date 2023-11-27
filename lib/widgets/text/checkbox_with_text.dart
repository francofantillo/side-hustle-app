import 'package:flutter/material.dart';

class CheckboxWithTextWidget extends StatefulWidget {
  const CheckboxWithTextWidget({super.key});

  @override
  State<CheckboxWithTextWidget> createState() => _CheckboxWithTextWidgetState();
}

class _CheckboxWithTextWidgetState extends State<CheckboxWithTextWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CheckboxListTile(
          title: Text('Checkbox with Text'),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text('Checkbox is checked: $isChecked'),
      ],
    );
  }
}
