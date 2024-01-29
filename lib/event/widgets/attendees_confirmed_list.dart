import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/model/attendees_model.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class AttendeesConfirmedList extends StatefulWidget {
  final List<Attendees>? itemsList;

  const AttendeesConfirmedList({super.key, required this.itemsList});

  @override
  State<AttendeesConfirmedList> createState() => _AttendeesConfirmedListState();
}

class _AttendeesConfirmedListState extends State<AttendeesConfirmedList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
      return state.attendeesModelLoading
          ? const SizedBox.shrink()
          : state.attendeesModel?.data?.isEmpty ?? true
              ? const CustomErrorWidget(
                  errorMessage: AppStrings.errorMessageNoItemsFound)
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
                  itemCount: state.attendeesModel?.data?.length ?? 0,
                  // Replace with your item count
                  itemBuilder: (context, index) {
                    // Replace with your horizontal list item
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          Row(children: [
                            CircularCacheImageWidget(
                              showLoading: true,
                              assetImage: AssetsPath.placeHolder,
                              image: state.attendeesModel?.data?[index].image,
                              imageWidth: .15.sw,
                            ),
                            //bullet text
                            width(
                              0.02.sw,
                            ),
                            Expanded(
                              child: textWidget(
                                  text: state
                                      .attendeesModel?.data?[index].username,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions.textSizeSmall),
                            ),
                            InkWell(
                              // splashColor: AppColors.greyColor,
                              onTap: () {
                                // Navigator.pushReplacementNamed(context, AppRoutes.otherUserProfileScreenRoute);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: textWidget(
                                    text: AppStrings.viewProfile,
                                    color: AppColors.whiteColor,
                                    fontSize: AppDimensions.textSizeVerySmall,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                          height(5.w),
                          Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.8),
                          )
                        ],
                      ),
                    );
                  },
                );
    });
  }
}
