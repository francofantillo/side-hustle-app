import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget? body;
  final Widget? drawer;

  const BackgroundWidget({Key? key, this.body, this.drawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        drawer: drawer,
        backgroundColor: AppColors.whiteColor,
        body: body ?? Container(),
      ),
    );
  }
}
