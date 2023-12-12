import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/event/widgets/select_payment_type_dropdown.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
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

enum SingingCharacter { package1, package2, package3 }

class _ModalBottomSheetPackageTypePostState
    extends State<ModalBottomSheetPackageTypePost> {
  SingingCharacter? _character = SingingCharacter.package1;

  late final ValueNotifier<bool> _packagesGroupValue;

  int defaultCardIndex = 2;
  Map<String, List> defaultCard = {
    "x": [false, false, false],
  };

  Map<String, List> packages = {
    "packages": [
      {
        "packagePrice": 1.00,
        "packageType": "Post per day",
        "default": false,
      },
      {
        "packagePrice": 7.00,
        "packageType": "Post per week",
        "default": false,
      },
      {
        "packagePrice": 30.00,
        "packageType": "Post per Month",
        "default": true,
      }
    ]
  };

  @override
  void initState() {
    setDefaultCardList();
    super.initState();
  }

  setDefaultCardList() {
    for (int i = 0; i < packages["packages"]!.length; i++) {
      defaultCard["x"]![i] = packages["packages"]![i]["default"];
      if (packages["packages"]![i]["default"]) {
        defaultCardIndex = i;
      }
    }
  }

  final List<String> items = [
    "****  ****  ****  4567",
    "****  ****  ****  4568",
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(AppDimensions.boarderRadiusBottomSheet),
                  topLeft:
                      Radius.circular(AppDimensions.boarderRadiusBottomSheet)),
              // image: const DecorationImage(
              //     image: AssetImage(AssetsPath.drawerBg), fit: BoxFit.cover)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 16.w,
                  ),
                  child: textWidget(
                      text: AppStrings.selectPackageType,
                      color: AppColors.textWhiteColor,
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.textSizeBottomSheet,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 2,
                    bottom: 12.w,
                  ),
                  child: textWidget(
                      text: AppStrings.selectPackageTypeHint,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSize10),
                ),
                // height(0.06.sw),
                Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, top: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textWidget(
                              text:
                                  "\$${packages["packages"]?[0]["packagePrice"].toStringAsFixed(2) ?? ""}",
                              color: AppColors.textBlackColor,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSizeNormal,
                              fontWeight: FontWeight.bold),
                          width(0.03.sw),
                          Expanded(
                            child: textWidget(
                                text: packages["packages"]?[0]["packageType"],
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                          ),
                          // const Spacer(),
                          Radio(
                              value: SingingCharacter.package1,
                              groupValue: _character,
                              onChanged: (SingingCharacter? v) {
                                if (v! == SingingCharacter.package1) {
                                  _character = SingingCharacter.package1;
                                } else {
                                  // _character = SingingCharacter.lafayette;
                                }
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, top: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textWidget(
                              text:
                                  "\$${packages["packages"]?[1]["packagePrice"].toStringAsFixed(2) ?? ""}",
                              color: AppColors.textBlackColor,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSizeNormal,
                              fontWeight: FontWeight.bold),
                          width(0.03.sw),
                          Expanded(
                            child: textWidget(
                                text: packages["packages"]?[1]["packageType"],
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                          ),
                          // const Spacer(),
                          Radio(
                              value: SingingCharacter.package2,
                              groupValue: _character,
                              onChanged: (SingingCharacter? v) {
                                if (v! == SingingCharacter.package2) {
                                  _character = SingingCharacter.package2;
                                } else {
                                  // _character = SingingCharacter.lafayette;
                                }
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.w),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, top: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textWidget(
                              text:
                                  "\$${packages["packages"]?[2]["packagePrice"].toStringAsFixed(2) ?? ""}",
                              color: AppColors.textBlackColor,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSizeNormal,
                              fontWeight: FontWeight.bold),
                          width(0.03.sw),
                          Expanded(
                            child: textWidget(
                                text: packages["packages"]?[2]["packageType"],
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                          ),
                          // const Spacer(),
                          Radio(
                              value: SingingCharacter.package3,
                              groupValue: _character,
                              onChanged: (SingingCharacter? v) {
                                if (v! == SingingCharacter.package3) {
                                  _character = SingingCharacter.package3;
                                } else {
                                  // _character = SingingCharacter.lafayette;
                                }
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                  ),
                ),
                // const ProductsCartList(),
                // const EventPostPackagesList(),
                // height(0.02.sw),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
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
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.w),
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
                  // padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 0.08.sw),
                  padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
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
                      color: AppColors.whiteColor,
                      textColor: AppColors.primaryColor),
                ),
                height(0.02.sw),
                Center(
                  child: textWidget(
                      text: "",
                      maxLines: 2,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeSmall),
                ),
              ],
            ),
          ),
          // height(0.5.sh),
        ],
      );
    });
  }
}
