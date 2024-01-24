import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/state_management/models/favourites_model.dart';
import 'package:side_hustle/state_management/providers/favourites/favourites_provider.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesState());

  Future resetFavouritesBloc() async {
    emit(FavouritesState());
  }

  final prefs = SharedPreferencesHelper.instance;

  /// Get Favourites
  Future getFavouritesCubit({
    required BuildContext context,
    required bool mounted,
    required String type,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(
        favouritesModelLoading: true, favouritesModel: FavouritesModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getFavouritesProvider(type: type, apiToken: token);

    EasyLoading.dismiss();
    emit(state.copyWith(favouritesModelLoading: false));

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        FavouritesModel favouritesModel =
            FavouritesModel.fromJson(response.data);
        print(
            "status: ${response.data["status"]} response: ${favouritesModel.favourites}");
        emit(state.copyWith(favouritesModel: favouritesModel));
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Add To Fav
  Future<int> addToFavCubit({
    required BuildContext context,
    required bool mounted,
    required String type,
    required int? id,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final token = await prefs.getToken();
    print("token: $token");

    final response =
        await addToFavProvider(id: id, type: type, apiToken: token);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print("status: ${response.data["status"]} response: ${response.data}");
        // AppUtils.showToast(response.data["message"]);
        return 1;
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }

  /// Remove From Fav
  Future<int> removeFromFavCubit({
    required BuildContext context,
    required bool mounted,
    required String type,
    required int? id,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final token = await prefs.getToken();

    final response =
        await removeFromFavProvider(id: id, type: type, apiToken: token);

    EasyLoading.dismiss();

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        FavouritesModel favouritesModel =
            FavouritesModel.fromJson(response.data);
        print(
            "status: ${response.data["status"]} response: ${favouritesModel.favourites}");
        // AppUtils.showToast(favouritesModel.message);
        emit(state.copyWith(favouritesModel: favouritesModel));
        return 1;
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }
}
