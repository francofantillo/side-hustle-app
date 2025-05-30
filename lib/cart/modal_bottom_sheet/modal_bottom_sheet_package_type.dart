import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/event/widgets/select_payment_type_dropdown.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ModalBottomSheetPackageTypePost extends StatefulWidget {
  final bool isEventPost,
      isEventEdit,
      isEventEditFromPostAdded,
      isProduct,
      isEditProduct,
      isService,
      isEditService,
      isJob,
      isJobFromMyJobs,
      isJobEdit,
      isTestACLive;
  final int? defaultCardId;

  const ModalBottomSheetPackageTypePost(
      {super.key,
      this.isEventPost = false,
      this.isTestACLive = false,
      this.isEventEdit = false,
      this.isEventEditFromPostAdded = false,
      this.isProduct = false,
      this.isEditProduct = false,
      this.isEditService = false,
      this.isService = false,
      this.defaultCardId,
      this.isJob = false,
      this.isJobFromMyJobs = false,
      this.isJobEdit = false});

  @override
  State<ModalBottomSheetPackageTypePost> createState() =>
      _ModalBottomSheetPackageTypePostState();
}

enum SingingCharacter { package1, package2, package3 }

class _ModalBottomSheetPackageTypePostState
    extends State<ModalBottomSheetPackageTypePost> {
  late final AuthCubit _bloc;
  late final CardCubit _blocCard;
  late final EventsCubit _blocEvent;
  late final JobsCubit _blocJobs;
  late final SideHustleCubit _blocSideHustle;

  int? cardId;
  int? defaultCard;
  SingingCharacter? _character = SingingCharacter.package1;
  int index = 0;

  // late final ValueNotifier<bool> _packagesGroupValue;

  int defaultCardIndex = 2;

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
    // setDefaultCardList();
    index = 0;
    _blocCard = BlocProvider.of<CardCubit>(context);
    _bloc = BlocProvider.of<AuthCubit>(context);
    _blocEvent = BlocProvider.of<EventsCubit>(context);
    _blocJobs = BlocProvider.of<JobsCubit>(context);
    _blocSideHustle = BlocProvider.of<SideHustleCubit>(context);
    if (_blocCard.state.cardModel?.data?.isNotEmpty != null) {
      cardId = _blocCard.state.cardModel?.data?[0].id;
    }
    defaultCard = widget.defaultCardId;
    if (kDebugMode) {
      print("ModalBottomSheetPackageTypePost cardId: $cardId");
    }
    if (kDebugMode) {
      print(
          "isEventPost: ${widget.isEventPost}, isEventEdit: ${widget.isEventEdit}");
    }
    if (kDebugMode) {
      print(
          "ModalBottomSheetPackageType isJobFromMyJobs: ${widget.isJobFromMyJobs}");
    }
    getPlans();
    super.initState();
  }

  getPlans() async {
    await _bloc.getPlansCubit();
  }

  final List<String> items = [
    "4567",
    "4568",
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
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  return Padding(
                    padding:
                        EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textWidget(
                                text:
                                    // "\$${packages["packages"]?[0]["packagePrice"].toStringAsFixed(2) ?? ""}",
                                    // "\$${state.plansModel?.data?[0].price?.toStringAsFixed(2)}",
                                    "\$${state.plansModel?.data?[0].price != null ? (state.plansModel?.data?[0].price?.toStringAsFixed(2)) : ""}",
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                            width(0.03.sw),
                            Expanded(
                              child: textWidget(
                                  text: state.plansModel?.data?[0].name,
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
                                    index = 0;
                                    _character = SingingCharacter.package1;
                                  }
                                  setState(() {});
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  return Padding(
                    padding:
                        EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textWidget(
                                text:
                                    // "\$${packages["packages"]?[1]["packagePrice"].toStringAsFixed(2) ?? ""}",
                                    "\$${state.plansModel?.data?[1].price != null ? (state.plansModel?.data?[1].price?.toStringAsFixed(2)) : ""}",
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                            width(0.03.sw),
                            Expanded(
                              child: textWidget(
                                  // text: packages["packages"]?[1]["packageType"],
                                  text: state.plansModel?.data?[1].name,
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
                                    index = 1;
                                    _character = SingingCharacter.package2;
                                  }
                                  setState(() {});
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  return Padding(
                    padding:
                        EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textWidget(
                                text:
                                    // "\$${packages["packages"]?[2]["packagePrice"].toStringAsFixed(2) ?? ""}",
                                    "\$${state.plansModel?.data?[2].price != null ? (state.plansModel?.data?[2].price?.toStringAsFixed(2)) : ""}",
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold),
                            width(0.03.sw),
                            Expanded(
                              child: textWidget(
                                  // text: packages["packages"]?[2]["packageType"],
                                  text: state.plansModel?.data?[2].name,
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
                                    index = 2;
                                    _character = SingingCharacter.package3;
                                  }
                                  setState(() {});
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                }),
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
                // height(0.02.sw),
                BlocBuilder<CardCubit, CardState>(builder: (context, state) {
                  return SizedBox(
                    width: 1.sw,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.w),
                      child: SelectPaymentTypeDropDown(
                        // items: items,
                        // items: items,
                        items: state.cardModel?.data,
                        hintText: AppStrings.debitCreditCardSecret,
                        selectedValue: (v) {
                          if (kDebugMode) {
                            print("selectedValue: $v");
                          }
                        },
                        selectedItemId: (v) {
                          if (kDebugMode) {
                            print("selectedItemId: $v");
                          }
                          cardId = v;
                        },
                      ),
                    ),
                  );
                }),
                widget.isJob
                    ? BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                        return Padding(
                          // padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 0.08.sw),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: CustomMaterialButton(
                              onPressed: () async {
                                if (kDebugMode) {
                                  print("Post Job Called");
                                }
                                EasyLoading.instance.indicatorColor =
                                    AppColors.whiteColor;
                                late final int planId;
                                if (kDebugMode) {
                                  print(
                                      "_character: ${_character?.name} SingingCharacter ${SingingCharacter.package1.name}");
                                }
                                // if (_character?.name ==
                                //     SingingCharacter.package1.name) {
                                //   planId = 1;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package2.name) {
                                //   planId = 2;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package3.name) {
                                //   planId = 3;
                                // }
                                planId = state.plansModel!.data![index].id!;
                                if (kDebugMode) {
                                  print("planId: $planId");
                                }
                                // Navigator.pop(context);
                                // Navigator.pop(context);
                                if (cardId != defaultCard) {
                                  await _blocCard
                                      .defaultCardCubit(
                                          context: context,
                                          mounted: mounted,
                                          hideLoader: true,
                                          cardId: cardId)
                                      .then((value) async {
                                    if (value == 1) {
                                      defaultCard = cardId;
                                      await _blocJobs
                                          .postJobCubit(
                                              context: context,
                                              mounted: mounted,
                                              isFromMyJobs:
                                                  widget.isJobFromMyJobs,
                                              planId: planId)
                                          .then((value) {
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                      });
                                    } else {
                                      EasyLoading.instance.indicatorColor =
                                          AppColors.primaryColor;
                                    }
                                  });
                                } else {
                                  await _blocJobs
                                      .postJobCubit(
                                          context: context,
                                          mounted: mounted,
                                          isFromMyJobs: widget.isJobFromMyJobs,
                                          planId: planId)
                                      .then((value) {
                                    EasyLoading.instance.indicatorColor =
                                        AppColors.primaryColor;
                                    if (value == 1) {}
                                  });
                                }

                                return;
                              },
                              name: AppStrings.continueText,
                              color: AppColors.whiteColor,
                              textColor: AppColors.primaryColor),
                        );
                      })
                    : const SizedBox.shrink(),
                widget.isProduct
                    ? BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                        return Padding(
                          // padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 0.08.sw),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: CustomMaterialButton(
                              onPressed: () async {
                                if (kDebugMode) {
                                  print("Post Job Called");
                                }
                                EasyLoading.instance.indicatorColor =
                                    AppColors.whiteColor;
                                late final int planId;
                                if (kDebugMode) {
                                  print(
                                      "_character: ${_character?.name} SingingCharacter ${SingingCharacter.package1.name}");
                                }
                                // if (_character?.name ==
                                //     SingingCharacter.package1.name) {
                                //   planId = 1;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package2.name) {
                                //   planId = 2;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package3.name) {
                                //   planId = 3;
                                // }
                                planId = state.plansModel!.data![index].id!;
                                if (kDebugMode) {
                                  print("planId: $planId");
                                }
                                if (cardId != defaultCard) {
                                  await _blocCard
                                      .defaultCardCubit(
                                          context: context,
                                          mounted: mounted,
                                          hideLoader: true,
                                          cardId: cardId)
                                      .then((value) async {
                                    if (value == 1) {
                                      defaultCard = cardId;
                                      await _blocSideHustle
                                          .addProductCubit(
                                              context: context,
                                              mounted: mounted,
                                              planId: planId)
                                          .then((value) {
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                      });
                                    } else {
                                      EasyLoading.instance.indicatorColor =
                                          AppColors.primaryColor;
                                    }
                                  });
                                } else {
                                  await _blocSideHustle
                                      .addProductCubit(
                                          context: context,
                                          mounted: mounted,
                                          planId: planId)
                                      .then((value) {
                                    EasyLoading.instance.indicatorColor =
                                        AppColors.primaryColor;
                                  });
                                }

                                return;
                              },
                              name: AppStrings.continueText,
                              color: AppColors.whiteColor,
                              textColor: AppColors.primaryColor),
                        );
                      })
                    : const SizedBox.shrink(),
                widget.isEditProduct
                    ? Padding(
                        // padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 0.08.sw),
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 20),
                        child: CustomMaterialButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, AppRoutes.postAddedScreenRoute,
                                  arguments: const PostAdded(
                                    isProduct: true,
                                    title: AppStrings.sideHustlePosted,
                                    subTitle:
                                        AppStrings.sideHustlePostedSubTitle,
                                    buttonName: AppStrings.viewSideHustle,
                                  ));
                              return;
                            },
                            name: AppStrings.continueText,
                            color: AppColors.whiteColor,
                            textColor: AppColors.primaryColor),
                      )
                    : const SizedBox.shrink(),
                widget.isService
                    ? BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                        return Padding(
                          // padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 0.08.sw),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: CustomMaterialButton(
                              onPressed: () async {
                                if (kDebugMode) {
                                  print("Post Job Called");
                                }
                                EasyLoading.instance.indicatorColor =
                                    AppColors.whiteColor;
                                late final int planId;
                                if (kDebugMode) {
                                  print(
                                      "_character: ${_character?.name} SingingCharacter ${SingingCharacter.package1.name}");
                                }
                                // if (_character?.name ==
                                //     SingingCharacter.package1.name) {
                                //   planId = 1;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package2.name) {
                                //   planId = 2;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package3.name) {
                                //   planId = 3;
                                // }
                                planId = state.plansModel!.data![index].id!;
                                if (kDebugMode) {
                                  print("planId: $planId");
                                }
                                if (cardId != defaultCard) {
                                  await _blocCard
                                      .defaultCardCubit(
                                          context: context,
                                          mounted: mounted,
                                          hideLoader: true,
                                          cardId: cardId)
                                      .then((value) async {
                                    if (value == 1) {
                                      defaultCard = cardId;
                                      await _blocSideHustle
                                          .addServiceCubit(
                                              context: context,
                                              mounted: mounted,
                                              planId: planId)
                                          .then((value) {
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                      });
                                    } else {
                                      EasyLoading.instance.indicatorColor =
                                          AppColors.primaryColor;
                                    }
                                  });
                                } else {
                                  await _blocSideHustle
                                      .addServiceCubit(
                                          context: context,
                                          mounted: mounted,
                                          planId: planId)
                                      .then((value) {
                                    EasyLoading.instance.indicatorColor =
                                        AppColors.primaryColor;
                                  });
                                }

                                return;
                              },
                              name: AppStrings.continueText,
                              color: AppColors.whiteColor,
                              textColor: AppColors.primaryColor),
                        );
                      })
                    : const SizedBox.shrink(),
                widget.isEventPost
                    ? BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                        return Padding(
                          // padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 0.08.sw),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: CustomMaterialButton(
                              onPressed: () async {
                                EasyLoading.instance.indicatorColor =
                                    AppColors.whiteColor;
                                late final int planId;
                                if (kDebugMode) {
                                  print(
                                      "_character: ${_character?.name} SingingCharacter ${SingingCharacter.package1.name}");
                                }
                                // if (_character?.name ==
                                //     SingingCharacter.package1.name) {
                                //   planId = 1;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package2.name) {
                                //   planId = 2;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package3.name) {
                                //   planId = 3;
                                // }
                                planId = state.plansModel!.data![index].id!;
                                if (kDebugMode) {
                                  print("planId: $planId");
                                }
                                print("isTestACLive: ${widget.isTestACLive}");
                                if (widget.isTestACLive) {
                                  EasyLoading.instance.indicatorColor =
                                      AppColors.whiteColor;
                                  await _blocEvent
                                      .postAnEventCubit(
                                          context: context,
                                          mounted: mounted,
                                          planId: planId)
                                      .then((value) {
                                    if (value != 0) {
                                      EasyLoading.instance.indicatorColor =
                                          AppColors.primaryColor;
                                      // Navigator.pop(context);
                                      // Navigator.pop(context);
                                      if (kDebugMode) {
                                        print("value: $value");
                                      }
                                      Navigator.pushReplacementNamed(context,
                                          AppRoutes.postAddedScreenRoute,
                                          arguments: PostAdded(
                                            id: value,
                                            isEvent: true,
                                            title: AppStrings.eventPosted,
                                            subTitle: AppStrings
                                                .sideHustlePostedSubTitle,
                                            buttonName: AppStrings.viewEvent,
                                          ));
                                    } else {
                                      EasyLoading.instance.indicatorColor =
                                          AppColors.primaryColor;
                                    }
                                  });
                                } else {
                                  if (cardId != defaultCard) {
                                    await _blocCard
                                        .defaultCardCubit(
                                            context: context,
                                            mounted: mounted,
                                            hideLoader: true,
                                            cardId: cardId)
                                        .then((value) async {
                                      if (value == 1) {
                                        defaultCard = cardId;
                                        await _blocEvent
                                            .postAnEventCubit(
                                                context: context,
                                                mounted: mounted,
                                                planId: planId)
                                            .then((value) {
                                          if (value != 0) {
                                            EasyLoading
                                                    .instance.indicatorColor =
                                                AppColors.primaryColor;
                                            // Navigator.pop(context);
                                            // Navigator.pop(context);
                                            if (kDebugMode) {
                                              print("value: $value");
                                            }
                                            Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.postAddedScreenRoute,
                                                arguments: PostAdded(
                                                  id: value,
                                                  isEvent: true,
                                                  title: AppStrings.eventPosted,
                                                  subTitle: AppStrings
                                                      .sideHustlePostedSubTitle,
                                                  buttonName:
                                                      AppStrings.viewEvent,
                                                ));
                                          } else {
                                            EasyLoading
                                                    .instance.indicatorColor =
                                                AppColors.primaryColor;
                                          }
                                        });
                                      } else {
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                      }
                                    });
                                  } else {
                                    await _blocEvent
                                        .postAnEventCubit(
                                            context: context,
                                            mounted: mounted,
                                            planId: planId)
                                        .then((value) {
                                      if (value != 0) {
                                        if (kDebugMode) {
                                          print("value: $value");
                                        }
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                        Navigator.pushReplacementNamed(context,
                                            AppRoutes.postAddedScreenRoute,
                                            arguments: PostAdded(
                                              id: value,
                                              isEvent: true,
                                              title: AppStrings.eventPosted,
                                              subTitle: AppStrings
                                                  .sideHustlePostedSubTitle,
                                              buttonName: AppStrings.viewEvent,
                                            ));
                                      } else {
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                      }
                                    });
                                  }
                                }

                                return;
                              },
                              name: AppStrings.continueText,
                              color: AppColors.whiteColor,
                              textColor: AppColors.primaryColor),
                        );
                      })
                    : const SizedBox.shrink(),
                widget.isEventEdit
                    ? BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                        return Padding(
                          // padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 0.08.sw),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: CustomMaterialButton(
                              onPressed: () async {
                                if (kDebugMode) {
                                  print(
                                      "isEventEditFromPostAdded: ${widget.isEventEditFromPostAdded}");
                                }
                                EasyLoading.instance.indicatorColor =
                                    AppColors.whiteColor;
                                late final int planId;
                                if (kDebugMode) {
                                  print(
                                      "_character: ${_character?.name} SingingCharacter ${SingingCharacter.package1.name}");
                                }
                                // if (_character?.name ==
                                //     SingingCharacter.package1.name) {
                                //   planId = 1;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package2.name) {
                                //   planId = 2;
                                // } else if (_character?.name ==
                                //     SingingCharacter.package3.name) {
                                //   planId = 3;
                                // }
                                planId = state.plansModel!.data![index].id!;
                                if (kDebugMode) {
                                  print("planId: $planId");
                                }
                                // Navigator.pop(context);
                                // Navigator.pop(context);
                                if (cardId != defaultCard) {
                                  await _blocCard
                                      .defaultCardCubit(
                                          context: context,
                                          mounted: mounted,
                                          hideLoader: true,
                                          cardId: cardId)
                                      .then((value) async {
                                    if (value == 1) {
                                      defaultCard = cardId;
                                      await _blocEvent
                                          .editAnEventCubit(
                                        context: context,
                                        mounted: mounted,
                                      )
                                          // planId: planId)
                                          .then((value) {
                                        if (value != 0) {
                                          if (widget.isEventEditFromPostAdded) {
                                            EasyLoading
                                                    .instance.indicatorColor =
                                                AppColors.primaryColor;
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            // Navigator.pop(context);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.myEventsScreenRoute);
                                          } else {
                                            EasyLoading
                                                    .instance.indicatorColor =
                                                AppColors.primaryColor;
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.myEventsScreenRoute);
                                          }

                                          if (kDebugMode) {
                                            print("value: $value");
                                          }
                                        } else {
                                          EasyLoading.instance.indicatorColor =
                                              AppColors.primaryColor;
                                        }
                                      });
                                    } else {
                                      EasyLoading.instance.indicatorColor =
                                          AppColors.primaryColor;
                                    }
                                  });
                                } else {
                                  await _blocEvent
                                      .editAnEventCubit(
                                    context: context,
                                    mounted: mounted,
                                  )
                                      // planId: planId)
                                      .then((value) {
                                    if (value != 0) {
                                      if (widget.isEventEditFromPostAdded) {
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        // Navigator.pop(context);
                                        Navigator.pushReplacementNamed(context,
                                            AppRoutes.myEventsScreenRoute);
                                      } else {
                                        EasyLoading.instance.indicatorColor =
                                            AppColors.primaryColor;
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(context,
                                            AppRoutes.myEventsScreenRoute);
                                      }
                                      if (kDebugMode) {
                                        print("value: $value");
                                      }
                                    } else {
                                      EasyLoading.instance.indicatorColor =
                                          AppColors.primaryColor;
                                    }
                                  });
                                }

                                return;
                              },
                              name: AppStrings.continueText,
                              color: AppColors.whiteColor,
                              textColor: AppColors.primaryColor),
                        );
                      })
                    : const SizedBox.shrink(),
                // height(0.02.sw),
                Center(
                  child: textWidget(
                      text: "",
                      maxLines: 2,
                      color: AppColors.textWhiteColor,
                      fontSize: AppDimensions.textSizeSmall),
                ),
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
