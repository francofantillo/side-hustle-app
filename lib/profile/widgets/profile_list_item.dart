import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ProfileItemListTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final Color? textColor, iconColor;
  final Function()? onTap;
  final FontWeight? fontWeight;

  const ProfileItemListTile(
      {super.key,
        required this.iconPath,
        this.textColor,
        this.iconColor,
        required this.title,
        this.fontWeight,
        this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            iconPath,
            color: iconColor ?? AppColors.drawerItemColor,
            // color: AppColors.drawerItemColor,
            width: AppDimensions.drawerIconSize,
            height: AppDimensions.drawerIconSize,
          ),
          width(AppDimensions.drawerItemIconSpacing),
          InkWell(
            onTap: onTap,
/*            overlayColor: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                print("called MaterialStateProperty");
                return Colors.white;
              }
              return Colors.blue;
            }),*/
            child: textWidget(
                text: title,
                color: textColor ?? AppColors.drawerItemColor,
                // color: AppColors.drawerItemColor,
                textAlign: TextAlign.start,
                fontFamily: AppFont.gilroySemiBold,
                fontSize: AppDimensions.drawerItemTextSize,
                // fontWeight: fontWeight),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
