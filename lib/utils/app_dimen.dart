
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {

  static double buttonDefaultWidth = 0;
  static const double buttonDefaultHeight = 12;

  /// Text Size
  static double textSizeSmall = 14.sp;
  static double textSizeVerySmall = 12.sp;
  static double textSizePerHead = 10.sp;
  static double textSizeChatMessageTime = 12.sp;
  static double textSizeNormal = 16.sp;
  static double textSizeTermsAndConditions = 14.sp;
  static double textHeadingSize = 26.sp;
  static double textSizeCartText = 22.sp;
  static double textHeadingSizeHome = 22.sp;

  /// Dialogue Text Size
  static double dialogueTextHeadingSize = 18.sp;
  static double dialogueTextBodyHeadingSize = 16.sp;

  /// Text Field
  static double textFieldHeight = 55.h;
  static double textFieldBorderRadius = 15;
  static double roundedImageViewBorderRadius = 16;
  static double searchTextFieldHeight = 0.15.sw;
  static FontWeight headingFontWeight = FontWeight.w500;

  /// OTP Text Field
  static double otpTextSize = 15.sp;

  /// Login
  static double loginTopStartSpacing = .15.sh;
  // static double loginLogoSize = .13.sh;
  static double loginLogoSize = .27.sw;
  // static double downloadBookSize = .57.sw;
  static double downloadBookSize = .67.sw;
  static double welcomeBackSpacingBetween = .05.sh;
  static double fieldsVerticalSpacingBetween = .02.sh;
  static double forgotPasswordSpacingBetween = .01.sh;
  static double loginButtonVerticalSpacingBetween = .04.sh;
  static double rootPadding = 10.w;
  static double orContinueWithPadding = 24;
  static double defaultRoundedImageWidth = .3.sw;
  static double defaultRoundedImageHeight = .3.sw;
  static double socialButtonBackgroundSize = .05.sw;
  static double socialButtonImageSize = .09.sw;
  static double socialButtonGoogleBackgroundSize = .001.sw;
  static double socialButtonImageGoogleSize = .19.sw;

  /// SignUp
  static double signUpTopStartSpacing = .10.sh;
  static double agreeToSideHustleSpacing = .04.sh - 4;

  /// Elevation
  static double defaultUnFocusedTextFieldElevation = 0.02.sw;
  static double defaultCardElevation = 0.02.sw;
  static double defaultFocusedTextFieldElevation = 0.02.sw;
  static double defaultSearchTextFieldElevation = 0.01.sw;
  static double defaultButtonElevation = 0.02.sw;

  /// Material Button
  static double defaultMaterialButtonHeightHome = 10.h;
  static double defaultMaterialButtonRadiusHome = 12;

  /// Drawer
  static final double drawerIconSize = 14.h;
  static double drawerHeadingSize = 22.sp;
  static double drawerItemIconSpacing = 15.w;
  static double drawerItemTextSize = 14.sp;
  static double drawerProfileSpacingBetween = .04.sh;
  static double drawerItemsVerticalSpacing = .04.sh;
  static double drawerBGCurve = 25.h;

  /// Home
  static double drawerIconSizeHome = 40.h;
  static double profileUserNameTextSize = 12.sp;
  static double profileEmailTextSize = 14.sp;
  static double topIconsSpacing = 0.05.sw;
  static double homeSearchSpacingTop = 0.01.sh;
  static double homeSearchSpacingBelow = 0.015.sh;
  static double itemsArrowForwardIconSize = 12.h;
  static double homeFirstHorizontalListSize = 0.3.sw;
  static double homeFirstItemWidgetCurve = 15.h;
  // static double bottomButtonBGCurve = 30.h;
  static double bottomButtonBGCurve = 0.05.sh;

  /// Bottom Nav
  static double bottomNavBGCurve = 0.04.sh;

  static const double defaultHorizontalPadding = 16;
  static const double defaultButtonHorizontalPadding = 54;
  static const double defaultVerticalPadding = 16;
  static const double textFieldVerticalPadding = 6;
  static const double textFieldHorizontalPadding = 12;
  static const double defaultAllPadding = 16;
  static const double paddingEight = 12;
  static const double paddingTen = 10;
  static const double buttonVerticalPadding = 14;
  static const double floatingActionButtonPadding = 110;
  static double authFormTopPadding = 30;
  static const double constantAppBarHeightWithSearchIcon = 150;
  static double constantAppBarHeightWithOutSearchIcon = 80.h;
  static const double constantButtonHeight = 55;
  static const double fullScreenHeight = 812;
  static const double fullScreenWidth = 375;

  /// Event and Job Item
  // static double listItemHeight = 0.43.sw;
  static double listItemHeight = 0.40.sw;
  static double listItemWidth = 0.21.sw;
  static double listItemElevation = 0.02.sh;
  static double listItemImageRoundedBorder = 15.h;

  /// Event and Job Item
  static double sideHustleItemHeight = 0.41.sw;
  static double sideHustleItemWidth = 0.24.sw;

  /// Product Image Slider
  // static double productImageSliderHeight = 0.55.sw;
  static double productImageSliderHeight = 0.50.sw;
  static double productImageSliderWidth = 1.sw;

  /// Walkthrough Image Slider
  // static double productImageSliderHeight = 0.55.sw;
  static double walkthroughImageSliderHeight = .95.sh;
  static double walkthroughImageSliderWidth = 1.sw;
  static double walkthroughImageHeight = .38.sh;
  static double walkthroughImageWidth = 1.sw;

  /// Custom AppBar
  static double customAppBarTitleTextSize = 14.sp;

  /// Applied Job
  static double appliedJobRoundedBorder = 10.h;
  static double bookedJobRoundedBorder = 10.h;

  /// Apply For a Jo
  static double applyForJobIconSize = 0.03.sh;

  /// Event
  static double eventWidgetIconSize = 0.02.sh;

  /// Product
  static double boarderRadiusViewProduct = 16.w;
  static double productTextSize = 12.sp;
  // static double productOrderWidgetHeight = 0.33.sw;
  static double productOrderWidgetHeight = 0.37.sw;

  /// BottomSheet
  static double boarderRadiusBottomSheet = 25.0.h;
  static double boarderRadiusCartPlaceOrder = 16.0.h;
  // static double cartItemProductHeight = 0.39.sw;
  static double cartItemProductHeight = 0.37.sw;
  // static double cartItemServiceHeight = 0.50.sw;
  static double cartItemServiceHeight = 0.43.sw;
  // static double modelSheetDeliveryHeight = .63.sh;
  static double modelSheetDeliveryHeight = .48.sh;
  // static double modelSheetProductsHeight = .7.sh;
  static double modelSheetProductsHeight = .7.sh;
  static double modelSheetServiceHeight = .87.sh;

  static double textSizeBottomSheet = 22.sp;

  /// Shop
  static double imageWidthShop = 0.28.sw;
  static double imageWidthShopEdit = 0.4.sw;
  static double imageHeightShopEdit = 0.26.sh;
  static double imageHeightShop = 0.16.sh;
  // static double imageHeightShop = 80.h;

  /// Favourites
  static double listItemFavouritesShopHeight = 0.47.sw;

  /// Profile
  static double textSizeProfileJobs = 10.sp;

  /// My Jobs
  static double listItemScheduledHeight = 0.45.sw;
  static double listItemOnGoingHeight = 0.57.sw;
  static double listItemCompletedJobHeight = 0.57.sw;
  static double listItemJobRequestHeight = 0.38.sw;

  /// Button Border Radius
  static double buttonBorderRadius = 0.04.sw;
}