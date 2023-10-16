import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class DrawerItemListTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function()? onTap;

  const DrawerItemListTile(
      {super.key, required this.iconPath, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            iconPath,
            color: AppColors.whiteColor,
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
              color: AppColors.textWhiteColor,
              textAlign: TextAlign.start,
              fontSize: AppDimensions.drawerItemTextSize,
            ),
          ),
        ],
      ),
    );
  }
}

