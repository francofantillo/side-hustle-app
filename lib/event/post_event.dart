import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/state_management/models/card_model.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/utils/validation/regular_expressions.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostEvent extends StatefulWidget {
  final bool isEdit, isEventEditFromPostAdded;
  final int? id;

  const PostEvent(
      {super.key,
      this.isEdit = false,
      this.isEventEditFromPostAdded = false,
      this.id});

  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  final List vendorList = [];
  final List availableAttractionsList = [];
  List<File>? itemImages;
  final _eventFormKey = GlobalKey<FormState>();
  late final EventsCubit _bloc;
  late final CardCubit _blocCard;

  int? userId;
  final prefs = SharedPreferencesHelper.instance;

  final List<String> items = [
    PaymentTypeEnum.Cash.name,
    PaymentTypeEnum.Card.name,
  ];


  @override
  void initState() {
    AppUtils.firstSelectedTime = null;
    AppUtils.secondSelectedTime = null;
    _bloc = BlocProvider.of<EventsCubit>(context);
    _blocCard = BlocProvider.of(context);
    _bloc.initPostEventControllers();
    print("PostEvent id: ${widget.id}");
    getUserId();
    widget.id != null
        ? getEvent()
        // : _bloc.state.eventsDetailModel = EventsModel();
        : _bloc.state.editEventModel = EventsModel();
    super.initState();
  }

  Future getUserId() async {
    final UserModel? userModel = await prefs.getUser();
    userId = userModel?.data?.id;
    if (kDebugMode) {
      print("userId: $userId");
    }
  }

  Future getEvent() async {
    await _bloc
        .getEditEventCubit(context: context, mounted: mounted, id: widget.id)
        .then((value) {
      if (value != null) {
        final date = value.eventDetails?.startDate != null
            ? AppUtils.formatDateView(
                selectedDate: DateTime.parse(value.eventDetails!.startDate!))
            : "";
        final startTime = DateTimeConversions.convertTo12HourFormat(
            value.eventDetails?.startTime);
        final endTime = DateTimeConversions.convertTo12HourFormat(
            value.eventDetails?.endTime);

        print("getEvent lat: ${value.eventDetails?.lat}");
        print("getEvent lng: ${value.eventDetails?.lng}");
        _bloc.dateTextController.text = date;
        _bloc.startTimeTextController.text = startTime;
        _bloc.endTimeTextController.text = endTime;
        if (value.eventDetails?.startTime != null) {
          TimeOfDay _startTime =
              AppUtils.convertToTimeOfDay(value.eventDetails!.startTime!);
          AppUtils.firstSelectedTime = _startTime;
        }
        if (value.eventDetails?.endTime != null) {
          TimeOfDay _endTime =
              AppUtils.convertToTimeOfDay(value.eventDetails!.endTime!);
          AppUtils.secondSelectedTime = _endTime;
        }
        _bloc.eventNameTextController.text =
            value.eventDetails?.eventName ?? "";
        _bloc.eventLocationTextController.text =
            value.eventDetails?.location ?? "";
        _bloc.eventPurposeTextController.text =
            value.eventDetails?.purpose ?? "";
        _bloc.eventThemeTextController.text = value.eventDetails?.theme ?? "";
        _bloc.eventPriceTextController.text =
            value.eventDetails?.price?.toStringAsFixed(2) ?? "";
        if (value.eventDetails?.vendorsList?.length != null &&
            value.eventDetails!.vendorsList!.isNotEmpty) {
          for (int i = 0; i < value.eventDetails!.vendorsList!.length; i++) {
            vendorList.add(value.eventDetails!.vendorsList![i]);
          }
        }
        if (value.eventDetails?.availableAttractions?.length != null &&
            value.eventDetails!.availableAttractions!.isNotEmpty) {
          for (int i = 0;
              i < value.eventDetails!.availableAttractions!.length;
              i++) {
            availableAttractionsList
                .add(value.eventDetails!.availableAttractions![i].attr);
          }
        }
      }
    });
  }

  Future getCards({required bool isEdit, required bool isTestLive}) async {
    if (isTestLive) {
      AppUtils.showBottomModalSheet(
          context: context,
          widget: const ModalBottomSheetPackageTypePost(
            isEventPost: true,
          ));
    } else {
      await _blocCard
          .getCardsCubit(context: context, mounted: mounted)
          .then((value) {
        if (value != null && value.isEmpty) {
          AppUtils.showToast(AppStrings.cardNotAddedError);
        } else if (value != null) {
          int? cardId;
          DataCard? dataCard;
          for (int i = 0;
              i < (_blocCard.state.cardModel?.data?.length ?? 0);
              i++) {
            if (_blocCard.state.cardModel?.data?[i].isDefault == 1) {
              cardId = _blocCard.state.cardModel?.data?[i].id;
              dataCard = _blocCard.state.cardModel?.data?[i];
            }
          }
          print("cardId: $cardId isDefault: ${dataCard?.isDefault}");
          if (isEdit) {
            AppUtils.showBottomModalSheet(
                context: context,
                widget: ModalBottomSheetPackageTypePost(
                    isEventEdit: true,
                    isEventEditFromPostAdded: widget.isEventEditFromPostAdded,
                    defaultCardId: cardId));
          } else {
            AppUtils.showBottomModalSheet(
                context: context,
                widget: ModalBottomSheetPackageTypePost(
                    isEventPost: true, defaultCardId: cardId));
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle:
          widget.id != null ? AppStrings.editEvent : AppStrings.postAnEvent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
        return state.editEventLoading
            ? const SizedBox.shrink()
            : Form(
                key: _eventFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.rootPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // state.itemImagesFile != null &&
                        //         state.itemImagesFile!.isNotEmpty
                        //     ? ImageSlider(
                        //         // itemImages: itemImages,
                        //         fileImages: state.itemImagesFile,
                        //         indicatorLength: state.itemImagesFile?.length,
                        //         onTap: () async {
                        //           await _bloc.selectMultiImages();
                        //         },
                        //       )
                        //     : state.editEventModel?.eventDetails?.images !=
                        //                 null &&
                        //             state.editEventModel!.eventDetails!.images!
                        //                 .isEmpty
                        //         ? NoImagesFoundWidget(
                        //             showCameraAttachment: true,
                        //             onTap: () async {
                        //               await _bloc.selectMultiImages();
                        //             },
                        //           )
                        //         : ImageSlider(
                        //             hideCameraIcon: false,
                        //             indicatorLength: state
                        //                         .editEventModel
                        //                         ?.eventDetails
                        //                         ?.images
                        //                         ?.length ==
                        //                     null
                        //                 ? null
                        //                 : state.editEventModel!.eventDetails!
                        //                         .images!.isEmpty
                        //                     ? null
                        //                     : state.editEventModel!
                        //                         .eventDetails!.images!.length,
                        //             // itemImages: itemImages,
                        //             responseImages: state
                        //                 .editEventModel?.eventDetails?.images,
                        //             onTap: () async {
                        //               await _bloc.selectMultiImages();
                        //             },
                        //           ),
                        state.images!.isEmpty
                            ? NoImagesFoundWidget(
                                showCameraAttachment: true,
                                onTap: () async {
                                  await _bloc.selectMultiImages();
                                },
                              )
                            : ImageSlider(
                                hideCameraIcon: false,
                                indicatorLength: state.images?.length,
                                responseImages: state.images,
                                onTap: () async {
                                  await _bloc.selectMultiImages();
                                },
                              ),
                        height(0.02.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventName,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            controller: _bloc.eventNameTextController,
                            height: 45.h,
                            hintText: AppStrings.eventNameHint,
                            fieldValidator: (value) =>
                                value?.validateEmpty(AppStrings.eventName),
                            // fieldValidator: (value) {
                            //   final String? error = value?.validateEmpty(
                            //     AppStrings.eventName,
                            //   );
                            //   if (error != null) {
                            //     _errorMsgEventName = error;
                            //     setState(() {});
                            //   }
                            //   return null;
                            // },
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.singleFieldCharacterLength),
                            ],
                            // fillColor: AppColors.productTextFieldColor,
                          ),
                        ),
                        // _errorMsgEventName != null
                        //     ? height(0.01.sw)
                        //     : const SizedBox.shrink(),
                        // _errorMsgEventName != null
                        //     ? Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        //         child: textWidget(
                        //             text: _errorMsgEventName,
                        //             maxLines: 1,
                        //             color: AppColors.redColor,
                        //             fontSize: AppDimensions.textSizeVerySmall,
                        //             fontFamily: AppFont.gilroyRegular,
                        //             fontWeight: FontWeight.w400),
                        //       )
                        //     : const SizedBox.shrink(),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventLocation,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            controller: _bloc.eventLocationTextController,
                            onTap: () async {
                              await _bloc.selectLocation(
                                  context: context, mounted: mounted);
                            },
                            isReadonly: true,
                            hintText: AppStrings.eventLocationHint,
                            suffixIcon: Icon(
                              Icons.my_location,
                              size: AppDimensions.imageIconSizeTextFormField,
                              color: AppColors.blackColor,
                            ),
                            isSuffixIcon: true,
                            fieldValidator: (value) =>
                                value?.validateEmpty(AppStrings.eventLocation),
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventDate,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            controller: _bloc.dateTextController,
                            height: 45.h,
                            hintText: AppStrings.selectTheDate,
                            isReadonly: true,
                            suffixIcon: ImageIcon(
                                const AssetImage(AssetsPath.calender),
                                size: AppDimensions.imageIconSizeTextFormField,
                                color: AppColors.blackColor),
                            isSuffixIcon: true,
                            fieldValidator: (value) => value?.validateEmpty(
                              AppStrings.eventDate,
                            ),
                            onTap: () async {
                              final String? formattedDate =
                                  await AppUtils.selectDate(
                                      context: context,
                                      initialDate: DateTime.now());
                              if (formattedDate != null) {
                                _bloc.dateTextController.text =
                                    formattedDate ?? "";
                              }
                              // setState(() {});
                            },
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: textWidget(
                                        text: AppStrings.eventTime,
                                        maxLines: 1,
                                        color: AppColors.textBlackColor,
                                        fontSize: AppDimensions.textSizeSmall,
                                        fontFamily: AppFont.gilroyBold,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  height(0.01.sw),
                                  CustomTextFormField(
                                    controller: _bloc.startTimeTextController,
                                    height: 45.h,
                                    hintText: AppStrings.startTime,
                                    suffixIcon: Icon(
                                      Icons.access_time_filled_rounded,
                                      size: AppDimensions
                                          .imageIconSizeTextFormField,
                                      color: AppColors.greyColorNoOpacity,
                                    ),
                                    isSuffixIcon: true,
                                    isReadonly: true,
                                    fieldValidator: (value) =>
                                        value?.validateEmpty(
                                      AppStrings.startTime,
                                    ),
                                    onTap: () async {
                                      await AppUtils.selectTime(context, true);
                                      print(
                                          "selected time: ${AppUtils.firstSelectedTime}");
                                      if (mounted) {
                                        if (AppUtils.firstSelectedTime !=
                                            null) {
                                          final String firstTime =
                                              AppUtils.formatTimeOfDay(
                                                  AppUtils.firstSelectedTime!);
                                          _bloc.startTimeTextController.text =
                                              firstTime;
                                          print(
                                              "Start Time: ${_bloc.startTimeTextController.text}");
                                        }
                                      }
                                      // setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                            width(0.01.sw),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: textWidget(
                                        text: "",
                                        maxLines: 1,
                                        color: AppColors.textBlackColor,
                                        fontSize: AppDimensions.textSizeSmall,
                                        fontFamily: AppFont.gilroyBold,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  height(0.01.sw),
                                  CustomTextFormField(
                                    controller: _bloc.endTimeTextController,
                                    height: 45.h,
                                    hintText: AppStrings.endTime,
                                    suffixIcon: Icon(
                                      Icons.access_time_filled_rounded,
                                      size: AppDimensions
                                          .imageIconSizeTextFormField,
                                      color: AppColors.greyColorNoOpacity,
                                    ),
                                    isSuffixIcon: true,
                                    isReadonly: true,
                                    fieldValidator: (value) =>
                                        value?.validateEmpty(
                                      AppStrings.endTime,
                                    ),
                                    onTap: () async {
                                      await AppUtils.selectTime(context, false);
                                      if (mounted) {
                                        if (AppUtils.secondSelectedTime !=
                                            null) {
                                          final String endTime =
                                              AppUtils.formatTimeOfDay(
                                                  AppUtils.secondSelectedTime!);
                                          _bloc.endTimeTextController.text =
                                              endTime;
                                          print(
                                              "End Time: ${_bloc.endTimeTextController.text}");
                                        }
                                      }
                                      // setState(() {});
                                    },
                                    // fillColor: AppColors.productTextFieldColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventPurpose,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            controller: _bloc.eventPurposeTextController,
                            height: 45.h,
                            hintText: AppStrings.eventPurposeHint,
                            fieldValidator: (value) =>
                                value?.validateEmpty(AppStrings.eventPurpose),
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.singleFieldCharacterLength),
                            ],
                            // fillColor: AppColors.productTextFieldColor,
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventTheme,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            controller: _bloc.eventThemeTextController,
                            height: 45.h,
                            hintText: AppStrings.eventThemeHint,
                            fieldValidator: (value) =>
                                value?.validateEmpty(AppStrings.eventTheme),
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.singleFieldCharacterLength),
                            ],
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventVendorList,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            controller: _bloc.eventVendorTextController,
                            height: 45.h,
                            hintText: AppStrings.eventVendorListHint,
                            isSuffixIcon: true,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.tagsFieldCharacterLength),
                            ],
                            suffixIcon: InkWell(
                              onTap: () {
                                if (_bloc.eventVendorTextController.text
                                        .isNotEmpty &&
                                    _bloc.eventVendorTextController.text
                                            .trim() !=
                                        "") {
                                  final textLef = _bloc
                                      .eventVendorTextController.text
                                      .trimLeft();
                                  final text = textLef.trimRight();
                                  vendorList.add(text);
                                  _bloc.eventVendorTextController.clear();
                                  setState(() {});
                                }
                              },
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                            ),
                            // fieldValidator: (value) =>
                            //     value?.validateEmpty(AppStrings.eventVendorList),
                            // fillColor: AppColors.productTextFieldColor,
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Wrap(
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 8.0, // gap between lines
                            direction: Axis.horizontal,
                            children: <Widget>[
                              for (int i = 0; i < vendorList.length; i++)
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Container(
                                    // width: .35.sw,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1.0),
                                          child: textWidget(
                                              text: vendorList[i],
                                              maxLines: 2,
                                              color: AppColors.whiteColor,
                                              fontFamily: AppFont.gilroyMedium,
                                              fontSize: AppDimensions
                                                  .textSizeVerySmall),
                                        ),
                                        width(0.015.sw),
                                        Material(
                                          color: AppColors.primaryColor,
                                          child: InkWell(
                                            onTap: () {
                                              vendorList.removeAt(i);
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              CustomIcon.cancel,
                                              color: AppColors.whiteColor,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventTicketPrice,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        CustomTextFormField(
                          controller: _bloc.eventPriceTextController,
                          height: 45.h,
                          hintText: "\$\$\$",
                          fieldValidator: (value) =>
                              value?.validateEmpty(AppStrings.eventTicketPrice),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(
                                Constants.priceFieldCharacterLength),
                            RegularExpressions.PRICE_FORMATTER
                          ],
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.paymentType,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        CustomTextFormField(
                          height: 45.h,
                          hintText: AppStrings.paymentTypeHint,
                          isReadonly: true,
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.eventAvailableAttractions,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            controller: _bloc.eventAvailableTextController,
                            height: 65.h,
                            hintText: AppStrings.eventAvailableAttractionsHint,
                            maxLines: 1,
                            isSuffixIcon: true,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.tagsFieldCharacterLength),
                            ],
                            suffixIcon: InkWell(
                              onTap: () {
                                if (_bloc.eventAvailableTextController.text
                                        .isNotEmpty &&
                                    _bloc.eventAvailableTextController.text
                                            .trim() !=
                                        "") {
                                  final textLef = _bloc
                                      .eventAvailableTextController.text
                                      .trimLeft();
                                  final text = textLef.trimRight();
                                  availableAttractionsList.add(text);
                                  _bloc.eventAvailableTextController.clear();
                                  setState(() {});
                                }
                              },
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Wrap(
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 8.0, // gap between lines
                            direction: Axis.horizontal,
                            children: <Widget>[
                              for (int i = 0;
                                  i < availableAttractionsList.length;
                                  i++)
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Container(
                                    // width: .35.sw,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1.0),
                                          child: textWidget(
                                              text: availableAttractionsList[i],
                                              maxLines: 2,
                                              color: AppColors.whiteColor,
                                              fontFamily: AppFont.gilroyMedium,
                                              fontSize: AppDimensions
                                                  .textSizeVerySmall),
                                        ),
                                        width(0.015.sw),
                                        Material(
                                          color: AppColors.primaryColor,
                                          child: InkWell(
                                            onTap: () {
                                              availableAttractionsList
                                                  .removeAt(i);
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              CustomIcon.cancel,
                                              color: AppColors.whiteColor,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        height(
                            AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomMaterialButton(
                              onPressed: () async {
                                if (widget.isEdit) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_eventFormKey.currentState!.validate()) {
                                    await _bloc
                                        .setVendorAndAvailableAttractionList(
                                            vendorList: vendorList,
                                            availableAttraction:
                                                availableAttractionsList);
                                    if (mounted) {
                                      await _bloc
                                          .editAnEventCubit(
                                        context: context,
                                        mounted: mounted,
                                      )
                                          .then((value) {
                                        if (value != 0) {
                                          if (widget.isEventEditFromPostAdded) {
                                            EasyLoading
                                                    .instance.indicatorColor =
                                                AppColors.primaryColor;
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.myEventsScreenRoute);
                                          } else {
                                            EasyLoading
                                                    .instance.indicatorColor =
                                                AppColors.primaryColor;
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.myEventsScreenRoute);
                                          }
                                          print("value: $value");
                                        } else {
                                          EasyLoading.instance.indicatorColor =
                                              AppColors.primaryColor;
                                        }
                                      });
                                    }
                                  }
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_eventFormKey.currentState!.validate()) {
                                    await _bloc
                                        .setVendorAndAvailableAttractionList(
                                            vendorList: vendorList,
                                            availableAttraction:
                                                availableAttractionsList);
                                    await getCards(
                                        isEdit: false,
                                        isTestLive:
                                            userId == Constants.johnId ||
                                                    userId == Constants.mikeId
                                                ? true
                                                : false);
                                  }
                                }
                              },
                              color: AppColors.primaryColor,
                              name: widget.isEdit
                                  ? AppStrings.saveChanges
                                  : AppStrings.postAnEvent),
                        )
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
