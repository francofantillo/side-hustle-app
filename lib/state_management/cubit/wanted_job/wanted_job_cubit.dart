import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'wanted_job_state.dart';

class WantedJobCubit extends Cubit<WantedJobState> {
  WantedJobCubit() : super(WantedJobState());

  /// Get Wanted Jobs
  Future getWantedJobs(
      {required BuildContext context, required bool mounted}) async {
    EasyLoading.show();


  }
}
