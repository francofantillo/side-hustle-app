import 'dart:async';

import 'package:flutter/material.dart';
import 'package:side_hustle/router/app_route_named.dart';

class SplashTransParentScreen extends StatefulWidget {
  const SplashTransParentScreen({super.key});

  @override
  State<SplashTransParentScreen> createState() => _SplashTransParentScreenState();
}

class _SplashTransParentScreenState extends State<SplashTransParentScreen> {
  @override
  void initState() {
    super.initState();
    _navigationTimer(milliseconds: 300);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //     padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8),
      //     child: customMaterialButton(
      //         name: AppStrings.GET_STARTED, onPressed: () {
      //       print('Button Pressed');
      //       Navigator.pushNamedAndRemoveUntil(
      //           context, AppRoutes.loginScreenRoute, (route) => false);
      //     })),
    );
  }

  Timer _navigationTimer({required int milliseconds}) {
    // ScreenUtil.configure(designSize: Size(ScreenDesignSize.sw, ScreenDesignSize.sh));
    return Timer(Duration(milliseconds: milliseconds), () {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.splashScreenRoute, (route) => false);
    });
  }
}
