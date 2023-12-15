import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_list.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/list/bullet_point_list.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewEvent extends StatefulWidget {
  final int? id;

  const ViewEvent({super.key, this.id});

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  late final EventsCubit _bloc;
  bool _isInterestedInEvent = false;

  @override
  void initState() {
    _bloc = BlocProvider.of<EventsCubit>(context);
    _isInterestedInEvent = false;
    getEvent(id: widget.id);
    super.initState();
  }

  getEvent({required int? id}) async {
    await _bloc.getEventDetailsCubit(
        context: context, mounted: mounted, id: id);
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
      actions: [
        BlocBuilder<EventsCubit, EventsState>(builder: (context, state) {
          return state.eventsDetailModel?.eventDetails == null
              ? const SizedBox.shrink()
              : Padding(
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
                          CustomIcon.forward,
                          size: 0.05.sw,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          print("clicked");
                        },
                      ),
                    ),
                  ),
                );
        })
      ],
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
                          ImageSlider(
                              hideCameraIcon: true,
                              // itemImages: [
                              //   AssetsPath.musical,
                              //   AssetsPath.musical,
                              //   AssetsPath.musical
                              // ],
                              responseImages: state
                                  .eventsDetailModel?.eventDetails?.images),
                          height(0.02.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(
                                    // text: AppStrings.viewEventMusical,
                                    text: state.eventsDetailModel?.eventDetails
                                        ?.eventName,
                                    fontFamily: AppFont.gilroyBold,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppDimensions.textHeadingSizeViewForms,
                                    color: AppColors.textBlackColor),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    textWidget(
                                        // text: AppStrings.eventPrice,
                                        text: state.eventsDetailModel
                                            ?.eventDetails?.price,
                                        fontFamily: AppFont.gilroyBold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppDimensions
                                            .textPriceSizeViewForms,
                                        color: AppColors.textBlackColor),
                                    textWidget(
                                      text: AppStrings.perHead,
                                      color: AppColors.textBlackColor,
                                      fontSize: AppDimensions.textSize10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          height(4.w),
                          SizedBox(
                            width: .8.sw,
                            child: Padding(
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
                                        // text: AppStrings.locationText,
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
                          ),
                          height(0.01.sh),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          height(0.02.sh),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: textWidget(
                                text: AppStrings.eventPostedBy,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          height(0.01.sw),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      CircularCacheImageWidget(
                                        showLoading: false,
                                        // image: AssetsPath.leoLubinProfile,
                                        image: state
                                            .eventsDetailModel
                                            ?.eventDetails
                                            ?.eventOwnerDetail
                                            ?.image,
                                        boarderColor: AppColors.primaryColor,
                                        imageHeight: .1.sw,
                                        imageWidth: .1.sw,
                                      ),
                                      width(.02.sw),
                                      Expanded(
                                        child: textWidget(
                                            // text: AppStrings.eventPostedProfileName,
                                            text: state
                                                .eventsDetailModel
                                                ?.eventDetails
                                                ?.eventOwnerDetail
                                                ?.name,
                                            fontFamily: AppFont.gilroySemiBold,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textBlackColor),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButtonWithBackground(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.chatOneToOneScreenRoute,
                                        arguments: const ChatOneToOne(
                                          userName: AppStrings.leoLubin,
                                        ));
                                  },
                                  iconPath: AssetsPath.message,
                                  height: 0.12.sw,
                                  width: 0.12.sw,
                                  iconSize: 20,
                                  backgroundColor: AppColors.primaryColor,
                                  iconColor: AppColors.whiteColor,
                                  borderRadius: 12,
                                ),
                              ],
                            ),
                          ),
                          height(8.w),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.eventPurpose,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.01.sh),
                          // height(8.w),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                // text: AppStrings.eventPurposeText,
                                text: state
                                    .eventsDetailModel?.eventDetails?.purpose,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions
                                    .textSubHeadingTextSizeViewForms),
                          ),
                          // height(8.w),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.eventTheme,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFont.gilroyBold,
                                color: AppColors.textBlackColor,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.01.sh),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                // text: AppStrings.eventThemeHint,
                                text: state
                                    .eventsDetailModel?.eventDetails?.theme,
                                color: AppColors.textBlackColor,
                                fontSize: AppDimensions
                                    .textSubHeadingTextSizeViewForms),
                          ),
                          // height(0.02.sh),
                          // height(2.w),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.vendorsList,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFont.gilroyBold,
                                color: AppColors.textBlackColor,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.01.sh),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: BulletPointList(
                              // itemsList: AppList.vendorsListData,
                              itemsList: state
                                  .eventsDetailModel?.eventDetails?.vendorsList,
                              color: AppColors.textBlackColor,
                            ),
                          ),
                          // height(0.02.sh),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.eventAvailableAttractions,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFont.gilroyBold,
                                color: AppColors.textBlackColor,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.01.sh),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: BulletPointList(
                              // itemsList: AppList.attractionList,
                              availableAttractions: state.eventsDetailModel
                                  ?.eventDetails?.availableAttractions,
                              color: AppColors.textBlackColor,
                            ),
                          ),
                          // height(0.02.sh),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: textWidget(
                                text: AppStrings.paymentType,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor,
                                fontSize:
                                    AppDimensions.textSubHeadingSizeViewForms),
                          ),
                          // height(0.01.sh),
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
                                      // text: PaymentTypeEnum.Cash.name,
                                      text: state.eventsDetailModel
                                          ?.eventDetails?.paymentType,
                                      color: AppColors.textBlackColor,
                                      fontSize: AppDimensions
                                          .textSubHeadingTextSizeViewForms),
                                ),
                              ],
                            ),
                          ),
                          height(0.03.sw),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomMaterialButton(
                                onPressed: state.eventsDetailModel?.eventDetails
                                            ?.isInterested ==
                                        0
                                    ? () async {
                                        await _bloc.getIsInterestedEventCubit(
                                            context: context,
                                            mounted: mounted,
                                            id: widget.id);
                                      }
                                    : null,
                                color: state.eventsDetailModel?.eventDetails
                                            ?.isInterested ==
                                        1
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                                textColor: state.eventsDetailModel?.eventDetails
                                            ?.isInterested ==
                                        1
                                    ? AppColors.primaryColor
                                    : AppColors.whiteColor,
                                name: state.eventsDetailModel?.eventDetails
                                            ?.isInterested ==
                                        1
                                    ? AppStrings.interested
                                    : AppStrings.interestedInEvent),
                          )
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}
