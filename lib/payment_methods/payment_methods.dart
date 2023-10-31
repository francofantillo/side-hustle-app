import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_delivery_address.dart';
import 'package:side_hustle/payment_methods/widgets/payment_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_button_with_icon.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class ManagePaymentMethods extends StatefulWidget {
  const ManagePaymentMethods({super.key});

  @override
  State<ManagePaymentMethods> createState() => _ManagePaymentMethodsState();
}

class _ManagePaymentMethodsState extends State<ManagePaymentMethods> {

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.managePaymentMethods,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultHorizontalPadding + 4,
            vertical: AppDimensions.defaultHorizontalPadding),
        child: SizedBox(
            width: 1.sw,
            height: 45.h,
            child: CustomMaterialButton(
              borderRadius: 16,
              onPressed: () {
                AppUtils.showBottomModalSheet(
                    context: context,
                    widget: Wrap(children: [
                      Container(
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                  AppDimensions.boarderRadiusBottomSheet),
                              topLeft: Radius.circular(
                                  AppDimensions.boarderRadiusBottomSheet)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: AppStrings.addCardDetails,
                                      color: AppColors.textWhiteColor,
                                      fontSize:
                                          AppDimensions.textSizeBottomSheet,
                                      fontWeight: FontWeight.w500),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        CustomIcon.cancel,
                                        color: AppColors.whiteColor,
                                        size: 28,
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: textWidget(
                                  text: AppStrings.addCardDetailsHint,
                                  color: AppColors.textWhiteColor,
                                  fontSize: AppDimensions.textSizeVerySmall),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 12),
                              child: CustomTextFormField(
                                height: 40.h,
                                hintText: AppStrings.nameOnCard,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 4),
                              child: CustomTextFormField(
                                height: 40.h,
                                hintText: AppStrings.cardNumber,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 4),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                           right: 4.0),
                                      child: CustomTextFormField(
                                        height: 40.h,
                                        hintText: AppStrings.expiry,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0),
                                      child: CustomTextFormField(
                                        height: 40.h,
                                        hintText: AppStrings.cVV,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height(0.02.sw),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 4),
                              child: customMaterialButton(
                                  onPressed: () {},
                                  name: AppStrings.addCard,
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
                            height(0.08.sw),
                          ],
                        ),
                      )
                    ]));
              },
              name: AppStrings.addPaymentMethod,
            )),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentList(),
          ],
        ),
      ),
    );
  }
}
