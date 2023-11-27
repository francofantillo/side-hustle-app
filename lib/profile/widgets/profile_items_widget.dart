import 'package:flutter/material.dart';
import 'package:side_hustle/drawer/drawer_item.dart';
import 'package:side_hustle/drawer/widgets/logout_widget.dart';
import 'package:side_hustle/profile/widgets/profile_list_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
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
        ProfileItemListTile(
          iconPath: AssetsPath.paymentMethod,
          title: AppStrings.paymentMethods,
          textColor: AppColors.drawerItemColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            print("Clicked");
            Navigator.pushNamed(context, AppRoutes.paymentMethodScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        ProfileItemListTile(
          iconPath: AssetsPath.messages,
          title: AppStrings.message,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.chatAllUsersScreenRoute);
            print("Clicked");
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        ProfileItemListTile(
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
        ProfileItemListTile(
          iconPath: AssetsPath.changePassword,
          title: AppStrings.changPassword,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.changePasswordScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing - 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileItemListTile(
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
        ProfileItemListTile(
          iconPath: AssetsPath.aboutUs,
          title: AppStrings.aboutUs,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.aboutUsScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        ProfileItemListTile(
          iconPath: AssetsPath.aboutUs,
          title: AppStrings.flyerUnderCapitalism,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(
                context, AppRoutes.flyerUnderCapitalismScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        ProfileItemListTile(
          iconPath: AssetsPath.aboutUs,
          title: AppStrings.howToHustler,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.downloadBookScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        ProfileItemListTile(
          iconPath: AssetsPath.list,
          title: AppStrings.termsAndConditions,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(
                context, AppRoutes.termsAndConditionsScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        ProfileItemListTile(
          iconPath: AssetsPath.pp,
          title: AppStrings.privacyPolicy,
          textColor: AppColors.appTextBlackColor,
          fontWeight: FontWeight.w500,
          iconColor: AppColors.greyColorNoOpacity,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.privacyPolicyScreenRoute);
          },
        ),
        height(AppDimensions.drawerItemsVerticalSpacing),
        ProfileItemListTile(
          iconPath: AssetsPath.logout,
          title: AppStrings.logout,
          textColor: AppColors.appRedColor,
          iconColor: AppColors.appRedColor,
          fontWeight: FontWeight.w500,
          onTap: () {
            print("clicked Logout");
            AppDialogues.noHeaderDialogue(
                context: context,
                backgroundColor: AppColors.primaryColor,
                body: const LogoutDialogueWidget())
                .show();
          },
        ),
      ],
    );
  }
}
