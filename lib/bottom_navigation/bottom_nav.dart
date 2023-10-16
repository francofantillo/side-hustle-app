import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';

class BottomNav extends StatefulWidget {
  final int? currentIndex;
  final ValueChanged<int?> onTap;

  const BottomNav({super.key, this.currentIndex = 0, required this.onTap});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // add the curve in BottomNav
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(color: AppColors.primaryColor, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.bottomNavBGCurve),
          topRight: Radius.circular(AppDimensions.bottomNavBGCurve),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            widget.onTap(index);
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: AppColors.bottomNavBackgroundColor,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.bottomNavUnSelectedColor,
          selectedFontSize: 10.0.sp,
          unselectedFontSize: 10.0.sp,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: imageWidget(AssetsPath.home, 0), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: imageWidget(AssetsPath.sideHustle, 1), label: AppStrings.wantedJobs),
            BottomNavigationBarItem(
                icon: imageWidget(AssetsPath.eventsBottomNav, 2), label: AppStrings.events,),
            BottomNavigationBarItem(
                icon: imageWidget(AssetsPath.sideHustle, 3), label: AppStrings.sideHustle),
            BottomNavigationBarItem(
                icon: imageWidget(AssetsPath.profile, 4), label: AppStrings.profile),
          ],
        ),
      ),
    );
  }

  imageWidget(String imagePath, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 3),
      child: Image.asset(
        imagePath,
        width: 20,
        height: 25,
        color: _currentIndex == index
            ? AppColors.primaryColor
            : AppColors.bottomNavUnSelectedColor,
      ),
    );
  }
}
