part of 'wanted_job_cubit.dart';

class JobsState {
  JobsModel? jobsModel;
  bool jobsLoading;
  JobsModel? jobsDetailModel;
  bool jobsDetailLoading;
  List<JobsData>? wantedJobsTempList;
  bool searching;
  List<File>? itemImagesFile;
  List<Images>? images;
  bool editJobLoading;
  String? totalHours;
  MyJobsModel? myJobsModel;
  bool myJobsLoading;
  JobRequestModel? jobRequestModel;
  bool jobRequestLoading;

  JobsState(
      {this.jobsModel,
      this.jobsLoading = true,
      this.jobsDetailModel,
      this.jobsDetailLoading = true,
      this.wantedJobsTempList,
      this.searching = false,
      this.itemImagesFile,
      this.editJobLoading = false,
      this.totalHours,
      this.myJobsModel,
      this.myJobsLoading = false,
      this.jobRequestModel,
      this.jobRequestLoading = true,
      this.images});

  JobsState copyWith(
      {JobsModel? jobsModel,
      bool? jobsLoading,
      List<JobsData>? wantedJobsTempList,
      bool? searching,
      List<File>? itemImagesFile,
      JobsModel? jobsDetailModel,
      bool? jobsDetailLoading,
      bool? editJobLoading,
      String? totalHours,
      MyJobsModel? myJobsModel,
      bool? myJobsLoading,
      JobRequestModel? jobRequestModel,
      bool? jobRequestLoading,
      List<Images>? images}) {
    return JobsState(
        jobsModel: jobsModel ?? this.jobsModel,
        jobsLoading: jobsLoading ?? this.jobsLoading,
        jobsDetailModel: jobsDetailModel ?? this.jobsDetailModel,
        jobsDetailLoading: jobsDetailLoading ?? this.jobsDetailLoading,
        wantedJobsTempList: wantedJobsTempList ?? this.wantedJobsTempList,
        searching: searching ?? this.searching,
        itemImagesFile: itemImagesFile ?? this.itemImagesFile,
        editJobLoading: editJobLoading ?? this.editJobLoading,
        totalHours: totalHours ?? this.totalHours,
        myJobsModel: myJobsModel ?? this.myJobsModel,
        myJobsLoading: myJobsLoading ?? this.myJobsLoading,
        jobRequestModel: jobRequestModel ?? this.jobRequestModel,
        jobRequestLoading: jobRequestLoading ?? this.jobRequestLoading,
        images: images ?? this.images);
  }
}
