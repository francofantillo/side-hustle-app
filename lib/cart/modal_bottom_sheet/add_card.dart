import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/service/stripe_service.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/utils/validation/regular_expressions.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class AddCardModalSheet extends StatefulWidget {
  final CardCubit bloc;

  const AddCardModalSheet({super.key, required this.bloc});

  @override
  State<AddCardModalSheet> createState() => _AddCardModalSheetState();
}

class _AddCardModalSheetState extends State<AddCardModalSheet> {
  final _cardFormKey = GlobalKey<FormState>();
  CardDetails _card = CardDetails();

  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _cardFormKey,
      child: Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                    topRight:
                    Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                    topLeft: Radius.circular(
                        AppDimensions.boarderRadiusBottomSheet)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(
                            text: AppStrings.addCardDetails,
                            color: AppColors.textWhiteColor,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.textSizeBottomSheet,
                            fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: textWidget(
                        text: AppStrings.addCardDetailsHint,
                        color: AppColors.textWhiteColor,
                        fontSize: AppDimensions.textSize10),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 12),
                    child: CustomTextFormField(
                      controller: _cardNameController,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(
                            Constants.firstNameFieldCharacterLength),
                      ],
                      isShowBoarder: false,
                      height: 40.h,
                      hintText: AppStrings.nameOnCard,
                      keyboardType: TextInputType.text,
                      fieldValidator: (v) =>
                          v?.validateEmpty(AppStrings.nameOnCard),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 4),
                    child: CustomTextFormField(
                        controller: _cardNumberController,
                        isShowBoarder: false,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          RegularExpressions.MASK_TEXT_FORMATTER_CARD_NO
                        ],
                        height: 40.h,
                        hintText: AppStrings.cardNumber,
                        // keyboardType: TextInputType.phone,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: false),
                        fieldValidator: (v) => v?.validateCardNumber(v)),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: CustomTextFormField(
                              controller: _cardExpiryController,
                              isReadonly: true,
                              isShowBoarder: false,
                              height: 40.h,
                              hintText: AppStrings.expiry,
                              onTap: () async {
                                final String? date =
                                await AppUtils.selectCardExpiry(
                                    context: context);
                                if (date != null) {
                                  print("date: ${date}");
                                  _cardExpiryController.text = date;
                                }
                              },
                              keyboardType: TextInputType.number,
                              fieldValidator: (v) =>
                                  v?.validateEmpty(AppStrings.expiry),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: CustomTextFormField(
                              controller: _cardCvvController,
                              isShowBoarder: false,
                              height: 40.h,
                              hintText: AppStrings.cVV,
                              keyboardType: TextInputType.number,
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              fieldValidator: (v) => v?.validateCvv(v),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height(0.02.sw),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: CustomMaterialButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_cardFormKey.currentState!.validate()) {
                            _card = _card.copyWith(
                                number: _cardNumberController.text);
                            _card = _card.copyWith(
                                expirationMonth: int.tryParse(
                                    _cardExpiryController.text
                                        .substring(0, 2)));
                            _card = _card.copyWith(
                                expirationYear: int.tryParse(
                                    _cardExpiryController.text.substring(3)));
                            _card =
                                _card.copyWith(cvc: _cardCvvController.text);
                            if (mounted) {
                              await widget.bloc.addCardCubit(
                                  context: context,
                                  mounted: mounted,
                                  cardDetails: _card,
                                  cardHolder: _cardNameController.text,
                                  last4:
                                  _cardNumberController.text.substring(15));
                            }
                          }
                        },
                        name: AppStrings.addCard,
                        color: AppColors.whiteColor,
                        textColor: AppColors.primaryColor),
                  ),
                  // height(0.15.sw),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
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
                  // height(0.02.sw),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                    child: Center(
                      child: textWidget(
                          text: AppStrings.cancel,
                          maxLines: 2,
                          color: AppColors.textWhiteColor,
                          fontSize: AppDimensions.textSizeSmall),
                    ),
                  ),
                  Center(
                    child: textWidget(
                        text: "",
                        maxLines: 2,
                        color: AppColors.textWhiteColor,
                        fontSize: AppDimensions.textSizeSmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16),
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
  }
}
