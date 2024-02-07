import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/home/widgets/items_widget.dart';
import 'package:side_hustle/job/apply_job.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/state_management/models/jobs_model.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class WantedTabList extends StatefulWidget {
  const WantedTabList({super.key});

  @override
  State<WantedTabList> createState() => _WantedTabListState();
}

class _WantedTabListState extends State<WantedTabList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
      return state.jobsLoading
          ? const SizedBox.shrink()
          : state.jobsModel?.jobs?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageJobs),
                )
              : wantedJobs(
                  jobsItemList: state.searching
                      ? state.wantedJobsTempList
                      : state.jobsModel?.jobs);
    });
  }

  Widget wantedJobs({List<JobsData>? jobsItemList}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.14.sh),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: jobsItemList?.length ?? 0,
          // Replace with your item count
          itemBuilder: (context, index) {
            // Replace with your horizontal list item
            return Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 8.0, top: 8),
              child: WantedJobsItemWidget(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.applyForJobScreenRoute,
                      arguments: ApplyForJob(
                        jobId: jobsItemList?[index].jobId,
                      ));
                },
                imageWidth: 1.sw,
                imageHeight: AppDimensions.listItemHeight,
                boarderColor: AppColors.itemBGColor,
                title: jobsItemList?[index].title,
                desc: jobsItemList?[index].description,
                imagePath: jobsItemList?[index].image,
                price: jobsItemList?[index].budget?.toStringAsFixed(2),
                userName: jobsItemList?[index].user?.name,
                // userRating: (jobsItemList?[index].user?.rating != null)
                //     ? (jobsItemList![index].user!.rating! == 0.0)
                //         ? "0"
                //         : "${jobsItemList[index].user?.rating?.toStringAsFixed(1)}"
                //     : "",
                // userRating:
                //     jobsItemList?[index].user?.rating?.toStringAsFixed(1),
                userRating:
                    jobsItemList?[index].user?.rating?.toStringAsFixed(1) ==
                            "0.0"
                        ? "0"
                        : jobsItemList?[index].user?.rating?.toStringAsFixed(1),
                userProfile: jobsItemList?[index].user?.image,
              ),
            );
          },
        ),
      ),
    );
  }
}
