import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class MessageOptionsBottomSheet extends StatefulWidget {
  final Function()? onTap;
  final String textBlockedUserOrUnBlockedUser;
  const MessageOptionsBottomSheet({super.key, this.onTap, required this.textBlockedUserOrUnBlockedUser});

  @override
  State<MessageOptionsBottomSheet> createState() => _MessageOptionsBottomSheetState();
}

class _MessageOptionsBottomSheetState extends State<MessageOptionsBottomSheet> {
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
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                      child: textWidget(
                          text: AppStrings.messageOptions,
                          color: AppColors.textWhiteColor,
                          fontFamily: AppFont.gilroyBold,
                          fontSize: AppDimensions.textSizeBottomSheet,
                          fontWeight: FontWeight.bold),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onTap,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                          child: textWidget(
                              // text: AppStrings.blockedUsers,
                              text: widget.textBlockedUserOrUnBlockedUser,
                              color: const Color(0xFFFCFCFC),
                              fontSize: AppDimensions.textSizeNormal),
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
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
                          const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                          child: textWidget(
                              text: AppStrings.help,
                              color: Color(0xFFFCFCFC),
                              fontSize: AppDimensions.textSizeNormal),
                        ),
                      ),
                    ),
                    height(0.05.sw),
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
                    // height(10.w)
                    // height(0.15.sw),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
