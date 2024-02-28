import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/drawer/widgets/logout_widget.dart';
import 'package:side_hustle/profile/widgets/profile_list_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
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
          iconPath: AssetsPath.drawerMessages,
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
        height(AppDimensions.drawerItemsVerticalSpacing - 10),
        BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          return Row(
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
                // value: _isToggleOn,
                value: (state.userModel?.data?.isPushNotification?.isEmpty ??
                        false)
                    ? false
                    : state.userModel?.data?.isPushNotification! == "1"
                        ? true
                        : false,
                // Set the initial value based on your toggle state
                onChanged: (newValue) async {
                  // Toggle the state when the switch is changed
                  // setState(() {
                  //   _isToggleOn = newValue;
                  // });
                  print("New Value: $newValue");
                  final AuthCubit _bloc = BlocProvider.of(context);
                  await _bloc.allowPushCubit(
                      context: context,
                      mounted: mounted,
                      isAllow: newValue ? 1 : 0);
                },
              ),
              // FlutterSwitch(
              //   value: _isToggleOn,
              //   width: 40,
              //   height: 20,
              //   padding: 3.5,
              //   // activeColor: Color(0xFFFF4747),
              //   // inactiveColor: Color(0xff565656),
              //   // toggleColor: Color(0xffFCFCFC),
              //   onToggle: (val) {
              //     setState(() {
              //       _isToggleOn = val;
              //     });
              //   },
              // ),
              // Container(
              //   height: 20,
              //   width: 40,
              //   child: FlutterSwitch(
              //     borderRadius: 30,
              //     value: _isToggleOn,
              //     onToggle: (value) {
              //       setState(() {
              //         _isToggleOn = value;
              //       });
              //     },
              //   ),
              // ),
            ],
          );
        }),
        // height(AppDimensions.drawerItemsVerticalSpacing),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: textWidget(
              text: AppStrings.supports.toUpperCase(),
              color: AppColors.primaryColor,
              fontFamily: AppFont.gilroyBold,
              fontSize: AppDimensions.drawerItemTextSize,
              fontWeight: FontWeight.bold),
        ),
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
