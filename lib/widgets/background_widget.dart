import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget? body;
  final Widget? drawer, bottomNavBar, floatingActionButton;
  final List<Widget>? actions;
  final Widget? leading;
  final String? appBarTitle;
  final bool showAppBar;
  final Color? backgroundColor;

  const BackgroundWidget(
      {Key? key,
      this.body,
      this.drawer,
      this.bottomNavBar,
      this.floatingActionButton,
      this.actions,
      this.appBarTitle,
      this.leading,
      this.backgroundColor,
      this.showAppBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawer,
        // Disable opening the drawer with a swipe gesture.
        drawerEnableOpenDragGesture: false,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: showAppBar
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: textWidget(
                    text: appBarTitle,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlackColor),
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: leading,
                leadingWidth: 0.12.sw,
                actions: actions,
              )
            : null,
        bottomNavigationBar: bottomNavBar,
        backgroundColor: backgroundColor ?? AppColors.whiteColor,
        body: body ?? Container(),
      ),
    );
  }
}
