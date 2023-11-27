import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_list.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/list/bullet_point_list.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewEvent extends StatefulWidget {
  const ViewEvent({super.key});

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  bool _isInterestedInEvent = false;

  @override
  void initState() {
    _isInterestedInEvent = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.viewEvent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 0.09.sw, // Adjust as needed
            height: 0.09.sw, // Adjust as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backIconBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  CustomIcon.forward,
                  size: 0.05.sw,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  print("clicked");
                },
              ),
            ),
          ),
        )
      ],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.rootPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ImageSlider(
                hideCameraIcon: true,
                itemImages: [
                  AssetsPath.musical,
                  AssetsPath.musical,
                  AssetsPath.musical
                ],
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                        text: AppStrings.viewEventMusical,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textHeadingSizeViewForms,
                        color: AppColors.textBlackColor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        textWidget(
                            text: AppStrings.eventPrice,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textPriceSizeViewForms,
                            color: AppColors.textBlackColor),
                        textWidget(
                          text: AppStrings.perHead,
                          color: AppColors.textBlackColor,
                          fontSize: AppDimensions.textSize10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      const AssetImage(AssetsPath.location),
                      size: AppDimensions.applyForJobIconSize,
                      color: const Color(0xFF565656),
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.locationText,
                          maxLines: 2,
                          color: const Color(0xFF565656),
                          fontSize: AppDimensions.textLocationSizeViewForms),
                    ),
                  ],
                ),
              ),
              height(0.01.sh),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: AppColors.greyColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventPostedBy,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlackColor,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms),
              ),
              height(0.01.sw),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircularCacheImageWidget(
                            showLoading: false,
                            image: AssetsPath.leoLubinProfile,
                            boarderColor: AppColors.primaryColor,
                            imageHeight: .1.sw,
                            imageWidth: .1.sw,
                          ),
                          width(.02.sw),
                          Expanded(
                            child: textWidget(
                                text: AppStrings.eventPostedProfileName,
                                fontFamily: AppFont.gilroySemiBold,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBlackColor),
                          ),
                        ],
                      ),
                    ),
                    IconButtonWithBackground(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.chatOneToOneScreenRoute,
                            arguments: const ChatOneToOne(
                              userName: AppStrings.leoLubin,
                            ));
                      },
                      iconPath: AssetsPath.message,
                      height: 0.12.sw,
                      width: 0.12.sw,
                      iconSize: 20,
                      backgroundColor: AppColors.primaryColor,
                      iconColor: AppColors.whiteColor,
                      borderRadius: 12,
                    ),
                  ],
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventPurpose,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlackColor,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventPurposeText,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingTextSizeViewForms),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventTheme,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFont.gilroyBold,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventThemeHint,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingTextSizeViewForms),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.vendorsList,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFont.gilroyBold,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms),
              ),
              height(0.01.sh),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BulletPointList(
                  itemsList: AppList.vendorsListData,
                  color: AppColors.textBlackColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventAvailableAttractions,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFont.gilroyBold,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms),
              ),
              height(0.01.sh),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BulletPointList(
                  itemsList: AppList.attractionList,
                  color: AppColors.textBlackColor,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.paymentType,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      AssetsPath.cash,
                      width: 22,
                      height: 22,
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: PaymentTypeEnum.Cash.name,
                          color: AppColors.textBlackColor,
                          fontSize:
                              AppDimensions.textSubHeadingTextSizeViewForms),
                    ),
                  ],
                ),
              ),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    onPressed: () {
                      if (_isInterestedInEvent) {
                        _isInterestedInEvent = false;
                        setState(() {});
                      } else {
                        _isInterestedInEvent = true;
                        setState(() {});
                      }
                    },
                    color: _isInterestedInEvent
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    textColor: _isInterestedInEvent
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    name: _isInterestedInEvent
                        ? AppStrings.interested
                        : AppStrings.interestedInEvent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
