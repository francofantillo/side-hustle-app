import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/widgets/completed_job_item.dart';
import 'package:side_hustle/job/my_jobs/widgets/rate_and_review.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class MyJobsCompletedList extends StatefulWidget {
  const MyJobsCompletedList({super.key});

  @override
  State<MyJobsCompletedList> createState() => _MyJobsCompletedListState();
}

class _MyJobsCompletedListState extends State<MyJobsCompletedList> {
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
                        child: CompletedJobItemWidget(
                          onTapRate: () {
                            AppDialogues.noHeaderDialogue(
                                    context: context,
                                    body: RateAndReviewDialogue(index: index))
                                .show();
                          },
                          isReviewed:
                              state.myJobsModel?.myJobs?[index].isReviewed ?? 0,
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.listItemCompletedJobHeight,
                          boarderColor: AppColors.itemBGColor,
                          title: state.myJobsModel?.myJobs?[index].title,
                          desc: state.myJobsModel?.myJobs?[index].description,
                          imagePath: state.myJobsModel?.myJobs?[index].image,
                          price: state.myJobsModel?.myJobs?[index].budget
                              ?.toStringAsFixed(2),
                          userName: state
                              .myJobsModel?.myJobs?[index].userDetail?.name,
                          userProfile: state
                              .myJobsModel?.myJobs?[index].userDetail?.image,
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
