import 'dart:async';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/screen_design_size.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _visible = false;
    _navigationTimer(seconds: 3);
    // _navigationTimerMilli(milliseconds: 300);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 8),
            child: customMaterialButton(
                name: AppStrings.GET_STARTED,
                // borderRadius: 20,
                onPressed: () {
                  print('Button Pressed');
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.loginScreenRoute, (route) => false);
                })),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Entry(
            scale: 0.1,
            // duration: const Duration(milliseconds: 800),
            duration: const Duration(seconds: 2, milliseconds: 500),
            // curve: Curves.easeInBack,
            // curve: Curves.easeInOutBack,
            curve: Curves.easeOutBack,
            child: Center(
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(140),
                  // borderRadius: BorderRadius.circular(100),
                ),
                child: Material(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(140),
                    // borderRadius: BorderRadius.circular(100),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    // padding: const EdgeInsets.only(left: 12, right: 12),
                    // width: .58.sw,
                    // height: .58.sw,
                    width: .5.sw,
                    height: .5.sw,
                    child: Image.asset(AssetsPath.logo),
                  ),
                ),
              ),
            ),
          ),
          height(0.5.sw)
        ],
      ),
    );
  }

  Timer _navigationTimer({required int seconds}) {
    return Timer(
        Duration(
          seconds: seconds,
        ), () {
      setState(() {
        _visible = true;
      });
    });
  }

  Timer _navigationTimerMilli({required int milliseconds}) {
    ScreenUtil.configure(
        designSize: Size(ScreenDesignSize.sw, ScreenDesignSize.sh));
    return Timer(Duration(milliseconds: milliseconds), () {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginScreenRoute, (route) => false);
    });
  }
}
