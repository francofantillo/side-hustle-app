import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/state_management/models/get_edit_side_hustle_model.dart';
import 'package:side_hustle/state_management/models/select_location_model.dart';
import 'package:side_hustle/state_management/models/your_shop_model.dart';
import 'package:side_hustle/state_management/providers/side_hustle/side_hustle_provider.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

part 'side_hustle_state.dart';

class SideHustleCubit extends Cubit<SideHustleState> {
  SideHustleCubit() : super(SideHustleState());

  final prefs = SharedPreferencesHelper.instance;

  SelectLocationModel? selectLocationModel;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController zipCodeTextController = TextEditingController();
  TextEditingController additionalInfoTextController = TextEditingController();
  TextEditingController yourShopNameTextController = TextEditingController();
  TextEditingController yourZipCodeTextController = TextEditingController();
  TextEditingController yourAddressTextController = TextEditingController();
  String? type;
  int isShopLocation = 0;

  initControllers() {
    titleTextController = TextEditingController();
    locationTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    priceTextController = TextEditingController();
    zipCodeTextController = TextEditingController();
    additionalInfoTextController = TextEditingController();
    yourShopNameTextController = TextEditingController();
    yourZipCodeTextController = TextEditingController();
    yourAddressTextController = TextEditingController();
    selectLocationModel = null;
    type = null;
    isShopLocation = 0;
    emit(state.copyWith(images: []));
  }

  initShopControllers() {
    yourShopNameTextController = TextEditingController();
    yourZipCodeTextController = TextEditingController();
    yourAddressTextController = TextEditingController();
    selectLocationModel = null;
  }

  /// Select Multiple Images
  Future selectMultiImages() async {
    List<File>? images =
        await ImagePickerService.selectMultipleImagesFromGallery();
    if (images != null && images.isNotEmpty) {
      final List<Images>? imagesList = state.images;
      for (int i = 0; i < images.length; i++) {
        imagesList!.add(Images(image: images[i].path));
      }
      emit(state.copyWith(images: imagesList));
    }
  }

  setIsProductOrServiceFromYourShop(
      {required bool isProductOrServiceFromHome}) {
    emit(
        state.copyWith(isProductOrServiceFromHome: isProductOrServiceFromHome));
  }

  /// Select Location
  Future selectLocation(
      {required BuildContext context, required bool mounted}) async {
    final SelectLocationModel? location =
        await AppUtils.selectLocation(context: context, mounted: mounted);

    if (location != null) {
      locationTextController.text = location.locationAddress ?? "";
      selectLocationModel = location;
    }
  }

