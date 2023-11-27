import 'package:flutter/material.dart';
import 'package:side_hustle/job/my_jobs/widgets/job_request_list.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';

import '../../utils/app_strings.dart';

class JobRequest extends StatefulWidget {
  const JobRequest({super.key});

  @override
  State<JobRequest> createState() => _JobRequestState();
}

class _JobRequestState extends State<JobRequest> {
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
