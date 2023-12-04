import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_delivery_address.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class BottomModalSheetRequestService extends StatefulWidget {
  final bool isEdit;
  final ValueChanged<bool>? onItemAdded;

  const BottomModalSheetRequestService(
      {super.key, this.isEdit = false, this.onItemAdded});

  @override
  State<BottomModalSheetRequestService> createState() =>
      _BottomModalSheetRequestServiceState();
}

class _BottomModalSheetRequestServiceState
    extends State<BottomModalSheetRequestService> {
  TextEditingController dateTextController = TextEditingController();
  TextEditingController firstTimeTextController = TextEditingController();
  TextEditingController secondTimeTextController = TextEditingController();
  String? formattedDate;

  final List<String> items = [
    PaymentTypeEnum.Cash.name,
    PaymentTypeEnum.Card.name,
  ];

  @override
  void initState() {
    AppUtils.firstSelectedTime = null;
    AppUtils.secondSelectedTime = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dateTextController.text = formattedDate ?? "";
    firstTimeTextController.text = AppUtils.firstSelectedTime != null
        ? AppUtils.firstSelectedTime!.format(context)
        : "";
    secondTimeTextController.text = AppUtils.secondSelectedTime != null
        ? AppUtils.secondSelectedTime!.format(context)
        : "";

    return Wrap(
      children: [
        Container(
          // height: AppDimensions.modelSheetServiceHeight,
          // width: 1.sw,
          decoration: BoxDecoration(
              // color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                  topLeft:
                      Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
              image: const DecorationImage(
                  image: AssetImage(AssetsPath.drawerBg), fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: textWidget(
                    text: AppStrings.serviceDate,
                    color: AppColors.textWhiteColor,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textSizeCartText,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                child: textWidget(
                    text: AppStrings.serviceDateHint,
                    maxLines: 2,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSize10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8),
                child: CustomTextFormField(
                  isShowBoarder: false,
                  controller: dateTextController,
                  height: 45.h,
                  hintText: AppStrings.selectTheDate,
                  isReadonly: true,
                  suffixIcon: const ImageIcon(AssetImage(AssetsPath.calender),
                      color: AppColors.greyColorNoOpacity),
                  suffixIconScale: 0.4,
                  isSuffixIcon: true,
                  onTap: () async {
                    formattedDate = await AppUtils.selectDate(
                        context: context, initialDate: DateTime.now());
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                child: textWidget(
                    text: AppStrings.serviceDuration,
                    color: AppColors.textWhiteColor,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textSizeCartText,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                child: textWidget(
                    text: AppStrings.serviceDurationHint,
                    maxLines: 2,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSize10),
              ),
              SizedBox(
                width: 1.sh,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8),
                    child: CustomTextFormField(
                        isShowBoarder: false,
                        height: 40.h,
                        hintText: AppStrings.totalHoursRequired,
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        isSuffixIcon: true,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: false)
                        // keyboardType: TextInputType.number,
                        )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        isShowBoarder: false,
                        controller: firstTimeTextController,
                        height: 45.h,
                        hintText: AppStrings.startTime,
                        isReadonly: true,
                        isSuffixIcon: true,
                        suffixIcon: const ImageIcon(AssetImage(AssetsPath.time),
                            color: AppColors.greyColorNoOpacity),
                        suffixIconScale: 0.4,
                        onTap: () async {
                          await AppUtils.selectTime(context, true);
                          setState(() {});
                        },
                      ),
                    ),
                    width(0.01.sw),
                    Expanded(
                      child: CustomTextFormField(
                        isShowBoarder: false,
                        controller: secondTimeTextController,
                        height: 45.h,
                        hintText: AppStrings.endTime,
                        isReadonly: true,
                        isSuffixIcon: true,
                        suffixIcon: const ImageIcon(AssetImage(AssetsPath.time),
                            color: AppColors.greyColorNoOpacity),
                        suffixIconScale: 0.4,
                        onTap: () async {
                          await AppUtils.selectTime(context, false);
                          setState(() {});
                        },
                        // fillColor: AppColors.productTextFieldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 12),
                child: CustomMaterialButton(
                    // height: 10.h,
                    onPressed: () {
                      if (widget.isEdit) {
                        Navigator.pop(context);
                      } else {
                        widget.onItemAdded!(true);
                        Navigator.pop(context);
                        // Navigator.pop(context);
                        // AppUtils.showBottomModalSheet(
                        //     context: context,
                        //     widget: BottomModalSheetDeliveryAddress(
                        //       isEdit: false,
                        //       isService: true,
                        //       onItemAdded: widget.onItemAdded,
                        //     ));
                      }
                    },
                    name: AppStrings.confirm,
                    color: AppColors.whiteColor,
                    textColor: AppColors.primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 12),
                child: Center(
                  child: CircularIconButton(
                      icon: Icons.close,
                      iconSize: .09.sw,
                      iconColor: AppColors.primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: AppColors.whiteColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8, bottom: 28),
                child: Center(
                  child: textWidget(
                      text: AppStrings.cancel,
                      maxLines: 2,
                      fontFamily: AppFont.gilroySemiBold,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeSmall),
                ),
              ),
              // height(0.15.sw)
            ],
          ),
        ),
      ],
    );
  }
}
