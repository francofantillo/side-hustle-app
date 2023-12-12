part of 'auth_cubit.dart';

class AuthState {
  UserModel? userModel;

  AuthState({this.userModel});

  AuthState copyWith({UserModel? userModel, String? apiToken}) {
    return AuthState(userModel: userModel ?? this.userModel);
  }
}
