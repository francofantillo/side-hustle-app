import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/favourites/widgets/fav_item_events.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class FavouritesListJobs extends StatefulWidget {
  const FavouritesListJobs({super.key});

  @override
  State<FavouritesListJobs> createState() => _FavouritesListJobsState();
}

class _FavouritesListJobsState extends State<FavouritesListJobs> {
  late final FavouritesCubit _bloc;
  late final JobsCubit _blocJobs;

  @override
  void initState() {
    _bloc = BlocProvider.of<FavouritesCubit>(context);
    _blocJobs = BlocProvider.of<JobsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
      return state.favouritesModelLoading
          ? const SizedBox.shrink()
          : state.favouritesModel?.favourites?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageJobs),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.favouritesModel?.favourites?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, top: 8),
                        child: FavItemEventsWidget(
                          perHead: "",
                          onTapFav: () async {
                            final eventsData = _blocJobs.state.jobsModel?.jobs
                                ?.where((element) => (element.jobId ==
                                    state.favouritesModel?.favourites?[index]
                                        .id));

                            int? jobsIndex;
                            if (eventsData != null && eventsData.isNotEmpty) {
                              jobsIndex = _blocJobs.state.jobsModel?.jobs
                                  ?.indexOf(eventsData.first);
                              print(
                                  "jobsIndex: $jobsIndex) jobsData: ${eventsData.first.jobId}");
                            }
                            await _bloc
                                .removeFromFavCubit(
                                    context: context,
                                    mounted: mounted,
                                    type: Favourites.Job.name,
                                    id: state
                                        .favouritesModel?.favourites?[index].id)
                                .then((value) {
                              if (value == 1) {
                                if (jobsIndex != null) {
                                  _blocJobs.setFave(
                                      index: jobsIndex, isFavourite: 0);
                                }
                              }
                            });
                          },
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.listItemFavEventsHeight,
                          boarderColor: AppColors.itemBGColor,
                          // title: AlphaAppData.favEventsList[index].title,
                          title: state.favouritesModel?.favourites?[index].name,
                          // location: AppStrings.locationText,
                          location: state
                              .favouritesModel?.favourites?[index].location,
                          imagePath:
                              // AlphaAppData.favEventsList[index].imagePath,
                              state.favouritesModel?.favourites?[index].image,
                          // price: AlphaAppData.favEventsList[index].price,
                          price:
                              "\$${state.favouritesModel?.favourites?[index].price?.toStringAsFixed(2)}",
                          // userName: AlphaAppData.favEventsList[index].userName,
                          userName: state.favouritesModel?.favourites?[index]
                              .ownerDetail?.name,
                          userRating:
                              // AlphaAppData.favEventsList[index].userRating,
                              state.favouritesModel?.favourites?[index]
                                  .ownerDetail?.rating,
                          userProfile:
                              // AlphaAppData.favEventsList[index].userProfile,
                              state.favouritesModel?.favourites?[index]
                                  .ownerDetail?.image,
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
