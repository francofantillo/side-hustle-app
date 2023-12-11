import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/utils/app_strings.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;
  static SharedPreferences? _prefs;

  SharedPreferencesHelper._internal();

  static SharedPreferencesHelper get instance {
    _instance ??= SharedPreferencesHelper._internal();
    return _instance!;
  }

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<bool> saveString(String key, String value) async {
    final prefs = await instance.prefs;
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await instance.prefs;
    return prefs.getString(key);
  }

  Future<void> saveUser(UserModel user) async {
    final prefs = await instance.prefs;
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(AppStrings.USERDATA_KEY, userJson);
  }

  Future<UserModel?> getUser() async {
    final prefs = await instance.prefs;
    String? userJson = prefs.getString(AppStrings.USERDATA_KEY);
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> clearPreferences() async {
    final prefs = await instance.prefs;
    await prefs.clear();
  }
}
