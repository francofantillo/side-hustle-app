part of 'auth_cubit.dart';

class AuthState {
  UserModel? userModel;
  ResumeModel? resumeModel;
  bool getResumeLoading;
  List<String>? hobbies;
  String? termsAndConditions;
  String? hustlerBookUrl;
  ProfileModel? profileModel;
  DashboardModel? dashboardModel;
  bool dashboardLoading;

  AuthState(
      {this.userModel,
      this.resumeModel,
      this.getResumeLoading = true,
      this.termsAndConditions,
      this.hustlerBookUrl,
      this.hobbies,
      this.profileModel,
      this.dashboardModel,
      this.dashboardLoading = true});

  AuthState copyWith(
      {UserModel? userModel,
      ResumeModel? resumeModel,
      bool? getResumeLoading,
      String? termsAndConditions,
      String? hustlerBookUrl,
      List<String>? hobbies,
      ProfileModel? profileModel,
      DashboardModel? dashboardModel,
      bool? dashboardLoading}) {
    return AuthState(
        userModel: userModel ?? this.userModel,
        resumeModel: resumeModel ?? this.resumeModel,
        getResumeLoading: getResumeLoading ?? this.getResumeLoading,
        hobbies: hobbies ?? this.hobbies,
        termsAndConditions: termsAndConditions ?? this.termsAndConditions,
        hustlerBookUrl: hustlerBookUrl ?? this.hustlerBookUrl,
        profileModel: profileModel ?? this.profileModel,
        dashboardModel: dashboardModel ?? this.dashboardModel,
        dashboardLoading: dashboardLoading ?? this.dashboardLoading);
  }
}
