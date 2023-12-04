import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ChatOptionsBottomSheet extends StatelessWidget {
  const ChatOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppDimensions.boarderRadiusBottomSheet),
            topLeft: Radius.circular(AppDimensions.boarderRadiusBottomSheet),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: textWidget(
                text: AppStrings.chatOptions,
                color: AppColors.textWhiteColor,
                fontFamily: AppFont.gilroyBold,
                fontSize: AppDimensions.textSizeBottomSheet,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.chatBlockUsersScreenRoute);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: textWidget(
                  text: AppStrings.blockedUsers,
                  color:  const Color(0xFFFCFCFC),
                  fontSize: AppDimensions.textSizeNormal,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0),
              child: Divider(
                color: Color(0xFFFCFCFC),
              ),
            ),
            InkWell(
              onTap: () {
                print("clicked");
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0),
                child: textWidget(
                  text: AppStrings.report,
                  color: Color(0xFFFCFCFC),
                  fontSize: AppDimensions.textSizeNormal,
                ),
              ),
            ),
            const SizedBox(height: 30), // Adjust the space as needed
            Center(
              child: CircularIconButton(
                icon: Icons.close,
                iconSize: .09.sw,
                iconColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: AppColors.whiteColor,
              ),
            ),
            height(0.04.sw), // Adjust the space as needed
            Center(
              child: textWidget(
                text: AppStrings.cancel,
                maxLines: 2,
                color: AppColors.textWhiteColor,
                fontSize: AppDimensions.textSizeSmall,
              ),
            ),
            const SizedBox(height: 28), // Adjust the space as needed
          ],
        ),
      ),
    );
  }
}

