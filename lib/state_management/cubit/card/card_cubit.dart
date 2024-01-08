import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:side_hustle/state_management/models/card_model.dart';
import 'package:side_hustle/state_management/providers/card/card_provider.dart';
import 'package:side_hustle/state_management/service/stripe_service.dart';
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

  /// Add Card
  Future addCardCubit(
      {required BuildContext context,
      required bool mounted,
      required String? cardHolder,
      required String? last4,
      required CardDetails cardDetails}) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.instance.indicatorColor = AppColors.whiteColor;
    EasyLoading.show();

    final _cardToken =
        await StripeService.getCardToken(cardDetails: cardDetails);
    print("cardToken: $_cardToken");
    if (_cardToken == null) {
      EasyLoading.dismiss();
      EasyLoading.instance.indicatorColor = AppColors.primaryColor;
      AppUtils.showToast("Error obtaining card token");
      return;
    }

    final token = await prefs.getToken();

    final response = await addCardProvider(
        apiToken: token,
        cardToken: _cardToken,
        cardHolder: cardHolder,
        last4: last4);

    EasyLoading.instance.indicatorColor = AppColors.primaryColor;

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print("response: ${response.data}");
        final CardModel cardModel = CardModel.fromJson(response.data);
        emit(state.copyWith(cardModel: cardModel));
        AppUtils.showToast(cardModel.message);
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
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Default Card
  Future defaultCardCubit(
      {required BuildContext context,
      required bool mounted,
      required int? cardId}) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final token = await prefs.getToken();

    final response =
        await setDefaultCardProvider(apiToken: token, cardId: cardId);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print("response: ${response.data}");
        final CardModel cardModel = CardModel.fromJson(response.data);
        emit(state.copyWith(cardModel: cardModel));
        AppUtils.showToast(cardModel.message);
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get Cards
  Future getCardsCubit(
      {required BuildContext context, required bool mounted}) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    emit(state.copyWith(cardModel: CardModel()));
    EasyLoading.show();

    final token = await prefs.getToken();

    final response = await getCardsProvider(apiToken: token);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print("response: ${response.data}");
        final CardModel cardModel = CardModel.fromJson(response.data);
        emit(state.copyWith(cardModel: cardModel));
        AppUtils.showToast(cardModel.message);
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }
}
