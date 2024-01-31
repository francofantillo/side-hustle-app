import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/attendees.dart';
import 'package:side_hustle/event/post_event.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_list.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_alpha.dart';
import 'package:side_hustle/widgets/image_slider/image_slider_no_images_found.dart';
import 'package:side_hustle/widgets/list/bullet_point_list.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewEventSelf extends StatefulWidget {
  final int? id;
  final int index;
  final bool showEdit;

  const ViewEventSelf(
      {super.key, this.id, this.index = 0, this.showEdit = true});

  @override
  State<ViewEventSelf> createState() => _ViewEventSelfState();
}

class _ViewEventSelfState extends State<ViewEventSelf> {
  late final EventsCubit _bloc;

  @override
  void initState() {
    print("ViewEventSelf id: ${widget.id}");
    _bloc = BlocProvider.of<EventsCubit>(context);
    getEvent(id: widget.id);
    super.initState();
  }

  getEvent({required int? id}) async {
    await _bloc.getEventDetailsCubit(
        context: context, mounted: mounted, id: id, index: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.viewEvent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      actions: widget.showEdit
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 0.09.sw, // Adjust as needed
                  height: 0.09.sw, // Adjust as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.backIconBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 0.05.sw,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        print("clicked");
                        Navigator.pushNamed(
                            context, AppRoutes.postEventScreenRoute,
                            arguments: PostEvent(
                              isEdit: true,
                              id: widget.id,
                            ));
                      },
                    ),
                  ),
                ),
              )
            ]
          : null,
      body: BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
        return state.eventsDetailLoading
            ? const SizedBox.shrink()
            : state.eventsDetailModel?.eventDetails == null
                ? const CustomErrorWidget(errorMessage: AppStrings.errorMessage)
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Padding(
                      padding: EdgeInsets.all(AppDimensions.rootPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const ImageSliderAlpha(hideCameraIcon: true),
                          state.eventsDetailModel!.eventDetails!.images!.isEmpty
                              ? const NoImagesFoundWidget()
                              : ImageSlider(
                                  hideCameraIcon: true,
                                  indicatorLength: state.eventsDetailModel
                                              ?.eventDetails?.images?.length ==
                                          null
                                      ? null
                                      : state.eventsDetailModel!.eventDetails!
                                              .images!.isEmpty
                                          ? null
                                          : state.eventsDetailModel!
                                              .eventDetails!.images!.length,
                                  // itemImages: itemImages,
                                  responseImages: state
                                      .eventsDetailModel?.eventDetails?.images),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: textWidget(
                                      text: state.eventsDetailModel
                                          ?.eventDetails?.eventName,
                                      fontFamily: AppFont.gilroyBold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimensions
                                          .textHeadingSizeViewForms,
                                      color: AppColors.textBlackColor),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    textWidget(
                                        text: state.eventsDetailModel
                                                    ?.eventDetails?.price !=
                                                null
                                            ? "\$${state.eventsDetailModel?.eventDetails?.price}"
                                            : "",
                                        fontFamily: AppFont.gilroyBold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppDimensions
                                            .textPriceSizeViewForms,
                                        color: AppColors.textBlackColor),
                                    textWidget(
                                        text: AppStrings.perHead,
                                        fontSize: AppDimensions.textSize10,
                                        color: AppColors.textBlackColor),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ImageIcon(
                                  const AssetImage(AssetsPath.location),
                                  size: AppDimensions.applyForJobIconSize,
                                  color: const Color(0xFF565656),
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      text: state.eventsDetailModel
                                          ?.eventDetails?.location,
                                      maxLines: 2,
                                      color: const Color(0xFF565656),
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ImageIcon(
                                  const AssetImage(AssetsPath.calender),
                                  size: AppDimensions.applyForJobIconSize,
                                  color: const Color(0xFF565656),
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      text: state.eventsDetailModel
                                                  ?.eventDetails?.startDate !=
                                              null
                                          ? AppUtils.formatDateView(
                                              selectedDate: DateTime.parse(state
                                                  .eventsDetailModel!
                                                  .eventDetails!
                                                  .startDate!))
                                          : "",
                                      color: const Color(0xFF565656),
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time_filled_rounded,
                                  size: AppDimensions.applyForJobIconSize,
                                  color: const Color(0xFF565656),
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      // text: AppStrings.eventTimeText,
                                      text:
                                          "Start at ${DateTimeConversions.convertTo12HourFormat(state.eventsDetailModel?.eventDetails?.startTime)} to ${DateTimeConversions.convertTo12HourFormat(state.eventsDetailModel?.eventDetails?.endTime)}",
                                      fontSize: AppDimensions
                                          .textLocationSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          height(0.01.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: SizedBox(
                              width: 1.sw,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your button click logic here
                                  Navigator.pushNamed(context,
                                      AppRoutes.attendeesEventScreenRoute,
                                      arguments: AttendeesEvent(
                                          eventId: state.eventsDetailModel
                                              ?.eventDetails?.eventId));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  // Set the background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16.0), // Make it round
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 14,
                                    bottom: 14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const ImageIcon(
                                        AssetImage(AssetsPath.attendees),
                                        color:
                                            Colors.white, // Set the icon color
                                        size: 17,
                                      ),
                                      width(0.02.sw),
                                      textWidget(
                                          text: AppStrings.viewAttendees,
                                          fontFamily: AppFont.gilroyBold,
                                          color: AppColors.textWhiteColor),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          height(8.w),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.eventPurpose,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFont.gilroyBold,
                                color: AppColors.textBlackColor,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.01.sw),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: state
                                    .eventsDetailModel?.eventDetails?.purpose,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions
                                    .textSubHeadingTextSizeViewForms),
                          ),
                          // height(0.02.sw),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.eventTheme,
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.01.sw),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: state
                                    .eventsDetailModel?.eventDetails?.theme,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions
                                    .textSubHeadingTextSizeViewForms),
                          ),
                          // height(0.02.sw),
                          state.eventsDetailModel?.eventDetails?.vendorsList !=
                                  null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: textWidget(
                                      text: AppStrings.vendorsList,
                                      fontFamily: AppFont.gilroyBold,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textBlackColor,
                                      fontSize: AppDimensions.textSizeNormal),
                                )
                              : const SizedBox.shrink(),
                          // height(0.01.sw),
                          state.eventsDetailModel?.eventDetails?.vendorsList !=
                                  null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: BulletPointList(
                                    itemsList: state.eventsDetailModel
                                        ?.eventDetails?.vendorsList,
                                    color: AppColors.textBlackColor,
                                    fontSize: AppDimensions
                                        .textSubHeadingTextSizeViewForms,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          // height(0.02.sw),
                          state.eventsDetailModel?.eventDetails
                                      ?.availableAttractions !=
                                  null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: textWidget(
                                      text:
                                          AppStrings.eventAvailableAttractions,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFont.gilroyBold,
                                      color: AppColors.textBlackColor,
                                      fontSize: AppDimensions
                                          .textSubHeadingSizeViewForms),
                                )
                              : const SizedBox.shrink(),
                          // height(0.01.sw),
                          state.eventsDetailModel?.eventDetails
                                      ?.availableAttractions !=
                                  null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: BulletPointList(
                                    availableAttractions: state
                                        .eventsDetailModel
                                        ?.eventDetails
                                        ?.availableAttractions,
                                    color: AppColors.textBlackColor,
                                    fontSize: AppDimensions
                                        .textSubHeadingTextSizeViewForms,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          // height(0.02.sw),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.paymentType,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFont.gilroyBold,
                                color: AppColors.textBlackColor,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.02.sw),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AssetsPath.cash,
                                  width: 22,
                                  height: 22,
                                ),
                                width(0.02.sw),
                                Expanded(
                                  child: textWidget(
                                      text: PaymentTypeEnum.Cash.name,
                                      color: AppColors.textBlackColor,
                                      fontSize: AppDimensions
                                          .textSubHeadingTextSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          // height(0.03.sw),
                          /*          Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomMaterialButton(
                        onPressed: () {},
                        color: AppColors.primaryColor,
                        name: AppStrings.shareEvent),
                  )*/
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}
