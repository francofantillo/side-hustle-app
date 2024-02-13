import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/my_jobs/my_jobs.dart';
import 'package:side_hustle/job/my_jobs/widgets/job_request_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class JobRequestList extends StatefulWidget {
  final bool isViewRequestFromJobDetail;

  const JobRequestList({super.key, this.isViewRequestFromJobDetail = false});

  @override
  State<JobRequestList> createState() => _JobRequestListState();
}

class _JobRequestListState extends State<JobRequestList> {
  late final JobsCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    print("isViewRequestFromJobDetail: ${widget.isViewRequestFromJobDetail}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
      return state.jobRequestLoading
          ? const SizedBox.shrink()
          : state.jobRequestModel?.data?.isEmpty ?? true
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
                    itemCount: state.jobRequestModel?.data?.length ?? 0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, top: 4),
                        child: JobRequestItemWidget(
                          onTapHire: () async {
                            await _bloc.updateJobRequestsCubit(
                                context: context,
                                mounted: mounted,
                                index: index,
                                status: JobsRequestEnum.Approved.name);
                            //     .then((value) {
                            //   if (value == 1) {
                            //     if (widget.isViewRequestFromJobDetail) {
                            //       Navigator.pop(context);
                            //       Navigator.pop(context);
                            //       // Navigator.pushReplacementNamed(
                            //       //     context, AppRoutes.myJobsScreenRoute,
                            //       //     arguments: const MyJobsScreen(
                            //       //       selectedIndex: 1,
                            //       //     ));
                            //     } else {
                            //       Navigator.pop(context);
                            //       // Navigator.pushReplacementNamed(
                            //       //     context, AppRoutes.myJobsScreenRoute,
                            //       //     arguments: const MyJobsScreen(
                            //       //       selectedIndex: 1,
                            //       //     ));
                            //     }
                            //   }
                            // });
                          },
                          onTapReject: () async {
                            await _bloc.updateJobRequestsCubit(
                                context: context,
                                mounted: mounted,
                                index: index,
                                status: JobsRequestEnum.Rejected.name);
                          },
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.listItemJobRequestHeight,
                          boarderColor: AppColors.itemBGColor,
                          // price: AlphaAppData
                          //     .jobsAndEventsList[0].itemList?[0].price,
                          price: state.jobRequestModel?.data?[index].bidAmount
                              ?.toStringAsFixed(2),
                          userName:
                              state.jobRequestModel?.data?[index].username,
                          // userRating: state.jobRequestModel?.data?[index].rating?.toStringAsFixed(1),
                          userRating: state.jobRequestModel?.data?[index].rating
                                      ?.toStringAsFixed(1) ==
                                  "0.0"
                              ? "0"
                              : state.jobRequestModel?.data?[index].rating
                                  ?.toStringAsFixed(1),
                          userProfile:
                              state.jobRequestModel?.data?[index].image,
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
