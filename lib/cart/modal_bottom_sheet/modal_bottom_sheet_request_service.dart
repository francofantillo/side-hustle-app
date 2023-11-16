import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_delivery_address.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
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

  const BottomModalSheetRequestService({super.key, this.isEdit = false, this.onItemAdded});

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
                  topRight: Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                  topLeft: Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
              image: const DecorationImage(
                  image: AssetImage(AssetsPath.drawerBg), fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                child: textWidget(
                    text: AppStrings.serviceDate,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSizeBottomSheet,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                child: textWidget(
                    text: AppStrings.serviceDateHint,
                    maxLines: 2,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomTextFormField(
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
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: textWidget(
                    text: AppStrings.serviceDuration,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSizeBottomSheet,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                child: textWidget(
                    text: AppStrings.serviceDurationHint,
                    maxLines: 2,
                    color: AppColors.textWhiteColor,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              height(0.02.sh),
              // SizedBox(
              //   width: 1.sh,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //     child: CustomDropDown(
              //       items: items,
              //       hintText: AppStrings.paymentTypeHint,
              //       selectedValue: (v) {
              //         print("selectedValue: $v");
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                width: 1.sh,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomTextFormField(
                      height: 40.h,
                      hintText: AppStrings.totalHoursRequired,
                      suffixIcon: Icon(Icons.keyboard_arrow_down, size: 30,),
                      isSuffixIcon: true,
                      keyboardType: TextInputType.number,
                    )),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
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
              height(0.03.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: customMaterialButton(
                    height: 10.h,
                    onPressed: () {
                      if (widget.isEdit) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        AppUtils.showBottomModalSheet(
                            context: context,
                            widget: BottomModalSheetDeliveryAddress(
                              isEdit: false,
                              isService: true,
                              onItemAdded: widget.onItemAdded,
                            ));
                      }
                    },
                    borderRadius: 16,
                    name: AppStrings.next,
                    color: AppColors.whiteColor,
                    textColor: AppColors.primaryColor),
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
              height(0.1.sw)
            ],
          ),
        ),
      ],
    );
  }
}
