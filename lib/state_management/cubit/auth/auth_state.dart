part of 'auth_cubit.dart';

class AuthState {
  UserModel? userModel;

  AuthState({this.userModel});

  AuthState copyWith({UserModel? userModel}) {
    return AuthState(userModel: userModel ?? this.userModel);
  }
}
