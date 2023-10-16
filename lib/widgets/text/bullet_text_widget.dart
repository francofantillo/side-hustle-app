import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BulletedListItem extends StatelessWidget {
  final String text;

  BulletedListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      // Remove horizontal padding
      leading: Container(
        margin: EdgeInsets.only(left: 8), // Adjust margin as needed
        child: const Icon(
          Icons.brightness_1,
          size: 12.0,
          color: AppColors.textBlackColor,
        ), // Bullet point
      ),
      title: textWidget(
        text: text,
        textAlign: TextAlign.start,
      ),
    );
  }
}
