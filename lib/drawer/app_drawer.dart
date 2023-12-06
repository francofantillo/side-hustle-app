import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/drawer/drawer_item.dart';
import 'package:side_hustle/drawer/widgets/logout_widget.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var _isToggleOn = false;

  @override
  Widget build(BuildContext context) {
    // widget.contextBuilder;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.drawerBGCurve),
          bottomRight: Radius.circular(AppDimensions.drawerBGCurve)),
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetsPath.drawerBg), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.rootPadding),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Cross Button at the Top
                  CircularIconButton(
                      icon: Icons.close,
                      iconSize: .06.sw,
                      iconColor: AppColors.primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: AppColors.whiteColor),
                  height(10.w),
                  height(AppDimensions.fieldsVerticalSpacingBetween),
                  textWidget(
                    text: AppStrings.sideMenu,
                    color: const Color(0xFFFCFCFC),
                    fontFamily: AppFont.gilroyBold,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.textHeadingSize,
                  ),
                  height(10.w),
                  height(AppDimensions.fieldsVerticalSpacingBetween),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularCacheImageWidget(
                        showLoading: true,
                        assetImage: AssetsPath.brandonProfile,
                        // image: AlphaAppData.dpProfile,
                      ),
                      width(0.03.sw),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                                text: AppStrings.userName,
                                color: const Color(0xFFFCFCFC),
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.textHeadingSize,
                                maxLines: 1),
                            textWidget(
                                text: AppStrings.userEmail,
                                fontSize: AppDimensions.textSizeVerySmall,
                                color: AppColors.textWhiteColor,
                                maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height(0.05.sw),
                  textWidget(
                      text: AppStrings.account.toUpperCase(),
                      color: const Color(0xFFFCFCFC),
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.textSizeSmall,
                      fontWeight: AppDimensions.headingFontWeight),
                  height(AppDimensions.drawerProfileSpacingBetween),
                  // Drawer Items
                  DrawerItemListTile(
                    iconPath: AssetsPath.drawerMessages,
                    title: AppStrings.message,
                    onTap: () {
                      print("Clicked");
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.chatAllUsersScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.favourite,
                    title: AppStrings.favorites,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.favouritesScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.changePassword,
                    title: AppStrings.changPassword,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.changePasswordScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing - 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DrawerItemListTile(
                        iconPath: AssetsPath.notification,
                        title: AppStrings.pushNotifications,
                        onTap: () {},
                      ),
                      Switch(
                        activeColor: AppColors.primaryColor,
                        activeTrackColor: AppColors.whiteColor,
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
                      text: AppStrings.supports,
                      color: AppColors.textWhiteColor,
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.drawerItemTextSize,
                      fontWeight: AppDimensions.headingFontWeight),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.aboutUs,
                    title: AppStrings.aboutUs,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.aboutUsScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.aboutUs,
                    title: AppStrings.flyerUnderCapitalism,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.flyerUnderCapitalismScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.aboutUs,
                    title: AppStrings.howToHustler,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.downloadBookScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.list,
                    title: AppStrings.termsAndConditions,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.termsAndConditionsScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.pp,
                    title: AppStrings.privacyPolicy,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, AppRoutes.privacyPolicyScreenRoute);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.delete,
                    title: AppStrings.deleteAccount,
                    onTap: () {
                      // Navigator.pushNamedAndRemoveUntil(context,
                      //     AppRoutes.loginScreenRoute, (route) => false);
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing + 20),
                  DrawerItemListTile(
                    iconPath: AssetsPath.logout,
                    title: AppStrings.logout,
                    onTap: () {
                      print("clicked Logout");
                      AppDialogues.noHeaderDialogue(
                              context: context,
                              backgroundColor: AppColors.primaryColor,
                              body: const LogoutDialogueWidget())
                          .show();
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  Center(
                    child: textWidget(
                        text: AppStrings.version,
                        color: AppColors.textWhiteColor,
                        textAlign: TextAlign.center,
                        fontSize: 12.sp),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
