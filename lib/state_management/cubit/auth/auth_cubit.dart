import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/state_management/providers/auth_provider.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';

import '../../../utils/sharedprefrences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  final prefs = SharedPreferencesHelper.instance;

  /**
   * TextEditing Controllers
   */
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailControllerSignup = TextEditingController();
  TextEditingController emailControllerLogin = TextEditingController();
  PhoneNumber? phoneNumber;
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController passwordControllerSignup = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
  TextEditingController confirmPasswordControllerSignup = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isTCAndPPAccepted = false;

  initControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailControllerSignup = TextEditingController();
    emailControllerLogin = TextEditingController();
    phoneNumber = null;
    zipCodeController = TextEditingController();
    passwordControllerSignup = TextEditingController();
    passwordControllerLogin = TextEditingController();
    confirmPasswordControllerSignup = TextEditingController();
    otpController = TextEditingController();
    isTCAndPPAccepted = false;
  }

  /// Save user data
  Future saveUserData() async {
    await prefs.saveUser(state.userModel!);
  }

  /// Get user data
  Future getUserData() async {
    final UserModel? userModel = await prefs.getUser();
    emit(state.copyWith(userModel: userModel));
  }

  /// Is User Login
  Future<bool> isLogin(
      {required BuildContext context, required bool mounted}) async {
    final UserModel? userModel = await prefs.getUser();

    /// User already LoggedIn
    if (userModel?.data?.apiToken != null) {
      print("isLogin: apiToken: ${userModel?.data?.apiToken}");
      emit(state.copyWith(userModel: userModel));
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.bottomTabsScreenRoute, (route) => false);
      }
      return true;
    }

    /// User not LoggedIn
    else {
      print("isLogin: apiToken: ${userModel?.data?.apiToken}");
      return false;
    }
  }

  /// Signup
  Future signUpCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    EasyLoading.show();

    final response = await signupProvider(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailControllerSignup.text,
        phone: "${phoneNumber?.countryCode}${phoneNumber?.number}",
        zipCode: zipCodeController.text,
        country: "${phoneNumber?.countryISOCode}",
        password: passwordControllerSignup.text,
        cPassword: confirmPasswordControllerSignup.text);

    if (response != null) {
      EasyLoading.dismiss();

      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(
            userModel: userModel, apiToken: userModel.data?.apiToken));
        // AppUtils.showToast(userModel.message);
        if (mounted) {
          Navigator.pushNamed(context, AppRoutes.otpVerificationScreenRoute,
              arguments: const OtpVerificationScreen(isSignUp: true));
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
    // required bool isSignUp,
    String? otp,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final response = await otpVerificationProvider(
        otp: otp, apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success: True
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        // emit(state.copyWith(userModel: userModel));
        emit(state.copyWith(
            userModel: userModel, apiToken: userModel.data?.apiToken));
        // AppUtils.showToast(userModel.message);
        return 1;
      }

      /// Success: False
      else {
        print(
            "status: ${response.data["status"]} errors: ${response.data["errors"]}");
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
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final response = await loginProvider(
        email: emailControllerLogin.text,
        password: passwordControllerLogin.text);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(userModel: userModel));
        // AppUtils.showToast(userModel.message);
        if (mounted) {
          if (userModel.data?.isVerified == 1) {
            await prefs.saveUser(userModel);
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.bottomTabsScreenRoute, (route) => false);
            }
          } else {
            Navigator.pushNamed(context, AppRoutes.otpVerificationScreenRoute,
                arguments: const OtpVerificationScreen(isLogin: true));
          }
        }
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

  /// Forgot Password
  Future<int> forgotPasswordCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final response = await forgotPasswordProvider(
        phone: "${phoneNumber?.countryCode}${phoneNumber?.number}");

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(userModel: userModel));
        // AppUtils.showToast(userModel.message);
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

  /// Reset Password
  Future resetPasswordCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final response = await resetPasswordProvider(
        password: passwordControllerSignup.text,
        apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        AppUtils.showToast(userModel.message);
        emit(state.copyWith(userModel: UserModel()));
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.loginScreenRoute, (route) => false);
        }
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
}
