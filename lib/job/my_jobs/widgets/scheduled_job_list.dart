import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/job_request.dart';
import 'package:side_hustle/job/my_jobs/view_job.dart';
import 'package:side_hustle/job/my_jobs/widgets/scheduled_job_item.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

import '../../../router/app_route_named.dart';

class MyJobsScheduledList extends StatefulWidget {
  const MyJobsScheduledList({super.key});

  @override
  State<MyJobsScheduledList> createState() => _MyJobsScheduledListState();
}

class _MyJobsScheduledListState extends State<MyJobsScheduledList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
      return state.myJobsLoading
          ? const SizedBox.shrink()
          : state.myJobsModel?.myJobs?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageNoItemsFound),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
                    itemCount: state.myJobsModel?.myJobs?.length ?? 0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, top: 8),
                        child: ScheduledJobItemWidget(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.viewJobScreenRoute,
                                arguments: ViewJob(
                                  jobId:
                                      state.myJobsModel?.myJobs?[index].jobId,
                                ));
                          },
                          onTapViewRequest: () {
                            print("onTapViewRequest");
                            Navigator.pushNamed(
                                context, AppRoutes.jobRequestScreenRoute,
                                arguments: JobRequest(
                                  jobId:
                                      state.myJobsModel?.myJobs?[index].jobId,
                                ));
                          },
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.listItemJobScheduledHeight,
                          boarderColor: AppColors.itemBGColor,
                          title: state.myJobsModel?.myJobs?[index].title,
                          desc: state.myJobsModel?.myJobs?[index].description,
                          imagePath: state.myJobsModel?.myJobs?[index].image,
                          price: state.myJobsModel?.myJobs?[index].budget
                              ?.toStringAsFixed(2),
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
