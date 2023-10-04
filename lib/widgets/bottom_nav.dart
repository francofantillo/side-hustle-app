

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';

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
    return BottomNavigationBar(
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
      items: const <BottomNavigationBarItem>[

      ],
    );
  }
}
