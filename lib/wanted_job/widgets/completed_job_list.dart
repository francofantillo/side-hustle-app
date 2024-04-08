import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/state_management/models/jobs_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/wanted_job/widgets/completed_job.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class CompletedTabList extends StatefulWidget {
  const CompletedTabList({super.key});

  @override
  State<CompletedTabList> createState() => _CompletedTabListState();
}

class _CompletedTabListState extends State<CompletedTabList> {
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
              : completedJobs(
                  jobsItemList: state.searching
                      ? state.wantedJobsTempList
                      : state.jobsModel?.jobs);
    });
  }

  Widget completedJobs({List<JobsData>? jobsItemList}) {
    return jobsItemList?.isEmpty ?? true
        ? const Expanded(
            child: CustomErrorWidget(errorMessage: AppStrings.errorMessageJobs),
          )
        : Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.14.sh, top: 8),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: jobsItemList?.length ?? 0,
                itemBuilder: (context, index) {
                  // Replace with your horizontal list item
                  print("rating: ${jobsItemList?[index].user?.rating}");
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    child: CompletedJobsWidget(
                      imageWidth: 1.sw,
                      imageHeight: AppDimensions.listItemHeightJobCompleted,
                      boarderColor: AppColors.itemBGColor,
                      title: jobsItemList?[index].title,
                      subTitle: jobsItemList?[index].description,
                      imagePath: jobsItemList?[index].image,
                      price: jobsItemList?[index].budget?.toStringAsFixed(2),
                      userName: jobsItemList?[index].reviewName,
                      userRating: jobsItemList?[index].rating == 0.0
                          ? "0"
                          : jobsItemList?[index].rating?.toString(),
                      userProfile: jobsItemList?[index].reviewImage,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
