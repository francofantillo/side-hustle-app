import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_list.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/list/bullet_point_list.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewEventSelf extends StatefulWidget {
  const ViewEventSelf({super.key});

  @override
  State<ViewEventSelf> createState() => _ViewEventSelfState();
}

class _ViewEventSelfState extends State<ViewEventSelf> {
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
                  Icons.edit,
                  size: 0.05.sw,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {},
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
              const ImageSlider(),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                        text: AppStrings.viewEventMusical,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimensions.textHeadingSizeHome,
                        color: AppColors.textBlackColor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        textWidget(
                            text: AppStrings.eventPrice,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textSizeNormal,
                            color: AppColors.textBlackColor),
                        textWidget(
                          text: AppStrings.perHead,
                          fontSize: AppDimensions.textSizePerHead,
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
                      color: AppColors.greyColorNoOpacity,
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.locationText,
                          maxLines: 2,
                          fontSize: AppDimensions.textSizeVerySmall),
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
                      const AssetImage(AssetsPath.calender),
                      size: AppDimensions.applyForJobIconSize,
                      color: AppColors.greyColorNoOpacity,
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.jobDateText,
                          fontSize: AppDimensions.textSizeVerySmall),
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
                      const AssetImage(AssetsPath.time),
                      size: AppDimensions.applyForJobIconSize,
                      color: AppColors.greyColorNoOpacity,
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.eventTimeText,
                          fontSize: AppDimensions.textSizeVerySmall),
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
              SizedBox(
                width: 1.sw,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your button click logic here
                    Navigator.pushNamed(
                        context, AppRoutes.attendeesEventScreenRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    // Set the background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Make it round
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ImageIcon(
                        AssetImage(AssetsPath.attendees),
                        color: Colors.white, // Set the icon color
                        size: 17,
                      ),
                      width(0.02.sw),
                      textWidget(
                          text: AppStrings.viewAttendees,
                          color: AppColors.textWhiteColor),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventPurpose,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeNormal),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventPurposeText,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventTheme,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeNormal),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventThemeHint,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.vendorsList,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeNormal),
              ),
              height(0.01.sh),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BulletPointList(
                  itemsList: AppList.vendorsListData,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.eventAvailableAttractions,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeNormal),
              ),
              height(0.01.sh),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BulletPointList(
                  itemsList: AppList.attractionList,
                ),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.paymentType,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSizeNormal),
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
                          fontSize: AppDimensions.textSizeSmall),
                    ),
                  ],
                ),
              ),
              height(0.03.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    onPressed: () {},
                    color: AppColors.primaryColor,
                    name: AppStrings.shareEvent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
