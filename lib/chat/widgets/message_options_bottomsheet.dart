import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class MessageOptionsBottomSheet extends StatelessWidget {
  const MessageOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          // height: widget.isEdit
          //     ? AppDimensions.modelSheetProductsHeight
          //     : AppDimensions.modelSheetDeliveryHeight,
          width: 1.sw,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topRight:
                Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                topLeft:
                Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
            // image: const DecorationImage(
            //     image: AssetImage(
            //         AssetsPath.drawerBg),
            //     fit: BoxFit.cover)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: textWidget(
                    text: AppStrings.messageOptions,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSizeBottomSheet,
                    fontWeight: FontWeight.w500),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    print("clicked");
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.chatBlockUsersScreenRoute);
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                    child: textWidget(
                        text: AppStrings.blockedUsers,
                        color: Color(0xFFFCFCFC),
                        fontSize: AppDimensions.textSizeVerySmall),
                  ),
                ),
              ),
              const Padding(
                  padding:
                  EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                  child: Divider(
                    color: Color(0xFFFCFCFC),
                  )
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    print("clicked");
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: textWidget(
                        text: AppStrings.help,
                        color: Color(0xFFFCFCFC),
                        fontSize: AppDimensions.textSizeVerySmall),
                  ),
                ),
              ),
              height(0.03.sh),
              Center(
                child: CircularIconButton(
                    icon: Icons.close,
                    iconSize: .09.sw,
                    iconColor: AppColors.primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.whiteColor),
              ),
              height(0.02.sw),
              Center(
                child: textWidget(
                    text: AppStrings.cancel,
                    maxLines: 2,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              height(0.1.sw),
            ],
          ),
        ),
      ],
    );
  }
}
