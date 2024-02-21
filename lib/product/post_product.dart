import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/state_management/models/card_model.dart';
import 'package:side_hustle/state_management/models/get_edit_side_hustle_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/utils/validation/regular_expressions.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/dropdown/dropdown.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/checkbox.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostProduct extends StatefulWidget {
  final bool isEdit;
  final int? id;
  final bool isEditFromShop;

  const PostProduct(
      {super.key, this.isEdit = false, this.id, this.isEditFromShop = false});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  late final SideHustleCubit _bloc;
  late final CardCubit _blocCard;
  String? dropdownValue;
  final _productsFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bloc = BlocProvider.of<SideHustleCubit>(context);
    _blocCard = BlocProvider.of(context);
    _bloc.initControllers();
    dropdownValue = AppStrings.deliveryOptionPickup;
    _bloc.type = DeliveryTypeEnum.Pickup.name;
    widget.id != null
        ? getProduct()
        : _bloc.state.editSideHustleModel = GetEditSideHustleModel();
    super.initState();
  }

  Future getProduct() async {
    await _bloc
        .getEditProductOrServiceCubit(
            context: context, mounted: mounted, id: widget.id)
        // context: context,
        // mounted: mounted,
        // id: 17)
        .then((value) {
      if (value != null) {
        final data = value.editSideHustleData;
        // print("getEvent lat: ${data?.lat}");
        // print("getEvent lng: ${data?.lng}");
        _bloc.titleTextController.text = data?.name ?? "";
        // _bloc.locationTextController.text = data?.location ?? "";
        _bloc.descriptionTextController.text = data?.description ?? "";
        _bloc.additionalInfoTextController.text =
            data?.additionalInformation ?? "";
        _bloc.zipCodeTextController.text = data?.zipCode ?? "";
        _bloc.priceTextController.text = data?.price?.toStringAsFixed(2) ?? "";
        if (data?.deliveryType != null) {
          if (data!.deliveryType == DeliveryTypeEnum.Pickup.name) {
            _bloc.type = data.deliveryType;
            dropdownValue = AppStrings.deliveryOptionPickup;
            print(
                "deliveryType: ${data?.deliveryType}, dropdownValue: $dropdownValue");
          } else if (data.deliveryType == DeliveryTypeEnum.Fixed.name) {
            _bloc.type = data.deliveryType;
            dropdownValue = AppStrings.deliveryOptionCOD;
            print(
                "deliveryType: ${data?.deliveryType}, dropdownValue: $dropdownValue");
          }
        }
      }
    });
  }

  Future getCards({required bool isEdit}) async {
    print("getCards: $isEdit");
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
        if (isEdit) {
          AppUtils.showBottomModalSheet(
              context: context,
              widget: ModalBottomSheetPackageTypePost(
                  isProduct: true, defaultCardId: cardId));
        } else {
          AppUtils.showBottomModalSheet(
              context: context,
              widget: ModalBottomSheetPackageTypePost(
                  isProduct: true, defaultCardId: cardId));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: widget.isEdit
          ? AppStrings.editYourSideHustle
          : AppStrings.postYourSideHustle,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<SideHustleCubit, SideHustleState>(
          builder: (context, state) {
        return state.editSideHustleLoading
            ? const SizedBox.shrink()
            : Form(
                key: _productsFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.rootPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ImageSliderAlpha(
                        //   itemImages: AlphaAppData.postProductImagesList,
                        // ),
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
                              text: AppStrings.uploadImages,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                            text: AppStrings.uploadImagesBodyProduct,
                            fontSize: AppDimensions.textSizeVerySmall,
                            fontFamily: AppFont.gilroyMedium,
                            maxLines: 2,
                          ),
                        ),
                        height(0.04.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.productName,
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
                            height: 45.h,
                            hintText: AppStrings.enterTheProductName,
                            controller: _bloc.titleTextController,
                            fieldValidator: (value) =>
                                value?.validateEmpty(AppStrings.productName),
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.singleFieldCharacterLength),
                            ],
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: textWidget(
                        //       text: AppStrings.location,
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
                        //     height: 45.h,
                        //     hintText: AppStrings.enterTheLocation,
                        //     isReadonly: true,
                        //     onTap: () async {
                        //       await _bloc.selectLocation(
                        //           context: context, mounted: mounted);
                        //     },
                        //     suffixIcon: Icon(
                        //       Icons.my_location,
                        //       size: AppDimensions.imageIconSizeTextFormField,
                        //       color: Colors.black,
                        //     ),
                        //     isSuffixIcon: true,
                        //     controller: _bloc.locationTextController,
                        //     fieldValidator: (value) =>
                        //         value?.validateEmpty(AppStrings.location),
                        //   ),
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     CheckboxWidget(
                        //       onChanged: (newValue) {
                        //         if (newValue!) {
                        //           _bloc.isShopLocation = 1;
                        //         } else {
                        //           _bloc.isShopLocation = 0;
                        //         }
                        //         print(
                        //             'Checkbox value changed: $newValue, _bloc.isShopLocation: ${_bloc.isShopLocation}');
                        //       },
                        //     ),
                        //     Expanded(
                        //         child: Padding(
                        //       padding: const EdgeInsets.only(top: 2.0),
                        //       child: textWidget(
                        //           text: AppStrings.useYourShopLocation,
                        //           fontFamily: AppFont.gilroyMedium,
                        //           fontSize: AppDimensions.textSizeVerySmall),
                        //     )),
                        //   ],
                        // ),
                        // height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.productDescription,
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
                            height: 45.h,
                            hintText: AppStrings.enterTheProductDescription,
                            controller: _bloc.descriptionTextController,
                            fieldValidator: (value) => value
                                ?.validateEmpty(AppStrings.productDescription),
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.descriptionFieldCharacterLength),
                            ],
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
                                        text: AppStrings.productPricing,
                                        maxLines: 1,
                                        color: AppColors.textBlackColor,
                                        fontSize: AppDimensions.textSizeSmall,
                                        fontFamily: AppFont.gilroyBold,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  height(0.01.sw),
                                  CustomTextFormField(
                                    height: 45.h,
                                    hintText: "\$\$\$",
                                    controller: _bloc.priceTextController,
                                    fieldValidator: (value) =>
                                        value?.validateEmpty(
                                            AppStrings.productPricing),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    inputFormatter: [
                                      LengthLimitingTextInputFormatter(
                                          Constants.priceFieldCharacterLength),
                                      RegularExpressions.PRICE_FORMATTER
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            width(0.015.sw),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: textWidget(
                                        text: AppStrings.zipCode,
                                        maxLines: 1,
                                        color: AppColors.textBlackColor,
                                        fontSize: AppDimensions.textSizeSmall,
                                        fontFamily: AppFont.gilroyBold,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  height(0.01.sw),
                                  CustomTextFormField(
                                    height: 45.h,
                                    hintText: "00000",
                                    controller: _bloc.zipCodeTextController,
                                    keyboardType: TextInputType.phone,
                                    fieldValidator: (value) => value
                                        ?.validateEmpty(AppStrings.zipCode),
                                    inputFormatter: [
                                      LengthLimitingTextInputFormatter(Constants
                                          .zipCodeFieldCharacterLength),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
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
                              text: AppStrings.deliveryOptions,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        SizedBox(
                          width: 1.sw,
                          child: CustomDropDown(
                            items: AppUtils.items,
                            hintText: AppStrings.pickUp,
                            dropdownValue: dropdownValue,
                            selectedValue: (v) {
                              print("selectedValue: $v");
                              if (v != null) {
                                if (v == AppStrings.deliveryOptionPickup) {
                                  _bloc.type = DeliveryTypeEnum.Pickup.name;
                                } else {
                                  _bloc.type = DeliveryTypeEnum.Fixed.name;
                                }
                                if (kDebugMode) {
                                  print("_bloc.type: ${_bloc.type}");
                                }
                              }
                            },
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.additionalInformation,
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
                            height: 45.h,
                            hintText: AppStrings.enterTheAdditionalInformation,
                            fillColor: AppColors.textFieldBackgroundColor,
                            controller: _bloc.additionalInfoTextController,
                            fieldValidator: (value) => value?.validateEmpty(
                                AppStrings.additionalInformation),
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.descriptionFieldCharacterLength),
                            ],
                          ),
                        ),
                        height(
                            AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomMaterialButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus!.unfocus();
                              if (widget.isEdit) {
                                await _bloc.editProductCubit(
                                    context: context,
                                    id: widget.id,
                                    mounted: mounted,
                                    isEditFromShop: widget.isEditFromShop);
                              } else {
                                if (_productsFormKey.currentState!.validate()) {
                                  await getCards(isEdit: widget.isEdit);
                                }
                              }
                            },
                            color: AppColors.primaryColor,
                            name: widget.isEdit
                                ? AppStrings.saveChanges
                                : AppStrings.addProduct,
                          ),
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
