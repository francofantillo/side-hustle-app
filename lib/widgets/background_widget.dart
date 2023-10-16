import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget? body;
  final Widget? drawer, bottomNavBar;

  const BackgroundWidget({Key? key, this.body, this.drawer, this.bottomNavBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        drawer: drawer,
        bottomNavigationBar: bottomNavBar,
        backgroundColor: AppColors.whiteColor,
        body: body ?? Container(),
      ),
    );
  }
}
