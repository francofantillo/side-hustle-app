import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/home/widgets/home_items_widget.dart';
import 'package:side_hustle/job/apply_job.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class JobsAroundYouList extends StatelessWidget {
  final String? title;
  final List<ItemList>? itemsList;
  final double horizontalListSize;
  final Function()? onTapLabel;

  const JobsAroundYouList(
      {super.key,
      this.title,
      this.itemsList,
      this.onTapLabel,
      required this.horizontalListSize});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return state.dashboardLoading
          ? const SizedBox.shrink()
          : state.dashboardModel?.data?.jobs?.isEmpty ?? true
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4, right: 8, bottom: 8),
                      child: InkWell(
                        onTap: onTapLabel,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(
                                text: title,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: AppDimensions.itemsArrowForwardIconSize,
                            )
                          ],
                        ),
                      ),
                    ),
                    // Horizontal ListView
                    SizedBox(
                      height: horizontalListSize, // Set the desired height
                      width: 1.sw,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            state.dashboardModel?.data?.jobs?.length ?? 0,
                        // Replace with your item count
                        itemBuilder: (context, index) {
                          // Replace with your horizontal list item
                          return Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: HomeItemsWidget(
                              perHead: "",
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.applyForJobScreenRoute,
                                    arguments: ApplyForJob(
                                      jobId: state.dashboardModel?.data
                                          ?.jobs?[index].jobId,
                                    ));
                              },
                              commentIconPath: AssetsPath.comment,
                              // jobType: state.dashboardModel?.data?.jobs?[index].,
                              imageWidth: 1.sw,
                              imageHeight: horizontalListSize,
                              boarderColor: AppColors.itemBGColor,
                              title:
                                  state.dashboardModel?.data?.jobs?[index].name,
                              desc: state.dashboardModel?.data?.jobs?[index]
                                  .description,
                              imagePath: state
                                  .dashboardModel?.data?.jobs?[index].image,
                              price: state
                                  .dashboardModel?.data?.jobs?[index].price
                                  ?.toStringAsFixed(2),
                              userName: state.dashboardModel?.data?.jobs?[index]
                                  .userDetail?.name,
                              userRating: state.dashboardModel?.data
                                          ?.jobs?[index].userDetail?.rating !=
                                      null
                                  ? state.dashboardModel!.data!.jobs![index]
                                              .userDetail!.rating ==
                                          0.0
                                      ? "0"
                                      : (state.dashboardModel?.data
                                          ?.jobs?[index].userDetail?.rating
                                          ?.toStringAsFixed(1))
                                  : "0",
                              userProfile: state.dashboardModel?.data
                                  ?.jobs?[index].userDetail?.image,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
    });
  }
}
