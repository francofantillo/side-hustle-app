import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/service/stripe_service.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
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
  CardDetails _card = CardDetails();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topRight:
                    Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                topLeft:
                    Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
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
                  isShowBoarder: false,
                  height: 40.h,
                  hintText: AppStrings.nameOnCard,
                  onChanged: (number) {
                    setState(() {
                      // _card = _card.copyWith(number: number);
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              // CardField(
              //   decoration: const InputDecoration(helperMaxLines: 2),
              //   onCardChanged: (cardFieldInputDetails) {
              //     // Handle card input changes
              //     print(cardFieldInputDetails
              //         ?.complete); // Card input completeness status
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 4),
                child: CustomTextFormField(
                  isShowBoarder: false,
                  height: 40.h,
                  hintText: AppStrings.cardNumber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: CustomTextFormField(
                          isShowBoarder: false,
                          height: 40.h,
                          hintText: AppStrings.expiry,
                          onChanged: (number) {
                            // setState(() {
                            //   _card = _card.copyWith(
                            //       expirationYear: int.tryParse("2024"));
                            // });
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: CustomTextFormField(
                          isShowBoarder: false,
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
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                child: CustomMaterialButton(
                    onPressed: () async {
                      // final String? id = await StripeService.createCardToken(
                      //      cardNumber: '4242424242424242',
                      //      expMonth: "12",
                      //      expYear: 2024,
                      //      cvc: '123');
                      final _cardToken = await StripeService.getCardToken();
                      print("cardToken: $_cardToken");
                      // await submitForm();
                      // print("stripe Token: $id");

                      // await widget.bloc
                      //     .addCardCubit(context: context, mounted: mounted);
                      // Navigator.pop(context);
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 24),
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
    );
  }

  submitForm() async {
    _card = _card.copyWith(number: "4242424242424242");
    _card = _card.copyWith(
        expirationMonth: int.tryParse("12"));
    _card = _card.copyWith(
        expirationYear: int.tryParse("2024"));
    _card = _card.copyWith(cvc: "123");
    try {
      await Stripe.instance.dangerouslyUpdateCardDetails(_card);

      PaymentMethod paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
              billingDetails: BillingDetails(name: "David Willy")),
        ),
      );
      // Handle the obtained paymentMethod, which contains the card token
      String cardToken = paymentMethod.id;
      print('Card token: $cardToken');
    } catch (error) {
      print('Error obtaining card token: $error');
    }
  }
}
