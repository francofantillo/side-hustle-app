part of 'wanted_job_cubit.dart';

class JobsState {
  JobsModel? jobsModel;
  bool jobsLoading;
  JobsModel? jobsDetailModel;
  bool jobsDetailLoading;
  List<JobsData>? wantedJobsTempList;
  bool searching;
  List<File>? itemImagesFile;
  bool editJobLoading;

  JobsState(
      {this.jobsModel,
      this.jobsLoading = true,
      this.jobsDetailModel,
      this.jobsDetailLoading = true,
      this.wantedJobsTempList,
      this.searching = false,
      this.itemImagesFile,
      this.editJobLoading = false});

  JobsState copyWith(
      {JobsModel? jobsModel,
      bool? jobsLoading,
      List<JobsData>? wantedJobsTempList,
      bool? searching,
      List<File>? itemImagesFile,
      JobsModel? jobsDetailModel,
      bool? jobsDetailLoading,
      bool? editJobLoading}) {
    return JobsState(
        jobsModel: jobsModel ?? this.jobsModel,
        jobsLoading: jobsLoading ?? this.jobsLoading,
        jobsDetailModel: jobsDetailModel ?? this.jobsDetailModel,
        jobsDetailLoading: jobsDetailLoading ?? this.jobsDetailLoading,
        wantedJobsTempList: wantedJobsTempList ?? this.wantedJobsTempList,
        searching: searching ?? this.searching,
        itemImagesFile: itemImagesFile ?? this.itemImagesFile,
        editJobLoading: editJobLoading ?? this.editJobLoading);
  }
}
