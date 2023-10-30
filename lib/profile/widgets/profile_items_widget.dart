import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/drawer/drawer_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ProfileItemsWidget extends StatefulWidget {
  const ProfileItemsWidget({super.key});

  @override
  State<ProfileItemsWidget> createState() => _ProfileItemsWidgetState();
}

class _ProfileItemsWidgetState extends State<ProfileItemsWidget> {
  var _isToggleOn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height(AppDimensions.drawerProfileSpacingBetween),
        // Drawer Items
        DrawerItemListTile(
          iconPath: AssetsPath.paymentMethod,
          title: AppStrings.paymentMethods,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            print("Clicked");
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        DrawerItemListTile(
          iconPath: AssetsPath.messages,
          title: AppStrings.message,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            print("Clicked");
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        DrawerItemListTile(
          iconPath: AssetsPath.favourite,
          title: AppStrings.favorites,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.favouritesScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        DrawerItemListTile(
          iconPath: AssetsPath.changePassword,
          title: AppStrings.changPassword,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {},
        ),
        height(AppDimensions.drawerItemsVerticalSpacing - 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawerItemListTile(
              iconPath: AssetsPath.notification,
              title: AppStrings.pushNotifications,
              textColor: AppColors.appTextBlackColor,
              fontWeight: FontWeight.w500,
              iconColor: AppColors.greyColorNoOpacity,
              onTap: () {},
            ),
            Switch(
              activeColor: AppColors.whiteColor,
              activeTrackColor: AppColors.primaryColor,
              value: _isToggleOn,
              // Set the initial value based on your toggle state
              onChanged: (newValue) {
                // Toggle the state when the switch is changed
                setState(() {
                  _isToggleOn = newValue;
                });
              },
            ),
          ],
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        textWidget(
            text: AppStrings.supports.toUpperCase(),
            color: AppColors.primaryColor,
            fontSize: AppDimensions.drawerItemTextSize,
            fontWeight: AppDimensions.headingFontWeight),
        height(AppDimensions.drawerItemsVerticalSpacing),
        DrawerItemListTile(
          iconPath: AssetsPath.aboutUs,
          title: AppStrings.aboutUs,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {},
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        DrawerItemListTile(
          iconPath: AssetsPath.list,
          title: AppStrings.termsAndConditions,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {},
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        DrawerItemListTile(
          iconPath: AssetsPath.pp,
          title: AppStrings.privacyPolicy,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {},
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        DrawerItemListTile(
          iconPath: AssetsPath.logout,
          title: AppStrings.logout,
          textColor: AppColors.appRedColor,
          iconColor: AppColors.appRedColor,
          fontWeight: FontWeight.w500,
          onTap: () {},
        ),
      ],
    );
  }
}
