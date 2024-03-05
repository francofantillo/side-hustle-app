import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class HomeLocationWidget extends StatefulWidget {
  const HomeLocationWidget({super.key});

  @override
  State<HomeLocationWidget> createState() => _HomeLocationWidgetState();
}

class _HomeLocationWidgetState extends State<HomeLocationWidget> {
  bool isLocationExpended = false;

  @override
  void initState() {
    isLocationExpended = false;
    super.initState();
  }

  setLocationExpended({required bool isLocationExpended}) {
    this.isLocationExpended = isLocationExpended;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Stack(
        children: [
          Positioned(
            top: 0.015.sw,
            // top: 0.010.sw,
            child: Container(
              width: isLocationExpended
                  ? AppDimensions.expendedLocation
                  : AppDimensions.unExpendedLocation,
              padding: EdgeInsets.only(
                left: .07.sw,
              ),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(0.12.sw))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setLocationExpended(
                        isLocationExpended: !isLocationExpended);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 2.5, bottom: 2, right: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                          return Expanded(
                            child: textWidget(
                                // text: isLocationExpended
                                //     ? AppStrings.locationText
                                //     : "",
                                text: state.currentLocation?.locationAddress,
                                color: AppColors.textWhiteColor,
                                fontSize: AppDimensions.textSize10),
                          );
                        }),
                        Icon(
                          Icons.arrow_forward_ios,
                          // size: 0.039.sw,
                          size: 0.039.sw,
                          color: AppColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButtonWithBackground(
            iconPath: AssetsPath.location,
            borderRadius: 30,
            height: 0.08.sw,
            width: 0.08.sw,
            backgroundColor: AppColors.primaryColor,
            iconColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}
