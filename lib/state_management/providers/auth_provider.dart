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
    "firstName": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "zip_code": zipCode,
    "country": country,
    "password": password,
    "confirm_password": cPassword,
  };
  final response = await postRequestProvider(path: API.SIGNUP, data: data);
  return response;
}
