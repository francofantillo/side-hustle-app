part of 'auth_cubit.dart';

class AuthState {
  UserModel? userModel;
  ResumeModel? resumeModel;
  bool getResumeLoading;
  List<String>? hobbies;

  AuthState(
      {this.userModel,
      this.resumeModel,
      this.getResumeLoading = true,
      this.hobbies});

  AuthState copyWith(
      {UserModel? userModel,
      ResumeModel? resumeModel,
      bool? getResumeLoading,
      List<String>? hobbies}) {
    return AuthState(
        userModel: userModel ?? this.userModel,
        resumeModel: resumeModel ?? this.resumeModel,
        getResumeLoading: getResumeLoading ?? this.getResumeLoading,
        hobbies: hobbies ?? this.hobbies);
  }
}
