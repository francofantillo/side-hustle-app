import 'dart:async';

import 'package:flutter/material.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/custom_material_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _navigationTimer(seconds: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8),
          child: customMaterialButton(
              name: AppStrings.GET_STARTED, onPressed: () {
            print('Button Pressed');
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreenRoute, (route) => false);
          })),
    );
  }

  Timer _navigationTimer({required int seconds}) {
    return Timer(Duration(seconds: seconds), () {});
  }
}
