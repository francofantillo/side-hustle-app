import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_alpha.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostEvent extends StatefulWidget {
  final bool isEdit;

  const PostEvent({super.key, this.isEdit = false});

  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  List<File>? itemImages;
  final _eventFormKey = GlobalKey<FormState>();
  late final EventsCubit _bloc;

  // String? _errorMsgEventName;

  final List<String> items = [
    PaymentTypeEnum.Cash.name,
    PaymentTypeEnum.Card.name,
  ];

  @override
  void initState() {
    AppUtils.firstSelectedTime = null;
    AppUtils.secondSelectedTime = null;
    _bloc = BlocProvider.of<EventsCubit>(context);
    _bloc.initPostEventControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle:
          widget.isEdit ? AppStrings.editEvent : AppStrings.postAnEvent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
        return Form(
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
                  ImageSlider(
                    // itemImages: itemImages,
                    fileImages: state.itemImagesFile,
                    indicatorLength: state.itemImagesFile?.length,
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
                        LengthLimitingTextInputFormatter(100),
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
                        await _bloc.selectLocation(context: context, mounted: mounted);
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
                        final formattedDate = await AppUtils.selectDate(
                            context: context, initialDate: DateTime.now());
                        _bloc.dateTextController.text = formattedDate ?? "";
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                size: AppDimensions.imageIconSizeTextFormField,
                                color: AppColors.greyColorNoOpacity,
                              ),
                              isSuffixIcon: true,
                              isReadonly: true,
                              fieldValidator: (value) => value?.validateEmpty(
                                AppStrings.startTime,
                              ),
                              onTap: () async {
                                await AppUtils.selectTime(context, true);
                                print(
                                    "selected time: ${AppUtils.firstSelectedTime}");
                                if (mounted) {
                                  _bloc.startTimeTextController.text =
                                      AppUtils.firstSelectedTime != null
                                          ? AppUtils.firstSelectedTime!
                                              .format(context)
                                          : "";
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                size: AppDimensions.imageIconSizeTextFormField,
                                color: AppColors.greyColorNoOpacity,
                              ),
                              isSuffixIcon: true,
                              isReadonly: true,
                              fieldValidator: (value) => value?.validateEmpty(
                                AppStrings.endTime,
                              ),
                              onTap: () async {
                                await AppUtils.selectTime(context, false);
                                if (mounted) {
                                  _bloc.endTimeTextController.text =
                                      AppUtils.secondSelectedTime != null
                                          ? AppUtils.secondSelectedTime!
                                              .format(context)
                                          : "";
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
                      fieldValidator: (value) =>
                          value?.validateEmpty(AppStrings.eventVendorList),
                      // fillColor: AppColors.productTextFieldColor,
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
                        signed: false, decimal: true),
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(
                          Constants.priceFieldCharacterLength),
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
                  // SizedBox(
                  //   width: 1.sh,
                  //   child: CustomDropDown(
                  //     items: items,
                  //     hintText: AppStrings.paymentTypeHint,
                  //     selectedValue: (v) {
                  //       print("selectedValue: $v");
                  //     },
                  //   ),
                  // ),
                  CustomTextFormField(
                    height: 45.h,
                    hintText: AppStrings.paymentTypeHint,
                    isReadonly: true,
                    // fillColor: AppColors.productTextFieldColor,
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: textWidget(
                  //       text: AppStrings.eventVendorList,
                  //       maxLines: 1,
                  //       color: AppColors.textBlackColor,
                  //       fontSize: AppDimensions.textSizeSmall,
                  //       fontFamily: AppFont.gilroyBold,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  // height(0.01.sw),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  //   child: CustomTextFormField(
                  //     controller: _bloc.eventAvailableTextController,
                  //     height: 45.h,
                  //     hintText: AppStrings.eventAvailableAttractionsHint,
                  //     fieldValidator: (value) =>
                  //         value?.validateEmpty(AppStrings.eventVendorList),
                  //     // fillColor: AppColors.productTextFieldColor,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CustomTextFormField(
                      controller: _bloc.eventAvailableTextController,
                      height: 65.h,
                      hintText: AppStrings.eventAvailableAttractionsHint,
                      maxLines: 1,
                      fieldValidator: (value) => value
                          ?.validateEmpty(AppStrings.eventAvailableAttractions),
                      // fillColor: AppColors.productTextFieldColor,
                    ),
                  ),
                  height(AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomMaterialButton(
                        onPressed: () async {
                          if (widget.isEdit) {
                            Navigator.pop(context);
                          } else {
                            // AppUtils.showBottomModalSheet(
                            //     context: context,
                            //     widget: const ModalBottomSheetPackageTypePost(
                            //       isEvent: true,
                            //     ));
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_eventFormKey.currentState!.validate()) {
                              await _bloc.postAnEventCubit(
                                  context: context, mounted: mounted);
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
