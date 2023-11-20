import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/profile/other_user_profile/widgets/events_posted_list.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class OtherUserEventsPostedScreen extends StatefulWidget {
  const OtherUserEventsPostedScreen({super.key});

  @override
  State<OtherUserEventsPostedScreen> createState() =>
      _OtherUserEventsPostedScreenState();
}

class _OtherUserEventsPostedScreenState
    extends State<OtherUserEventsPostedScreen> {
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
    super.initState();
  }

  List<List<Color>?>? bgColorsZero = [
    [AppColors.primaryColor],
    [Colors.transparent],
    [Colors.transparent],
    [Colors.transparent],
  ];

  List<List<Color>?>? bgColorsOne = [
    [Colors.transparent],
    [AppColors.primaryColor],
    [Colors.transparent],
    [Colors.transparent],
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contextBuilder) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return BackgroundWidget(
        showAppBar: true,
        appBarTitle: AppStrings.eventsJobPosted,
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
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Center(
                    child: CircularCacheImageWidget(
                      showLoading: false,
                      image: AssetsPath.phillipPressProfile,
                      boarderColor: AppColors.primaryColor,
                      imageHeight: 70.w,
                      imageWidth: 70.w,
                      borderWidth: .003.sh,
                    ),
                  ),
                  width(0.02.sw),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: textWidget(
                            text: AppStrings.otherUserName,
                            color: AppColors.textBlackColor,
                            fontSize: AppDimensions.textSizeNormal,
                            fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: textWidget(
                            text: AppStrings.otherUserEmail,
                            fontSize: AppDimensions.textSizeVerySmall),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            height(0.02.sh),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultHorizontalPadding + 4),
              child: textWidget(
                  text: AppStrings.eventsPosted.toUpperCase(),
                  color: AppColors.primaryColor,
                  fontSize: AppDimensions.textSizeNormal,
                  fontWeight: AppDimensions.headingFontWeight),
            ),
            const EventsPostedList(),
            height(0.03.sh),
          ],
        ),
      );
    });
  }
}
