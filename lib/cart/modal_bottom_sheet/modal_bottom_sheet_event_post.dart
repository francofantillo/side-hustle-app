import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/event/widgets/event_post_packages_list.dart';
import 'package:side_hustle/event/widgets/select_payment_type_dropdown.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ModalBottomSheetEventPost extends StatefulWidget {
  final bool isDelivery;

  const ModalBottomSheetEventPost({super.key, this.isDelivery = false});

  @override
  State<ModalBottomSheetEventPost> createState() =>
      _ModalBottomSheetEventPostState();
}

class _ModalBottomSheetEventPostState extends State<ModalBottomSheetEventPost> {
  final List<String> items = [
    PaymentTypeEnum.Cash.name,
    PaymentTypeEnum.Card.name,
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        height: AppDimensions.modelSheetProductsHeight,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppDimensions.boarderRadiusBottomSheet),
              topLeft: Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
          // image: const DecorationImage(
          //     image: AssetImage(AssetsPath.drawerBg), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16,
              ),
              child: textWidget(
                  text: AppStrings.selectPackageType,
                  color: AppColors.textWhiteColor,
                  fontSize: AppDimensions.textSizeBottomSheet,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 2,
                bottom: 4,
              ),
              child: textWidget(
                  text: AppStrings.selectPackageTypeHint,
                  color: AppColors.textWhiteColor,
                  fontSize: AppDimensions.textSizeSmall),
            ),
            height(0.02.sh),
            // const ProductsCartList(),
            const EventPostPackagesList(),
            height(0.02.sh),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16,
              ),
              child: textWidget(
                  text: AppStrings.selectPaymentType,
                  color: AppColors.textWhiteColor,
                  fontSize: AppDimensions.textSizeBottomSheet,
                  fontWeight: FontWeight.w500),
            ),
            height(0.02.sh),
            SizedBox(
              width: 1.sh,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: SelectPaymentTypeDropDown(
                  items: items,
                  hintText: AppStrings.paymentTypeHint,
                  selectedValue: (v) {
                    print("selectedValue: $v");
                  },
                ),
              ),
            ),
            height(0.02.sh),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              child: customMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.postAddedScreenRoute,
                        arguments: const PostAdded(
                          isEvent: true,
                          title: AppStrings.eventPosted,
                          subTitle: AppStrings.sideHustlePostedSubTitle,
                          buttonName: AppStrings.viewEvent,
                        ));
                  },
                  name: AppStrings.continueText,
                  borderRadius: AppDimensions.boarderRadiusCartPlaceOrder,
                  color: AppColors.whiteColor,
                  textColor: AppColors.primaryColor),
            ),
            height(0.02.sh),
          ],
        ),
      );
    });
  }
}
