import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_navigation/bottom_nav.dart';
import 'package:side_hustle/drawer/app_drawer.dart';
import 'package:side_hustle/event/event.dart';
import 'package:side_hustle/home/home.dart';
import 'package:side_hustle/profile/profile.dart';
import 'package:side_hustle/side_hustle/side_hustle.dart';
import 'package:side_hustle/wanted_job/wanted_job.dart';
import 'package:side_hustle/widgets/background_widget.dart';

class BottomTabsScreen extends StatefulWidget {
  final int? currentIndex, wantedTabCurrentIndex;

  const BottomTabsScreen(
      {super.key, this.currentIndex = 0, this.wantedTabCurrentIndex = 0});

  @override
  State<BottomTabsScreen> createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  late final PageController _pageController;

  // final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _selectedIndex = 0;

  @override
  void initState() {

    // print("selectedIndex: $_selectedIndex");
    super.initState();
    _selectedIndex = widget.currentIndex!;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      drawer: const AppDrawer(),
      bottomNavBar: BottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index ?? 0);
          _selectedIndex = index ?? 0;
          setState(() {});
        },
      ),
      body: bodyContent(),
    );
  }

  bodyContent() {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          const HomeScreen(),
          WantedJobScreen(currentTabIndex: widget.wantedTabCurrentIndex!),
          const EventScreen(),
          const SideHustle(),
          const ProfileScreen()
        ],
      ),
    );
  }
}
