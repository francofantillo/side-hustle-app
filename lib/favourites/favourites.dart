import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/fav_list_events.dart';
import 'package:side_hustle/favourites/widgets/fav_list_jobs.dart';
import 'package:side_hustle/favourites/widgets/fav_list_shops.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contextBuilder) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return BackgroundWidget(
        showAppBar: true,
        appBarTitle: AppStrings.favorites,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child:
          backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 8),
            child: IconButtonWithBackground(
              // height: .074.sh,
              height: .10.sw,
              // width: .13.sw,
              width: .10.sw,
              borderRadius: 40,
              backgroundColor: Colors.transparent,
              iconColor: AppColors.greyColorNoOpacity,
              iconSize: 20,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.notificationsScreenRoute);
              },
              iconPath: AssetsPath.notificationBell,
            )
          )
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
            Padding(
              padding: EdgeInsets.only(left: 0.04.sw, right: 0.0425.sw, top: 8),
              child: SizedBox(
                width: 1.sw,
                child: ToggleSwitch(
                  customWidths: [.3.sw, .3.sw, .305.sw],
                  animate: true,
                  minHeight: 50.h,
                  animationDuration: 200,
                  isVertical: false,
                  // minWidth: 90,
                  cornerRadius: 18.0.w,
                  changeOnTap: true,
                  activeBgColors: const [
                    [AppColors.primaryColor],
                    [AppColors.primaryColor],
                    [AppColors.primaryColor]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: AppColors.whiteColor,
                  borderWidth: 1,
                  borderColor: [
                    AppColors.tabOutlineColor
                  ],
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: _tabIndexBasicToggle.value,
                  totalSwitches: 3,
                  labels: const [
                    AppStrings.events,
                    AppStrings.jobs,
                    AppStrings.shops,
                  ],
                  radiusStyle: true,
                  onToggle: (index) {
                    _tabIndexBasicToggle.value = index ?? 0;
                    print('switched to: ${_tabIndexBasicToggle.value}');
                    setState(() {});
                  },
                ),
              ),
            ),
            _tabIndexBasicToggle.value == 0
                ? const FavouritesListEvent()
                : _tabIndexBasicToggle.value == 1
                ? const FavouritesListJobs()
                : _tabIndexBasicToggle.value == 2
                ? const FavouritesListShops()
                : const SizedBox.shrink(),
            height(0.02.sh)
          ],
        ),
      );
    });
  }
}
