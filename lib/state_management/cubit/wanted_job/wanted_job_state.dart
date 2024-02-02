part of 'wanted_job_cubit.dart';

class JobsState {
  JobsModel? jobsModel;
  bool jobsLoading;
  JobsModel? jobsDetailModel;
  bool jobsDetailLoading;
  List<JobsData>? wantedJobsTempList;
  bool searching;
  List<File>? itemImagesFile;

  JobsState(
      {this.jobsModel,
        this.jobsLoading = true,
        this.jobsDetailModel,
        this.jobsDetailLoading = true,
        this.wantedJobsTempList,
        this.searching = false,
        this.itemImagesFile});

  JobsState copyWith(
      {JobsModel? jobsModel,
        bool? jobsLoading,
        List<JobsData>? wantedJobsTempList,
        bool? searching,
        List<File>? itemImagesFile,
        JobsModel? jobsDetailModel,
        bool? jobsDetailLoading}) {
    return JobsState(
        jobsModel: jobsModel ?? this.jobsModel,
        jobsLoading: jobsLoading ?? this.jobsLoading,
        jobsDetailModel: jobsDetailModel ?? this.jobsDetailModel,
        jobsDetailLoading: jobsDetailLoading ?? this.jobsDetailLoading,
        wantedJobsTempList: wantedJobsTempList ?? this.wantedJobsTempList,
        searching: searching ?? this.searching,
        itemImagesFile: itemImagesFile ?? this.itemImagesFile);
  }
}
