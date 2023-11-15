import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/model/attendees_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
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
    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
      itemCount: widget.itemsList?.length ?? 0,
      // Replace with your item count
      itemBuilder: (context, index) {
        // Replace with your horizontal list item
        return Column(
          children: [
            Row(children: [
              CircularCacheImageWidget(
                showLoading: true,
                assetImage: widget.itemsList?[index].image,
                imageWidth: .15.sw,
              ),
              //bullet text
              width(
                0.02.sw,
              ),
              Expanded(
                child: textWidget(
                    text: widget.itemsList?[index].name,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              // Expanded(child: Column(
              //   children: [
              //     customMaterialButton(onPressed: (){}, height: 0.01, borderRadius: 16, name: AppStrings.viewProfile, ),
              //   ],
              // ))
              InkWell(
                splashColor: AppColors.greyColor,
                onTap: (){
                  // Navigator.pushReplacementNamed(context, AppRoutes.otherUserProfileScreenRoute);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: textWidget(
                      text: AppStrings.viewProfile,
                      color: AppColors.whiteColor,
                      fontSize: AppDimensions.textSizeVerySmall,
                      fontWeight: FontWeight.w500),
                ),
              )
              // Expanded(
              //   child: InkWell(
              //     onTap: (){},
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Container(
              //           height: .056.sh,
              //           width: .23.sw,
              //           decoration: BoxDecoration(
              //             color: AppColors.primaryColor,
              //             borderRadius: BorderRadius.circular(
              //                 AppDimensions.bookedJobRoundedBorder),
              //           ),
              //           child: Center(
              //             child: textWidget(
              //               text: AppStrings.viewEvent,
              //               color: AppColors.textWhiteColor,
              //               fontSize: 12.sp,
              //               fontWeight: FontWeight.w500,
              //               textAlign: TextAlign.center,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ]),
            const Divider()
          ],
        );
      },
    );
  }
}
