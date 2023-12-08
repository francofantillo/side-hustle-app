import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/state_management/providers/auth_provider.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  /**
   * TextEditing Controllers
   */
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  PhoneNumber? phoneNumber;
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isTCAndPPAccepted = false;

  initControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumber = null;
    zipCodeController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    otpController = TextEditingController();
    isTCAndPPAccepted = false;
  }

  /// Signup
  Future signUpCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    EasyLoading.show(status: AppStrings.PLEASE_WAIT);

    final response = await signupProvider(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: "${phoneNumber?.countryCode}${phoneNumber?.number}",
        zipCode: zipCodeController.text,
        country: "${phoneNumber?.countryISOCode}",
        password: passwordController.text,
        cPassword: confirmPasswordController.text);

    if (response != null) {
      EasyLoading.dismiss();

      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(userModel: userModel));
        // AppUtils.showToast(userModel.message);
        if (mounted) {
          Navigator.pushNamed(context, AppRoutes.otpVerificationScreenRoute,
              arguments: const OtpVerificationScreen(isSocial: false));
        }
      } else if (response.data["status"] != AppValidationMessages.success) {
        print(
            "status: ${response.data["status"]} response: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      } else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// OTP VERIFICATION
  Future<int?> otpVerificationCubit({
    required BuildContext context,
    required bool mounted,
    required bool isSignUp,
    String? otp,
  }) async {
    EasyLoading.show(status: AppStrings.PLEASE_WAIT);

    final response = await otpVerificationProvider(
        otp: otp, apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success: True
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(userModel: userModel));
        // AppUtils.showToast(userModel.message);
        if (isSignUp) {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.walkthroughScreenRoute, (route) => false);
          }
          return 1;
        } else {
          if (mounted) {
            Navigator.pushReplacementNamed(
                context, AppRoutes.resetPasswordScreenRoute);
          }
          return 1;
        }
      }

      /// Success: False
      else {
        print(
            "status: ${response.data["status"]} response: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return null;
    }
  }

  /// Login
  Future loginCubit({
    required BuildContext context,
    required bool mounted,
    String? email,
    String? password,
  }) async {
    EasyLoading.show(status: AppStrings.PLEASE_WAIT);

    final response = await loginProvider(email: email, password: password);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(userModel: userModel));
        // AppUtils.showToast(userModel.message);
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.bottomTabsScreenRoute, (route) => false);
        }
        if (mounted) {
          Navigator.pushNamed(context, AppRoutes.otpVerificationScreenRoute,
              arguments: const OtpVerificationScreen(isSocial: false));
        }
      }
      /// Failer
      else {
        print(
            "status: ${response.data["status"]} response: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }
}
