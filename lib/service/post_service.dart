import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_package_type.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/state_management/models/card_model.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
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
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_alpha.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/checkbox.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class PostService extends StatefulWidget {
  final bool isEdit;

  const PostService({super.key, this.isEdit = false});

  @override
  State<PostService> createState() => _PostServiceState();
}

class _PostServiceState extends State<PostService> {
  late final SideHustleCubit _bloc;
  late final CardCubit _blocCard;
  final _servicesFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    _blocCard = BlocProvider.of(context);
    _bloc.initControllers();
    _bloc.type = ServiceTypeEnum.Hourly.name;
    super.initState();
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
                  isService: true, defaultCardId: cardId));
        } else {
          AppUtils.showBottomModalSheet(
              context: context,
              widget: ModalBottomSheetPackageTypePost(
                  isService: true, defaultCardId: cardId));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: widget.isEdit
          ? AppStrings.editYourSideHustleService
          : AppStrings.postYourSideHustleService,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<SideHustleCubit, SideHustleState>(
          builder: (context, state) {
        return state.editServiceLoading
            ? const SizedBox.shrink()
            : Form(
                key: _servicesFormKey,
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
                        //   itemImages: AlphaAppData.postServiceImagesList,
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
                            text: AppStrings.uploadImagesBodyService,
                            fontSize: AppDimensions.textSizeVerySmall,
                            fontFamily: AppFont.gilroyMedium,
                            maxLines: 2,
                          ),
                        ),
                        height(0.04.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.serviceName,
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
                            hintText: AppStrings.enterTheServiceName,
                            controller: _bloc.titleTextController,
                            fieldValidator: (value) =>
                                value?.validateEmpty(AppStrings.serviceName),
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
                              text: AppStrings.location,
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
                            hintText: AppStrings.enterTheLocation,
                            isReadonly: true,
                            onTap: () async {
                              await _bloc.selectLocation(
                                  context: context, mounted: mounted);
                            },
                            suffixIcon: Icon(
                              Icons.my_location,
                              color: Colors.black,
                              size: AppDimensions.imageIconSizeTextFormField,
                            ),
                            isSuffixIcon: true,
                            controller: _bloc.locationTextController,
                            fieldValidator: (value) =>
                                value?.validateEmpty(AppStrings.location),
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.singleFieldCharacterLength),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CheckboxWidget(
                              onChanged: (newValue) {
                                if (newValue!) {
                                  _bloc.isShopLocation = 1;
                                } else {
                                  _bloc.isShopLocation = 0;
                                }
                                print(
                                    'Checkbox value changed: $newValue, _bloc.isShopLocation: ${_bloc.isShopLocation}');
                              },
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: textWidget(
                                  text: AppStrings.useYourShopLocation,
                                  fontFamily: AppFont.gilroyMedium,
                                  fontSize: AppDimensions.textSizeVerySmall),
                            )),
                          ],
                        ),
                        // height(0.02.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.serviceDescription,
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
                            hintText: AppStrings.enterServiceDescription,
                            controller: _bloc.descriptionTextController,
                            fieldValidator: (value) => value
                                ?.validateEmpty(AppStrings.serviceDescription),
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(
                                  Constants.descriptionFieldCharacterLength),
                            ],
                          ),
                        ),
                        height(AppDimensions.formFieldsBetweenSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.howWouldYouLikeToSellService,
                              maxLines: 1,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            CheckboxWidget(
                              isChecked: true,
                              onChanged: (newValue) {
                                if (newValue!) {
                                  _bloc.type = ServiceTypeEnum.Hourly.name;
                                }
                                print(
                                    'Checkbox value changed: $newValue, _bloc.type: ${_bloc.type}');
                              },
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: textWidget(
                                text: AppStrings.hourlyRate,
                                fontSize: AppDimensions.textSizeSmall,
                                fontFamily: AppFont.gilroySemiBold,
                              ),
                            )),
                            CheckboxWidget(
                              onChanged: (newValue) {
                                if (newValue!) {
                                  _bloc.type = ServiceTypeEnum.Fixed.name;
                                }
                                print(
                                    'Checkbox value changed: $newValue, _bloc.type: ${_bloc.type}');
                              },
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: textWidget(
                                text: AppStrings.fixedRate,
                                fontSize: AppDimensions.textSizeSmall,
                                fontFamily: AppFont.gilroyMedium,
                              ),
                            )),
                          ],
                        ),
                        // height(0.02.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: textWidget(
                              text: AppStrings.serviceHourlyRate,
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
                          fieldValidator: (value) => value
                              ?.validateEmpty(AppStrings.serviceHourlyRate),
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
                              text: AppStrings.additionalInformation,
                              color: AppColors.textBlackColor,
                              fontSize: AppDimensions.textSizeSmall,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold),
                        ),
                        height(0.01.sw),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CustomTextFormField(
                            height: 65.h,
                            hintText:
                                AppStrings.pleaseEnterAdditionalInformation,
                            maxLines: 1,
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
                                if (widget.isEdit) {
                                  Navigator.pop(context);
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_servicesFormKey.currentState!
                                      .validate()) {
                                    await getCards(isEdit: widget.isEdit);
                                  }
                                  // Navigator.pushReplacementNamed(
                                  //     context, AppRoutes.postAddedScreenRoute,
                                  //     arguments: const PostAdded(
                                  //       isService: true,
                                  //       title: AppStrings.sideHustlePosted,
                                  //       subTitle: AppStrings.sideHustlePostedSubTitle,
                                  //       buttonName: AppStrings.viewSideHustle,
                                  //     ));
                                  // _bloc.type

                                  // AppUtils.showBottomModalSheet(
                                  //     context: context,
                                  //     widget:
                                  //         const ModalBottomSheetPackageTypePost(
                                  //       isService: true,
                                  //     ));
                                }
                              },
                              color: AppColors.primaryColor,
                              name: widget.isEdit
                                  ? AppStrings.saveChanges
                                  : AppStrings.addService),
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
