import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class PaymentItem extends StatelessWidget {
  final String? cardNumber;
  final bool defaultCard;
  final ValueChanged<bool?> onChanged;

  const PaymentItem({super.key, this.cardNumber, required this.defaultCard, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    print("widget.defaultCard : $defaultCard ");
    return Container(
      decoration: BoxDecoration(
          color: AppColors.itemBGColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AssetsPath.debit,
              height: 24,
              width: 24,
            ),
            width(0.03.sw),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(text: AppStrings.debitCreditCard),
                height(0.01.sh),
                textWidget(text: cardNumber ?? AppStrings.debitCreditCardSecret),
              ],
            ),
            const Spacer(),
            Radio(value: defaultCard, groupValue: true, onChanged: onChanged)
          ],
        ),
      ),
    );
  }
}
