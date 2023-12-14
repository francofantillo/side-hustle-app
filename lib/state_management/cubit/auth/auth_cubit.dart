import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/reset_bloc.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/state_management/providers/auth/auth_provider.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';

import '../../../utils/sharedprefrences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future resetAuthBloc() async {
    emit(AuthState());
  }

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
  TextEditingController existingPasswordController = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
  TextEditingController confirmPasswordControllerSignup =
      TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isTCAndPPAccepted = false;

  initControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    existingPasswordController = TextEditingController();
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

  /**
   * Save user data
   */
  Future saveUserData() async {
    await prefs.saveToken(state.userModel!.data!.apiToken!);
    await prefs.saveUser(state.userModel!);
  }

  /**
   * Get user data
   */
  Future getUserData() async {
    final UserModel? userModel = await prefs.getUser();
    emit(state.copyWith(userModel: userModel));
  }

  /**
   * Is User Login
   */
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

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(userModel: userModel));
        // AppUtils.showToast(userModel.message);
        if (mounted) {
          Navigator.pushNamed(context, AppRoutes.otpVerificationScreenRoute,
              arguments: const OtpVerificationScreen(isSignUp: true));
        }
      }

      /// Failed
      else {
        print(
            "status: ${response.data["status"]} response: ${response.data["errors"]}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
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

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        // emit(state.copyWith(userModel: userModel));
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
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return null;
    }
  }

  /// Resend OTP
  Future<int?> resendOTPCubit({
    required BuildContext context,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final response =
        await resendOTPProvider(apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print(
            "status: ${response.data["status"]} response: ${response.data["data"]}");
        // emit(state.copyWith(userModel: userModel));
        AppUtils.showToast(response.data["message"]);
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
            await prefs.saveToken(userModel.data!.apiToken!);
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
      EasyLoading.dismiss();
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
      EasyLoading.dismiss();
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
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Change Password
  Future changePasswordCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.show();

    final response = await changePasswordProvider(
        existingPassword: existingPasswordController.text,
        password: passwordControllerSignup.text,
        apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

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
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Logout
  Future logoutCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    // EasyLoading.show(status: AppStrings.PLEASE_WAIT);
    EasyLoading.instance.indicatorColor = AppColors.whiteColor;
    EasyLoading.show();

    final response =
        await logoutProvider(apiToken: state.userModel?.data?.apiToken);

    /// Rest EasyLoading Indicator Color
    // EasyLoading.instance.indicatorColor = AppColors.primaryColor;

    if (response != null) {
      EasyLoading.dismiss();
      EasyLoading.instance.indicatorColor = AppColors.primaryColor;

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print(
            "status: ${response.data["status"]} response: ${response.data["data"]}");
        AppUtils.showToast(response.data["message"]);
        // emit(state.copyWith(userModel: UserModel()));
        /// Reset Blocs
        if (mounted) {
          await ClearAppData.resetBlocs(context: context).then((value) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.splashScreenRoute, (route) => false);
          });
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
