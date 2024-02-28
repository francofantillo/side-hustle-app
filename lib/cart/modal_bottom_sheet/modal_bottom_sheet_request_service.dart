import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';
import 'package:intl/intl.dart';

class BottomModalSheetRequestService extends StatefulWidget {
  final bool isEdit;
  final int? shopId, productId;
  final ValueChanged<bool>? onItemAdded;

  const BottomModalSheetRequestService(
      {super.key,
      this.isEdit = false,
      this.onItemAdded,
      this.shopId,
      this.productId});

  @override
  State<BottomModalSheetRequestService> createState() =>
      _BottomModalSheetRequestServiceState();
}

class _BottomModalSheetRequestServiceState
    extends State<BottomModalSheetRequestService> {
  late final SideHustleCubit _bloc;
  TextEditingController dateTextController = TextEditingController();
  TextEditingController firstTimeTextController = TextEditingController();
  TextEditingController secondTimeTextController = TextEditingController();
  String? formattedDate;
  final _requestServiceFormKey = GlobalKey<FormState>();

  final List<String> items = [
    PaymentTypeEnum.Cash.name,
    PaymentTypeEnum.Card.name,
  ];

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    _bloc.initRequestServiceControllers();
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

    return Form(
      key: _requestServiceFormKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // height: AppDimensions.modelSheetServiceHeight,
              // width: 1.sw,
              decoration: BoxDecoration(
                  // color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                          AppDimensions.boarderRadiusBottomSheet),
                      topLeft: Radius.circular(
                          AppDimensions.boarderRadiusBottomSheet)),
                  image: const DecorationImage(
                      image: AssetImage(AssetsPath.drawerBg),
                      fit: BoxFit.cover)),
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
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                    child: textWidget(
                        text: AppStrings.serviceDateHint,
                        maxLines: 2,
                        color: AppColors.textWhiteColor,
                        fontSize: AppDimensions.textSize10),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 8),
                    child: CustomTextFormField(
                      isShowBoarder: false,
                      controller: _bloc.serviceDateTextController,
                      fieldValidator: (value) =>
                          value?.validateEmpty(AppStrings.serviceDate),
                      height: 45.h,
                      hintText: AppStrings.selectTheDate,
                      isReadonly: true,
                      suffixIcon: ImageIcon(
                          const AssetImage(AssetsPath.calender),
                          size: AppDimensions.imageIconSizeTextFormField,
                          color: AppColors.greyColorNoOpacity),
                      suffixIconScale: 0.4,
                      isSuffixIcon: true,
                      onTap: () async {
                        final String? formattedDate = await AppUtils.selectDate(
                            context: context, initialDate: DateTime.now());
                        if (formattedDate != null) {
                          _bloc.serviceDateTextController.text =
                              formattedDate ?? "";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                    child: textWidget(
                        text: AppStrings.serviceDuration,
                        color: AppColors.textWhiteColor,
                        fontFamily: AppFont.gilroyBold,
                        fontSize: AppDimensions.textSizeCartText,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 4),
                    child: textWidget(
                        text: AppStrings.serviceDurationHint,
                        maxLines: 2,
                        color: AppColors.textWhiteColor,
                        fontSize: AppDimensions.textSize10),
                  ),
                  SizedBox(
                    width: 1.sh,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 8),
                        child: CustomTextFormField(
                            controller: _bloc.serviceHoursTextController,
                            fieldValidator: (value) => value
                                ?.validateEmpty(AppStrings.totalHoursRequired),
                            isShowBoarder: false,
                            height: 40.h,
                            hintText: AppStrings.totalHoursRequired,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              size: AppDimensions.imageIconSizeTextFormField,
                            ),
                            isSuffixIcon: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: false)
                            // keyboardType: TextInputType.number,
                            )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: CustomTextFormField(
                              controller: _bloc.serviceStartTimeTextController,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.startTime),
                              isShowBoarder: false,
                              elevation: 0,
                              height: 45.h,
                              hintText: AppStrings.startTime,
                              isReadonly: true,
                              isSuffixIcon: true,
                              // suffixIcon: ImageIcon(const AssetImage(AssetsPath.time),
                              //     size: AppDimensions.imageIconSizeTextFormField,
                              //     color: AppColors.greyColorNoOpacity),
                              suffixIcon: Icon(
                                Icons.access_time_filled_rounded,
                                size: AppDimensions.imageIconSizeTextFormField,
                                color: AppColors.greyColorNoOpacity,
                              ),
                              suffixIconScale: 0.4,
                              onTap: () async {
                                await AppUtils.selectTime(context, true);
                                print(
                                    "selected time: ${AppUtils.firstSelectedTime}");
                                if (mounted) {
                                  if (AppUtils.firstSelectedTime != null) {
                                    final String firstTime =
                                        AppUtils.formatTimeOfDay(
                                            AppUtils.firstSelectedTime!);
                                    _bloc.serviceStartTimeTextController.text =
                                        firstTime;
                                    print(
                                        "Start Time: ${_bloc.serviceStartTimeTextController.text}");
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        width(0.01.sw),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: CustomTextFormField(
                              controller: _bloc.serviceEndTimeTextController,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.endTime),
                              elevation: 0,
                              isShowBoarder: false,
                              height: 45.h,
                              hintText: AppStrings.endTime,
                              isReadonly: true,
                              isSuffixIcon: true,
                              suffixIcon: Icon(
                                Icons.access_time_filled_rounded,
                                size: AppDimensions.imageIconSizeTextFormField,
                                color: AppColors.greyColorNoOpacity,
                              ),
                              suffixIconScale: 0.4,
                              onTap: () async {
                                await AppUtils.selectTime(context, false);
                                if (mounted) {
                                  if (AppUtils.secondSelectedTime != null) {
                                    final String endTime =
                                        AppUtils.formatTimeOfDay(
                                            AppUtils.secondSelectedTime!);
                                    _bloc.serviceEndTimeTextController.text =
                                        endTime;
                                    print(
                                        "End Time: ${_bloc.serviceEndTimeTextController.text}");
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 12),
                    child: CustomMaterialButton(
                        // height: 10.h,
                        onPressed: () async {
                          if (widget.isEdit) {
                            Navigator.pop(context);
                          } else {
                            if (_requestServiceFormKey.currentState!
                                .validate()) {
                              EasyLoading.instance.indicatorColor =
                                  AppColors.whiteColor;
                              var inputFormat = DateFormat('MM/dd/yyyy');
                              var inputDate = inputFormat.parse(_bloc
                                  .serviceDateTextController
                                  .text); // <-- dd/MM 24H format

                              var outputFormat = DateFormat('yyyy/MM/dd');
                              String outputDate =
                                  outputFormat.format(inputDate);
                              print(
                                  outputDate); // 12/31/2000 11:59 PM <-- MM/dd 12H format
                              await _bloc
                                  .addToCartCubit(
                                      context: context,
                                      mounted: mounted,
                                      shopId: widget.shopId,
                                      productId: widget.productId,
                                      date: outputDate,
                                      startTime: DateTimeConversions
                                          .convertTo24HourFormat(_bloc
                                              .serviceStartTimeTextController
                                              .text),
                                      endTime: DateTimeConversions
                                          .convertTo24HourFormat(_bloc
                                              .serviceEndTimeTextController
                                              .text),
                                      totalHours: int.parse(_bloc
                                          .serviceHoursTextController.text))
                                  .then((value) {
                                EasyLoading.instance.indicatorColor =
                                    AppColors.primaryColor;
                                if (value == 1) {
                                  widget.onItemAdded!(true);
                                  Navigator.pop(context);
                                }
                              });
                            }
                          }
                        },
                        name: AppStrings.confirm,
                        color: AppColors.whiteColor,
                        textColor: AppColors.primaryColor),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 12),
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
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, top: 8, bottom: 28),
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
        ),
      ),
    );
  }
}
