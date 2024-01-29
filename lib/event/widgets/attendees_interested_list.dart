import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/model/attendees_model.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class AttendeesInterestedList extends StatefulWidget {
  final List<Attendees>? itemsList;

  const AttendeesInterestedList({super.key, required this.itemsList});

  @override
  State<AttendeesInterestedList> createState() =>
      _AttendeesInterestedListState();
}

class _AttendeesInterestedListState extends State<AttendeesInterestedList> {
  late final EventsCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
  }

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
          print("assetPath: ${widget.itemsList?[index].image}");
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                Row(children: [
                  CircularCacheImageWidget(
                    showLoading: true,
                    imageHeight: .15.sw,
                    // imageWidth: AppDimensions.sideHustleItemWidth,
                    // assetImage: widget.itemsList?[index].image,
                    assetImage: AssetsPath.placeHolder,
                    image: state.attendeesModel?.data?[index].image,
                    imageWidth: .15.sw,
                  ),
                  width(
                    0.02.sw,
                  ),
                  Expanded(
                    child: textWidget(
                        text: state.attendeesModel?.data?[index].username,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textSizeSmall),
                  ),
                  Row(
                    children: [
                      CircularIconButton(
                        width: 0.08.sw,
                        height: 0.08.sw,
                        onPressed: () async {
                          /// Test Rejected
                          await _bloc.updateAttendeesCubit(context: context,
                              mounted: mounted,
                              status: AttendeesEnum
                                  .Rejected.name,
                              eventId: state.attendeesModel?.data?[index]
                                  .eventId?.toString(),
                              attendeesId: state.attendeesModel?.data?[index].id
                                  ?.toString());
                        },
                        icon: CustomIcon.cross,
                        backgroundColor:
                        AppColors.backIconBackgroundColor,
                        iconSize: 0.050.sw,
                        iconColor: AppColors.blackColor,
                      ),
                      width(0.07.sw),
                      CircularIconButton(
                        width: 0.08.sw,
                        height: 0.08.sw,
                        onPressed: () async {
                          await _bloc.updateAttendeesCubit(context: context,
                              mounted: mounted,
                              status: AttendeesEnum
                                  .Confirmed.name,
                              eventId: state.attendeesModel?.data?[index]
                                  .eventId?.toString(),
                              attendeesId: state.attendeesModel?.data?[index].id
                                  ?.toString());
                        },
                        icon: CustomIcon.ok,
                        backgroundColor: AppColors.primaryColor,
                        iconSize: 0.050.sw,
                        iconColor: AppColors.whiteColor,
                      ),
                    ],
                  ),
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
