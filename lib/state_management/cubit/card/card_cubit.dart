import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/state_management/providers/card/card.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/sharedprefrences.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardState());

  Future resetCardBloc() async {
    emit(CardState());
  }

  final prefs = SharedPreferencesHelper.instance;

  /// Change Password
  Future addCardCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.instance.indicatorColor = AppColors.whiteColor;
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await addCardProvider(apiToken: token);

    if (response != null) {
      EasyLoading.dismiss();
      EasyLoading.instance.indicatorColor = AppColors.primaryColor;

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print(
            "status: ${response.data["status"]} response: ${response.data["data"]}");
        AppUtils.showToast(response.data["message"]);
        if (mounted) {
          Navigator.pop(context);
        }
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.instance.indicatorColor = AppColors.primaryColor;
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }
}
