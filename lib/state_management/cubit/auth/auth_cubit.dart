import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/state_management/models/user_model.dart';
import 'package:side_hustle/state_management/providers/auth_provider.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  /// Signup
  Future<UserModel?> signUpCubit({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? zipCode,
    String? country,
    String? password,
    String? cPassword,
  }) async {
    EasyLoading.show(status: AppStrings.PLEASE_WAIT);

    final response = await signupProvider(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        zipCode: zipCode,
        country: country,
        password: password,
        cPassword: cPassword);

    if (response != null) {
      final UserModel userModel = UserModel.fromJson(response.data);

      // if (response.statusCode == 200) {
      if (userModel.status == AppValidationMessages.success) {
        print("response: ${userModel.data}");
        AppUtils.showToast(userModel.message);
      } else if (userModel.status != AppValidationMessages.success) {
        print("response: ${userModel.data}");
        AppUtils.showToast(userModel.message);
      } else {
        AppUtils.showToast(userModel.message);
      }
      // }
    } else {
      AppUtils.showToast(AppValidationMessages.failedMessage);
    }
  }
}
