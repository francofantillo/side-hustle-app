import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/custom_tab_bar_fav.dart';
import 'package:side_hustle/favourites/widgets/fav_list_events.dart';
import 'package:side_hustle/favourites/widgets/fav_list_jobs.dart';
import 'package:side_hustle/favourites/widgets/fav_list_shops.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class FavouritesScreen extends StatefulWidget {
  final bool isFromDrawer;

  const FavouritesScreen({super.key, this.isFromDrawer = false});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late final FavouritesCubit _bloc;
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    isProductSelected = true;
    getFavourites();
    super.initState();
  }

  getFavourites() async {
    if (_tabIndexBasicToggle.value == 0) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getFavouritesCubit(
          context: context, mounted: mounted, type: Favourites.Event.name);
    } else if (_tabIndexBasicToggle.value == 1) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getFavouritesCubit(
          context: context, mounted: mounted, type: Favourites.Job.name);
    } else if (_tabIndexBasicToggle.value == 2) {
      print("called API at index: ${_tabIndexBasicToggle.value}");
      await _bloc.getFavouritesCubit(
          context: context, mounted: mounted, type: Favourites.Shop.name);
    }
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
                  Navigator.pushNamed(
                      context, AppRoutes.notificationsScreenRoute);
                },
                iconPath: AssetsPath.notificationBell,
              ))
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
            Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, top: 0.02.sw),
              child: CustomTabBarFav(
                currentTabIndex: _tabIndexBasicToggle.value,
                tabNames: const [
                  AppStrings.events,
                  AppStrings.jobs,
                ],
                onChanged: (index) {
                  _tabIndexBasicToggle.value = index ?? 0;
                  print('switched to: ${_tabIndexBasicToggle.value}');
                  getFavourites();
                  setState(() {});
                },
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
