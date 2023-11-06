import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/drawer/drawer_item.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
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
                  height(AppDimensions.fieldsVerticalSpacingBetween),
                  textWidget(
                      text: AppStrings.sideMenu,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.drawerHeadingSize,
                      fontWeight: AppDimensions.headingFontWeight),
                  height(AppDimensions.fieldsVerticalSpacingBetween),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularCacheImageWidget(
                        showLoading: false,
                      ),
                      width(0.03.sw),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                                text: AppStrings.userName,
                                color: AppColors.textWhiteColor,
                                maxLines: 1),
                            textWidget(
                                text: AppStrings.userEmail,
                                color: AppColors.textWhiteColor,
                                maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height(AppDimensions.drawerProfileSpacingBetween),
                  // Drawer Items
                  DrawerItemListTile(
                    iconPath: AssetsPath.messages,
                    title: AppStrings.message,
                    onTap: () {
                      print("Clicked");
                    },
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.favourite,
                    title: AppStrings.favorites,
                    onTap: () {},
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.changePassword,
                    title: AppStrings.changPassword,
                    onTap: () {},
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
                      fontSize: AppDimensions.drawerItemTextSize,
                      fontWeight: AppDimensions.headingFontWeight),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.aboutUs,
                    title: AppStrings.aboutUs,
                    onTap: () {},
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.list,
                    title: AppStrings.termsAndConditions,
                    onTap: () {},
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.pp,
                    title: AppStrings.privacyPolicy,
                    onTap: () {},
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing),
                  DrawerItemListTile(
                    iconPath: AssetsPath.delete,
                    title: AppStrings.deleteAccount,
                    onTap: () {},
                  ),
                  height(AppDimensions.drawerItemsVerticalSpacing + 20),
                  DrawerItemListTile(
                    iconPath: AssetsPath.logout,
                    title: AppStrings.logout,
                    onTap: () {
                      print("clicked Logout");
                      AppDialogues.logoutDialogue(
                          context: context,
                          body: Container(
                            color: AppColors.primaryColor,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      textWidget(
                                          text: AppStrings.logout,
                                          fontSize:
                                              AppDimensions.textHeadingSize,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor,
                                          textAlign: TextAlign.center),
                                      height(0.03.sh),
                                      textWidget(
                                          text: AppStrings.logoutMessage,
                                          fontSize: AppDimensions.textSizeSmall,
                                          color: AppColors.whiteColor,
                                          textAlign: TextAlign.center),
                                      height(0.03.sh),
                                      customMaterialButton(
                                          height: 10.h,
                                          borderRadius: 12,
                                          onPressed: () {},
                                          name: AppStrings.logout,
                                          textColor: AppColors.appRedColor,
                                          color: AppColors.whiteColor),
                                      height(0.03.sh),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: textWidget(
                                              text: AppStrings.keepMeLoggedIn,
                                              fontSize:
                                                  AppDimensions.textSizeSmall,
                                              color: AppColors.whiteColor,
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                      height(0.04.sh),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )).show();
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
