import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/state_management/models/jobs_model.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/wanted_job/widgets/booked_job.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class BookedTabList extends StatefulWidget {
  const BookedTabList({super.key});

  @override
  State<BookedTabList> createState() => _BookedTabListState();
}

class _BookedTabListState extends State<BookedTabList> {
  late final JobsCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    super.initState();
  }

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
              : bookedJobs(
                  jobsItemList: state.searching
                      ? state.wantedJobsTempList
                      : state.jobsModel?.jobs);
    });
  }

  Widget bookedJobs({List<JobsData>? jobsItemList}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.14.sh, top: 8),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
          itemCount: jobsItemList?.length ?? 0,
          // Replace with your item count
          itemBuilder: (context, index) {
            // Replace with your horizontal list item
            return Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 8.0),
              child: BookedJobsWidget(
                  onTapStartJob: () async {
                    await _bloc.updateJobStatusCubit(
                        context: context,
                        mounted: mounted,
                        jobId: jobsItemList?[index].jobId,
                        status: JobStatusEnum.Start.name);
                  },
                  imageWidth: 1.sw,
                  imageHeight: AppDimensions.listItemHeight,
                  boarderColor: AppColors.itemBGColor,
                  title: jobsItemList?[index].title,
                  desc: jobsItemList?[index].description,
                  imagePath: jobsItemList?[index].image,
                  price: jobsItemList?[index].budget?.toStringAsFixed(2)),
            );
          },
        ),
      ),
    );
  }
}
