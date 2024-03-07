import 'dart:async';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/service/socket_ibis_service.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;
  late final AuthCubit _bloc;

  @override
  void initState() {
    super.initState();
    print("Splash Screen called");
    _bloc = BlocProvider.of<AuthCubit>(context);
    _visible = false;
    _connectSocket();
    _navigationTimer(seconds: 3);
    // _navigationTimerMilli(milliseconds: 300);
  }

  _isLogin() async {
    await _bloc.isLogin(context: context, mounted: mounted);
  }

  void _connectSocket() {
    SocketService.instance?.initializeSocket();
    SocketService.instance?.connectSocket();
    SocketService.instance?.socketResponseMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: _visible
            ? Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 8),
                child: CustomMaterialButton(
                    name: AppStrings.GET_STARTED,
                    // borderRadius: 20,
                    onPressed: () {
                      print('Button Pressed');
                      Navigator.pushNamedAndRemoveUntil(context,
                          AppRoutes.loginScreenRoute, (route) => false);
                    }))
            : const SizedBox.shrink(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Entry(
            scale: 0.1,
            duration: const Duration(seconds: 2, milliseconds: 500),
            curve: Curves.easeOutBack,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(140),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                      offset: const Offset(
                        0.0, // Move to right 10  horizontally
                        0.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Card(
                  shadowColor: Colors.transparent,
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(140),
                  ),
                  child: Material(
                    shadowColor: Colors.transparent,
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(140),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      width: .5.sw,
                      height: .5.sw,
                      child: Image.asset(AssetsPath.logo),
                    ),
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
        ), () async {
      await _isLogin();
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }
}
