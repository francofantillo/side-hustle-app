import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            // left: 0.07.sw,
            top: 0.015.sw,
            child: Container(
              width: isLocationExpended
                  ? AppDimensions.expendedLocation
                  : AppDimensions.unExpendedLocation,
              padding: EdgeInsets.only(left: .07.sw),
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    setLocationExpended(
                        isLocationExpended: !isLocationExpended);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 2.5, bottom: 2.5, right: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: textWidget(
                              text:
                                  isLocationExpended ? AppStrings.locationText : "",
                              color: AppColors.textWhiteColor,
                              fontSize: AppDimensions.textSizePerHead),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
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
          const IconButtonWithBackground(
            iconPath: AssetsPath.location,
            borderRadius: 30,
            height: 28,
            width: 28,
            backgroundColor: AppColors.primaryColor,
            iconColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}
