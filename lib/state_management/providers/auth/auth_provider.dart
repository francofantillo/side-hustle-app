import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';
import 'package:path/path.dart' as getImagePath;

var dio = Dio();

/// Signup
Future<Response?> signupProvider({
  String? firstName,
  String? lastName,
  String? email,
  String? phone,
  String? zipCode,
  String? country,
  String? password,
  String? cPassword,
}) async {
  final data = {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "zip_code": zipCode,
    "country": country,
    "password": password,
    "confirm_password": cPassword,
  };
  // final data = {
  //   "first_name": "test03",
  //   "last_name": "user",
  //   "email": "test03@mail.com",
  //   "phone": "+1345678972",
  //   "zip_code": "12345",
  //   "country": "USA",
  //   "password": "123456",
  //   "confirm_password": "123456"
  // };

  print(
      "*****************\nurl: ${API.SIGNUP}\ndata: $data\n**************************");

  final response = await postRequestProvider(path: API.SIGNUP, data: data);
  return response;
}

/// OTP Verification
Future<Response?> otpVerificationProvider(
    {String? otp, String? apiToken}) async {
  final data = {"otp_token": otp, "api_token": apiToken};

  print(
      "*****************\nurl: ${API.VERIFIFY_OTP}\ndata: $data\n**************************");

  final response =
      await postRequestProvider(path: API.VERIFIFY_OTP, data: data);
  return response;
}

/// Resend OTP
Future<Response?> resendOTPProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.RESEND_OTP}\n**************************");
  final data = {"api_token": apiToken};

  final response = await postRequestProvider(
      path: API.RESEND_OTP, data: data, token: apiToken);
  return response;
}

/// Login
Future<Response?> loginProvider({
  String? email,
  String? password,
}) async {
  // final data = {"email": "test08@mail.com", "password": "123456"};
  final data = {"email": email, "password": password};

  print(
      "*****************\nurl: ${API.LOGIN}\ndata: $data\n**************************");

  final response = await postRequestProvider(path: API.LOGIN, data: data);
  return response;
}

/// Forgot Password
Future<Response?> forgotPasswordProvider({
  String? phone,
}) async {
  // final data = {"phone": "+15555555510"};
  final data = {"phone": phone};

  print(
      "*****************\nurl: ${API.FORGOT_PASSWORD}\ndata: $data\n**************************");

  final response =
      await postRequestProvider(path: API.FORGOT_PASSWORD, data: data);
  return response;
}

/// Reset Password
Future<Response?> resetPasswordProvider(
    {String? password, String? apiToken}) async {
  // final data = {
  //   "password": "123456",
  //   "confirm_password": "123456",
  //   "api_token": "22|woYOINsCGFq3rWuMWfuF8pp80gWwvvFyklMxL27C1eafcb49"
  // };

  final data = {
    "password": password,
    "confirm_password": password,
    "api_token": apiToken
  };

  print(
      "*****************\nurl: ${API.RESET_PASSWORD}\ndata: $data\n**************************");
  final response =
      await putRequestProvider(path: API.RESET_PASSWORD, data: data);
  return response;
}

/// Change Password
Future<Response?> changePasswordProvider(
    {String? existingPassword, String? password, String? apiToken}) async {
  // final data = {
  //   "old_password": "admin@1234",
  //   "new_password": "admin@123",
  //   "confirm_password": "admin@123"
  // };

  final data = {
    "old_password": existingPassword,
    "new_password": password,
    "confirm_password": password
  };

  print(
      "*****************\nurl: ${API.CHANGE_PASSWORD}\ndata: $data\n**************************");
  final response = await postRequestProvider(
      path: API.CHANGE_PASSWORD, data: data, token: apiToken);
  return response;
}

/// Your Resume Edit
Future<Response?> updateResumeProvider({
  String? apiToken,
  File? profileImage,
  String? pdfFile,
  String? actualName,
  String? nickName,
  String? familyTies,
  String? professionalBackground,
  String? profession,
  String? favouriteQuote,
  String? description,
  List? hobbies,
}) async {
  late String hobbiesString;

  for (int i = 0; i < (hobbies?.length ?? 0); i++) {
    print("Hobbies Length: ${hobbies?.length}");
    if (i == 0) {
      if ((hobbies!.length - 1) == i) {
        hobbiesString = "${hobbies[i]}";
      } else {
        hobbiesString = "${hobbies[i]}, ";
      }
    } else {
      if ((hobbies!.length - 1) == i) {
        hobbiesString += "${hobbies[i]}";
      } else {
        hobbiesString += "${hobbies[i]}, ";
      }
    }
  }

  final Map<String, dynamic> data = {
    "actual_name": actualName,
    "nick_name": nickName,
    "family_ties": familyTies,
    "professional_background": professionalBackground,
    "profession": profession,
    "favourite_quote": favouriteQuote,
    "description": description,
  };

  if (hobbies != null) {
    data.putIfAbsent("hobbies", () => hobbiesString);
  }

  if (profileImage != null) {
    final profileImageName = getImagePath.basename(profileImage.path);
    final profileImageMultipart = await MultipartFile.fromFile(
        profileImage.path,
        filename: profileImageName);
    data.putIfAbsent("profile_image", () => profileImageMultipart);
  }

  if (pdfFile != null) {
    final pdfFileName = getImagePath.basename(pdfFile);
    final pdfFileMultipart =
        await MultipartFile.fromFile(pdfFile, filename: pdfFileName);
    data.putIfAbsent("file", () => pdfFileMultipart);
  }

  final formData = FormData.fromMap(data);
  print(
      "*****************\nurl: ${API.UPDATE_RESUME}\ndata: $data\n**************************");

  final response = await postRequestProvider(
      path: API.UPDATE_RESUME, data: formData, token: apiToken);
  return response;
}

/// Get Resume
Future<Response?> getResumeProvider({int? id, String? apiToken}) async {
  final data = {"id": id};

  print(
      "*****************\nurl: ${API.GET_RESUME}$id\nuserId: $id\napiToken: $apiToken\n**************************");
  final response = await getRequestProvider(
      path: API.GET_RESUME, queryParameter: data, token: apiToken);
  return response;
}

/// Get Terms and Conditions
Future<Response?> getTermsAndConditionsProvider({String? apiToken}) async {
  print(
      "*****************\nurl: ${API.TERMS_AND_CONDITIONS}\napiToken: $apiToken\n**************************");
  final response =
      await getRequestProvider(path: API.TERMS_AND_CONDITIONS, token: apiToken);
  return response;
}

/// Logout
Future<Response?> logoutProvider({String? apiToken}) async {
  print("*****************\nurl: ${API.LOGOUT}\n**************************");
  final response =
      await postRequestProvider(path: API.LOGOUT, data: null, token: apiToken);
  return response;
}
