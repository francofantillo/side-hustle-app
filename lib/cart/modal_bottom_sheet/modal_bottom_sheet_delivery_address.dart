import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class BottomModalSheetDeliveryAddress extends StatefulWidget {
  final bool isEdit, isService;
  final ValueChanged<bool>? onItemAdded;

  const BottomModalSheetDeliveryAddress(
      {super.key,
      this.isEdit = false,
      this.isService = false,
      this.onItemAdded});

  @override
  State<BottomModalSheetDeliveryAddress> createState() =>
      _BottomModalSheetDeliveryAddressState();
}

class _BottomModalSheetDeliveryAddressState
    extends State<BottomModalSheetDeliveryAddress> {
  final _deliveryAddressFormKey = GlobalKey<FormState>();
  late final SideHustleCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Form(
        key: _deliveryAddressFormKey,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // height: widget.isEdit
                //     ? AppDimensions.modelSheetProductsHeight
                //     : AppDimensions.modelSheetDeliveryHeight,
                // width: 1.sw,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                          AppDimensions.boarderRadiusBottomSheet),
                      topLeft: Radius.circular(
                          AppDimensions.boarderRadiusBottomSheet)),
                  // image: const DecorationImage(
                  //     image: AssetImage(
                  //         AssetsPath.drawerBg),
                  //     fit: BoxFit.cover)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16),
                      child: textWidget(
                          text: AppStrings.deliveryAddress,
                          color: AppColors.textWhiteColor,
                          fontFamily: AppFont.gilroyBold,
                          fontSize: AppDimensions.textSizeCartText,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 4),
                      child: textWidget(
                          text: widget.isService
                              ? AppStrings.deliveryAddressServiceHint
                              : AppStrings.deliveryAddressHint,
                          maxLines: 2,
                          color: const Color(0xFFFCFCFC),
                          fontSize: AppDimensions.textSizeVerySmall),
                    ),
                    height(0.03.sw),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 0),
                      child: CustomTextFormField(
                        controller: _bloc.deliveryAddressTextController,
                        isShowBoarder: false,
                        height: 40.h,
                        hintText: AppStrings.enterCompleteAddress,
                        fieldValidator: (value) =>
                            value?.validateEmpty("Address"),
                      ),
                    ),
                    height(0.02.sw),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 4.0),
                            child: CustomTextFormField(
                              controller: _bloc.streetTextController,
                              isShowBoarder: false,
                              height: 40.h,
                              hintText: AppStrings.street,
                              fieldValidator: (value) =>
                                  value?.validateEmpty(AppStrings.street),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 12.0),
                            child: CustomTextFormField(
                              controller: _bloc.apartmentTextController,
                              isShowBoarder: false,
                              height: 40.h,
                              hintText: AppStrings.suitApartment,
                              fieldValidator: (value) => value
                                  ?.validateEmpty(AppStrings.suitApartment),
                            ),
                          ),
                        ),
                      ],
                    ),
                    height(0.03.sw),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 0),
                      child: CustomMaterialButton(
                          // height: 10.h,
                          onPressed: () {
                            if (widget.isEdit) {
                              if (_deliveryAddressFormKey.currentState!
                                  .validate()) {
                                _bloc.setDeliveryAddressCart();
                                Navigator.pop(context);
                              }
                            } else {
                              if (_deliveryAddressFormKey.currentState!
                                  .validate()) {
                                widget.onItemAdded!(true);
                                _bloc.setDeliveryAddressCart();
                                Navigator.pop(context);
                              }

                              // if (widget.isService) {
                              //   widget.onItemAdded!(true);
                              //   Navigator.pop(context);
                              // } else {
                              //   // Navigator.pop(context);
                              //   // AppUtils.showBottomModalSheet(
                              //   //     context: context,
                              //   //     widget: const ModalBottomSheetProducts(
                              //   //       isDelivery: true,
                              //   //     ));
                              //   widget.onItemAdded!(true);
                              //   Navigator.pop(context);
                              // }
                            }
                          },
                          borderRadius: 16,
                          name: widget.isEdit
                              ? AppStrings.done
                              : widget.isService
                                  ? AppStrings.confirm
                                  : AppStrings.addToCart,
                          color: AppColors.whiteColor,
                          textColor: AppColors.primaryColor),
                    ),
                    height(0.04.sw),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: Center(
                        child: textWidget(
                            text: AppStrings.cancel,
                            maxLines: 2,
                            color: AppColors.textWhiteColor,
                            fontSize: AppDimensions.textSizeSmall),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Center(
                        child: textWidget(
                            text: "",
                            maxLines: 2,
                            color: AppColors.textWhiteColor,
                            fontSize: AppDimensions.textSizeSmall),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