  /// Add Product
  Future<int> addProductCubit({
    required BuildContext context,
    required int planId,
    required bool mounted,
  }) async {
    EasyLoading.show();

    final String? lat = selectLocationModel?.lat?.toString();
    final String? lng = selectLocationModel?.lng?.toString();
    print("lat: $lat");
    print("lng: $lng");

    final token = await prefs.getToken();

    List<File> itemImagesFile = [];
    for (int i = 0; i < state.images!.length; i++) {
      if (state.images![i].image != null &&
          !(state.images![i].image!.contains("http"))) {
        itemImagesFile.add(File(state.images![i].image!));
        print("postJobCubit itemImagesFile: ${state.images![i].image}");
      }
    }

    final response = await addProductProvider(
        apiToken: token,
        name: titleTextController.text,
        location: locationTextController.text,
        lat: lat,
        lng: lng,
        images: itemImagesFile,
        isShopLocation: isShopLocation,
        deliveryType: type,
        description: descriptionTextController.text,
        additionalInformation: additionalInfoTextController.text,
        price: priceTextController.text,
        planId: planId.toString(),
        zipCode: zipCodeTextController.text);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        YourShopModel yourShopModel = YourShopModel.fromJson(response.data);
        emit(state.copyWith(yourShopModel: yourShopModel));
        final id = yourShopModel.shopData?.products?.last.id;
        AppUtils.showToast(response.data["message"]);
        if (mounted) {
          if (state.isProductOrServiceFromHome) {
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, AppRoutes.postAddedScreenRoute,
                arguments: PostAdded(
                  id: id,
                  isProduct: true,
                  title: AppStrings.sideHustlePosted,
                  subTitle: AppStrings.sideHustlePostedSubTitle,
                  buttonName: AppStrings.viewSideHustle,
                ));
          }
        }
        return id ?? 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }

  /// Add Service
  Future<int> addServiceCubit({
    required BuildContext context,
    required int planId,
    required bool mounted,
  }) async {
    EasyLoading.show();

    final String? lat = selectLocationModel?.lat?.toString();
    final String? lng = selectLocationModel?.lng?.toString();
    print("lat: $lat");
    print("lng: $lng");

    final token = await prefs.getToken();

    List<File> itemImagesFile = [];
    for (int i = 0; i < state.images!.length; i++) {
      if (state.images![i].image != null &&
          !(state.images![i].image!.contains("http"))) {
        itemImagesFile.add(File(state.images![i].image!));
        print("postJobCubit itemImagesFile: ${state.images![i].image}");
      }
    }

    final response = await addServiceProvider(
        apiToken: token,
        name: titleTextController.text,
        location: locationTextController.text,
        lat: lat,
        lng: lng,
        images: itemImagesFile,
        isShopLocation: isShopLocation,
        serviceType: type,
        description: descriptionTextController.text,
        additionalInformation: additionalInfoTextController.text,
        hourlyRate: priceTextController.text,
        planId: planId.toString());
    // zipCode: areaCodeTextController.text);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        YourShopModel yourShopModel = YourShopModel.fromJson(response.data);
        emit(state.copyWith(yourShopModel: yourShopModel));
        final id = yourShopModel.shopData?.services?.last.id;
        AppUtils.showToast(response.data["message"]);
        if (mounted) {
          if (state.isProductOrServiceFromHome) {
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, AppRoutes.postAddedScreenRoute,
                arguments: PostAdded(
                  id: id,
                  isService: true,
                  title: AppStrings.sideHustlePosted,
                  subTitle: AppStrings.sideHustlePostedSubTitle,
                  buttonName: AppStrings.viewSideHustle,
                ));
          }
        }
        return id ?? 1;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }

  /// Get Edit Product or Service
  Future<GetEditSideHustleModel?> getEditProductOrServiceCubit(
      {required BuildContext context,
      required bool mounted,
      required int? id}) async {
    emit(state.copyWith(
        editSideHustleLoading: true,
        editSideHustleModel: GetEditSideHustleModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response =
        await getEditProductOrServiceProvider(id: id, apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        GetEditSideHustleModel getEditSideHustleModeljobsDetail =
            GetEditSideHustleModel.fromJson(response.data);
        // AppUtils.showToast(response.data['message']);
        emit(state.copyWith(
            editSideHustleLoading: false,
            editSideHustleModel: getEditSideHustleModeljobsDetail,
            images: getEditSideHustleModeljobsDetail
                    .editSideHustleData?.productImages ??
                []));
        return getEditSideHustleModeljobsDetail;
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(editSideHustleLoading: false));
        return null;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      emit(state.copyWith(editSideHustleLoading: false));
      return null;
    }
  }

  /// Get Your Shop
  Future getYourShopCubit(
      {required BuildContext context, required bool mounted}) async {
    emit(state.copyWith(yourShopLoading: true, yourShopModel: YourShopModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    print("token: $token");

    final response = await getYourShopProvider(apiToken: token);

    print("status code: ${response?.statusCode}");

    EasyLoading.dismiss();
    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        YourShopModel yourShopModel = YourShopModel.fromJson(response.data);
        titleTextController.text =
            yourShopModel.shopData?.shopDetail?.name ?? "";
        // zipCodeTextController.text = yourShopModel.shopData?.shopDetail?. ?? "";
        locationTextController.text =
            yourShopModel.shopData?.shopDetail?.location ?? "";
        emit(state.copyWith(
            yourShopLoading: false, yourShopModel: yourShopModel));
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        emit(state.copyWith(yourShopLoading: false));
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      emit(state.copyWith(yourShopLoading: false));
    }
  }

  /// Edit Your Shop
  Future editYourShopCubit(
      {required BuildContext context,
      required bool mounted,
      String? image}) async {
    EasyLoading.show();

    final String? lat = selectLocationModel?.lat?.toString();
    final String? lng = selectLocationModel?.lng?.toString();
    print("lat: $lat");
    print("lng: $lng");

    final token = await prefs.getToken();

    print("token: $token");

    final response = await editYourShopProvider(
        shopId: state.yourShopModel?.shopData?.shopDetail?.id,
        name: titleTextController.text,
        zipCode: zipCodeTextController.text,
        location: locationTextController.text,
        image: image,
        lat: lat,
        lng: lng,
        apiToken: token);

    print("status code: ${response?.statusCode}");

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        YourShopModel yourShopModel = YourShopModel.fromJson(response.data);
        titleTextController.text =
            yourShopModel.shopData?.shopDetail?.name ?? "";
        // zipCodeTextController.text = yourShopModel.shopData?.shopDetail?. ?? "";
        locationTextController.text =
            yourShopModel.shopData?.shopDetail?.location ?? "";
        emit(state.copyWith(
            yourShopLoading: false, yourShopModel: yourShopModel));
        EasyLoading.dismiss();
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
    }
  }
}
