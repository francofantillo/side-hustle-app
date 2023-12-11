part of 'auth_cubit.dart';

class AuthState {
  UserModel? userModel;
  String? apiToken;

  AuthState({this.userModel, this.apiToken});

  AuthState copyWith({UserModel? userModel, String? apiToken}) {
    return AuthState(
        userModel: userModel ?? this.userModel,
        apiToken: apiToken ?? this.apiToken);
  }
}
