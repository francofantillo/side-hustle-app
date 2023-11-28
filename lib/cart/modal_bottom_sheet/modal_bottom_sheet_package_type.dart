import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/event/widgets/event_post_packages_list.dart';
import 'package:side_hustle/event/widgets/select_payment_type_dropdown.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ModalBottomSheetPackageTypePost extends StatefulWidget {
  final bool isEvent, isProduct, isService, isJob;

  const ModalBottomSheetPackageTypePost(
      {super.key,
      this.isEvent = false,
      this.isProduct = false,
      this.isService = false,
      this.isJob = false});

  @override
  State<ModalBottomSheetPackageTypePost> createState() =>
      _ModalBottomSheetPackageTypePostState();
}

class _ModalBottomSheetPackageTypePostState
    extends State<ModalBottomSheetPackageTypePost> {
  final List<String> items = [
    "****  ****  ****  4567",
    "****  ****  ****  4568",
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
        child: Wrap(

          // crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontFamily: AppFont.gilroyBold,
                  fontSize: AppDimensions.textSizeBottomSheet,
                  fontWeight: FontWeight.bold),
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
                  fontSize: AppDimensions.textSize10),
            ),
            height(0.06.sw),
            // const ProductsCartList(),
            const EventPostPackagesList(),
            // height(0.02.sw),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                // top: 16,
              ),
              child: textWidget(
                  text: AppStrings.selectPaymentType,
                  color: AppColors.textWhiteColor,
                  fontFamily: AppFont.gilroyBold,
                  fontSize: AppDimensions.textSizeBottomSheet,
                  fontWeight: FontWeight.bold),
            ),
            height(0.02.sw),
            SizedBox(
              width: 1.sw,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: SelectPaymentTypeDropDown(
                  items: items,
                  hintText: AppStrings.debitCreditCardSecret,
                  selectedValue: (v) {
                    print("selectedValue: $v");
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0,),
              child: CustomMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (widget.isJob) {
                      return;
                    } else if (widget.isProduct) {
                      Navigator.pushNamed(
                          context, AppRoutes.postAddedScreenRoute,
                          arguments: const PostAdded(
                            isProduct: true,
                            title: AppStrings.sideHustlePosted,
                            subTitle: AppStrings.sideHustlePostedSubTitle,
                            buttonName: AppStrings.viewSideHustle,
                          ));
                      return;
                    } else if (widget.isService) {
                      Navigator.pushNamed(
                          context, AppRoutes.postAddedScreenRoute,
                          arguments: const PostAdded(
                            isService: true,
                            title: AppStrings.sideHustlePosted,
                            subTitle: AppStrings.sideHustlePostedSubTitle,
                            buttonName: AppStrings.viewSideHustle,
                          ));
                      return;
                    } else if (widget.isEvent) {
                      Navigator.pushNamed(
                          context, AppRoutes.postAddedScreenRoute,
                          arguments: const PostAdded(
                            isEvent: true,
                            title: AppStrings.eventPosted,
                            subTitle: AppStrings.sideHustlePostedSubTitle,
                            buttonName: AppStrings.viewEvent,
                          ));
                      return;
                    }
                  },
                  name: AppStrings.continueText,
                  borderRadius: AppDimensions.boarderRadiusCartPlaceOrder,
                  color: AppColors.whiteColor,
                  textColor: AppColors.primaryColor),
            ),
            // height(0.5.sh),
          ],
        ),
      );
    });
  }
}
