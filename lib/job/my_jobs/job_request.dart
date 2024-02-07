import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/job/my_jobs/widgets/job_request_list.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';

import '../../utils/app_strings.dart';

class JobRequest extends StatefulWidget {
  final int? jobId;

  const JobRequest({super.key, this.jobId});

  @override
  State<JobRequest> createState() => _JobRequestState();
}

class _JobRequestState extends State<JobRequest> {
  late final JobsCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getJobRequest();
    super.initState();
  }

  getJobRequest() async {
    await _bloc.getJobRequestsCubit(
        context: context, mounted: mounted, jobId: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.jobRequest,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: const Column(
        children: [
          JobRequestList(),
        ],
      ),
    );
  }
}
