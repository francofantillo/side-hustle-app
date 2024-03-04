import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/reset_bloc.dart';
import 'package:side_hustle/state_management/models/dashboard_model.dart';
import 'package:side_hustle/state_management/models/profile_model.dart';
import 'package:side_hustle/state_management/models/resume_model.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/state_management/providers/auth/auth_provider.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/service/firebase_service.dart';

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
  /*
    String? actualName,
  String? nickName,
  String? familyTies,
  String? professionalBackground,
  String? favouriteQuote,
  String? description,
  List<String>? hobbies,
   */

  /// Resume Controllers
  TextEditingController actualNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController familyTiesController = TextEditingController();
  TextEditingController professionalBackgroundController =
      TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController favouriteQuoteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> hobbies = [];
  String? profileImagePath;
  String? pdfFilePath;

  /// Auth Controllers
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

  initResumeControllers() {
    actualNameController = TextEditingController();
    nickNameController = TextEditingController();
    familyTiesController = TextEditingController();
    professionalBackgroundController = TextEditingController();
    professionController = TextEditingController();
    favouriteQuoteController = TextEditingController();
    descriptionController = TextEditingController();
    hobbies = [];
    profileImagePath = null;
    pdfFilePath = null;
  }

  /// Set Fav Events
  // Future setFavEvents({required int index, required int isFavourite}) async {
  //   final objEvent = state.dashboardModel;
  //   objEvent?.events?[index].isFavourite = isFavourite;
  //   emit(state.copyWith(eventsModel: objEvent));
  // }

  /// Set Fav Jobs
  // Future setFavEvents({required int index, required int isFavourite}) async {
  //   final objEvent = state.dashboardModel;
  //   objEvent?.events?[index].isFavourite = isFavourite;
  //   emit(state.copyWith(eventsModel: objEvent));
  // }

  setResumeController() {
    actualNameController.text = state.resumeModel?.data?.actualName ?? "";
    nickNameController.text = state.resumeModel?.data?.nickName ?? "";
    familyTiesController.text = state.resumeModel?.data?.familyTies ?? "";
    professionalBackgroundController.text =
        state.resumeModel?.data?.professionalBackground ?? "";
    professionController.text = state.resumeModel?.data?.profession ?? "";
    favouriteQuoteController.text =
        state.resumeModel?.data?.favouriteQuote ?? "";
    descriptionController.text = state.resumeModel?.data?.description ?? "";
    profileImagePath = state.resumeModel?.data?.profileImage;
    pdfFilePath = state.resumeModel?.data?.file;
  }

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
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        emit(state.copyWith(userModel: userModel));
        final String? deviceToken = await FirebaseMessagingService().getToken();
        print("Firebase Token: $deviceToken");
        if (mounted) {
          await updateFCMCubit(
              context: context, mounted: mounted, fcmToken: deviceToken);
        }
        EasyLoading.dismiss();
        return 1;
      }

      /// Failed
      else {
        EasyLoading.dismiss();
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
    // EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.fadingCube;
    EasyLoading.show();

    final response = await loginProvider(
        email: emailControllerLogin.text,
        password: passwordControllerLogin.text);

    if (response != null) {
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
            final String? deviceToken =
                await FirebaseMessagingService().getToken();
            print("Firebase Token: $deviceToken");
            if (mounted) {
              await updateFCMCubit(
                  context: context, mounted: mounted, fcmToken: deviceToken);
            }
            if (mounted) {
              EasyLoading.dismiss();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.bottomTabsScreenRoute, (route) => false);
            }
          } else {
            EasyLoading.dismiss();
            Navigator.pushNamed(context, AppRoutes.otpVerificationScreenRoute,
                arguments: const OtpVerificationScreen(isLogin: true));
          }
        }
      }

      /// Failed
      else {
        EasyLoading.dismiss();
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
        // AppUtils.showToast(response.data["message"]);
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
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.instance.indicatorColor = AppColors.primaryColor;
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get Terms and Condtions
  Future getTermsAndConditionsCubit({
    required BuildContext context,
    required bool mounted,
    required bool isTermsAndConditions,
  }) async {
    emit(state.copyWith(termsAndConditions: ""));

    EasyLoading.show();

    late final Response? response;

    if (isTermsAndConditions) {
      // Terms and Conditions
      print("isTermsAndConditions: $isTermsAndConditions");
      response = await getTermsAndConditionsProvider(
          apiToken: state.userModel?.data?.apiToken);
    } else {
      // Privacy Policy
      print("isTermsAndConditions: $isTermsAndConditions");
      response =
          await getPrivacyProvider(apiToken: state.userModel?.data?.apiToken);
    }

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print("response: ${response.data}");
        emit(state.copyWith(termsAndConditions: response.data['data']));
        // AppUtils.showToast(resumeModel.message);
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        print("status: ${response.data["status"]} response: ${response.data}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get About Us
  Future getAboutUsCubit(
      {required BuildContext context, required bool mounted}) async {
    emit(state.copyWith(termsAndConditions: ""));

    EasyLoading.show();

    final response =
        await getAboutUsProvider(apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        print("response: ${response.data}");
        emit(state.copyWith(termsAndConditions: response.data['data']));
        // AppUtils.showToast(resumeModel.message);
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        print("status: ${response.data["status"]} response: ${response.data}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get How To Be a Hustler
  Future getHustlerCubit(
      {required BuildContext context, required bool mounted}) async {
    emit(state.copyWith(getResumeLoading: true, resumeModel: ResumeModel()));

    EasyLoading.show();

    final response =
        await getHustlerProvider(apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final ResumeModel resumeModel = ResumeModel.fromJson(response.data);
        print("status: ${resumeModel.status} response: ${resumeModel.data}");
        emit(state.copyWith(getResumeLoading: false, resumeModel: resumeModel));
        // AppUtils.showToast(resumeModel.message);
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        emit(state.copyWith(getResumeLoading: false));
        print("status: ${response.data["status"]} response: ${response.data}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      emit(state.copyWith(getResumeLoading: false));
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get Profile
  Future getProfileCubit(
      {required BuildContext context, required bool mounted}) async {
    // EasyLoading.show();

    final response =
        await getProfileProvider(apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final ProfileModel profileModel = ProfileModel.fromJson(response.data);
        print("status: ${profileModel.status} response: ${profileModel.data}");
        emit(state.copyWith(profileModel: profileModel));
      }

      /// Failed
      else {
        print("status: ${response.data["status"]} response: ${response.data}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Get DashBoard
  Future getDashboardCubit(
      {required BuildContext context, required bool mounted}) async {
    emit(state.copyWith(
        dashboardLoading: true, dashboardModel: DashboardModel()));
    EasyLoading.show();

    final response =
        await getDashboardProvider(apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final DashboardModel dashboardModel =
            DashboardModel.fromJson(response.data);
        print(
            "status: ${dashboardModel.status} response: ${dashboardModel.data}");
        emit(state.copyWith(
            dashboardLoading: false, dashboardModel: dashboardModel));
        EasyLoading.dismiss();
      }

      /// Failed
      else {
        print("status: ${response.data["status"]} response: ${response.data}");
        emit(state.copyWith(dashboardLoading: false));
        EasyLoading.dismiss();
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      emit(state.copyWith(dashboardLoading: false));
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Update FCM
  Future updateFCMCubit(
      {required BuildContext context,
      required bool mounted,
      String? fcmToken}) async {
    final response = await updateFCMProvider(
        apiToken: state.userModel?.data?.apiToken, fcmToken: fcmToken);

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        await prefs.saveUser(userModel);
        emit(state.copyWith(userModel: userModel));
      }

      /// Failed
      else {
        print("status: ${response.data["status"]} response: ${response.data}");
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Allow Push
  Future allowPushCubit(
      {required BuildContext context,
      required bool mounted,
      required int isAllow}) async {
    EasyLoading.show();

    final response = await allowPushProvider(
        apiToken: state.userModel?.data?.apiToken, isAllow: isAllow);

    if (response != null) {
      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final UserModel userModel = UserModel.fromJson(response.data);
        print("status: ${userModel.status} response: ${userModel.data}");
        await prefs.saveUser(userModel);
        emit(state.copyWith(userModel: userModel));
        EasyLoading.dismiss();
      }

      /// Failed
      else {
        print("status: ${response.data["status"]} response: ${response.data}");
        AppUtils.showToast(response.data["message"]);
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
      EasyLoading.dismiss();
    }
  }

  /// Update Resume
  Future updateResumeCubit({
    required BuildContext context,
    required bool mounted,
    required List itemsList,
    File? profileImage,
    String? pdfFile,
  }) async {
    EasyLoading.show();

    final response = await updateResumeProvider(
        apiToken: state.userModel?.data?.apiToken,
        profileImage: profileImage,
        pdfFile: pdfFile,
        actualName: actualNameController.text,
        nickName: nickNameController.text,
        familyTies: familyTiesController.text,
        professionalBackground: professionalBackgroundController.text,
        profession: professionController.text,
        favouriteQuote: favouriteQuoteController.text,
        description: descriptionController.text,
        hobbies: itemsList);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final ResumeModel resumeModel = ResumeModel.fromJson(response.data);
        print("status: ${resumeModel.status} response: ${resumeModel.data}");
        emit(state.copyWith(resumeModel: resumeModel));
        AppUtils.showToast(response.data["message"]);
        if (mounted) {
          Navigator.pop(context);
        }
      }

      /// Failed
      else {
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }

  /// Delete Pdf File
  Future<int> deleteResumeCubit() async {
    EasyLoading.show();

    final response =
        await deleteResume(apiToken: state.userModel?.data?.apiToken);

    if (response != null) {
      // EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        return 1;
      }

      /// Failed
      else {
        EasyLoading.dismiss();
        AppUtils.showToast(response.data["message"]);
        return 0;
      }
    } else {
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
      return 0;
    }
  }

  /// Get Resume
  Future getResumeCubit({
    required BuildContext context,
    required bool mounted,
  }) async {
    emit(state.copyWith(getResumeLoading: true, resumeModel: ResumeModel()));

    EasyLoading.show();

    final response = await getResumeProvider(
        apiToken: state.userModel?.data?.apiToken,
        id: state.userModel?.data?.id);

    if (response != null) {
      EasyLoading.dismiss();

      /// Success
      if (response.data["status"] == AppValidationMessages.success) {
        final ResumeModel resumeModel = ResumeModel.fromJson(response.data);
        print("status: ${resumeModel.status} response: ${resumeModel.data}");
        emit(state.copyWith(getResumeLoading: false, resumeModel: resumeModel));
        // AppUtils.showToast(resumeModel.message);
        // if (mounted) {
        //   Navigator.pop(context);
        // }
      }

      /// Failed
      else {
        emit(state.copyWith(getResumeLoading: false));
        AppUtils.showToast(response.data["message"]);
      }
    } else {
      emit(state.copyWith(getResumeLoading: false));
      EasyLoading.dismiss();
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }
}
