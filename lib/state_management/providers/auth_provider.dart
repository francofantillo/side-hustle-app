import 'package:dio/dio.dart';
import 'package:side_hustle/state_management/providers/base_api_provider.dart';
import 'package:side_hustle/utils/api_path.dart';

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

  print("$data\nurl: ${API.SIGNUP}");
  final response = await postRequestProvider(path: API.SIGNUP, data: data);
  return response;
}

/// OTP Verification
Future<Response?> otpVerificationProvider(
    {String? otp, String? apiToken}) async {
  final data = {"otp_token": otp, "api_token": apiToken};

  print("$data\nurl: ${API.VERIFIFY_OTP}");
  final response =
      await postRequestProvider(path: API.VERIFIFY_OTP, data: data);
  return response;
}

/// Login
Future<Response?> loginProvider({
  String? email,
  String? password,
}) async {
  final data = {"email": "test08@mail.com", "password": "123456"};

  print("$data\nurl: ${API.LOGIN}");
  final response = await postRequestProvider(path: API.LOGIN, data: data);
  return response;
}
