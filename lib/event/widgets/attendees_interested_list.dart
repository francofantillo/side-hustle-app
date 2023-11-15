import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/model/attendees_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
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
              //space between bullet and text
              Expanded(
                child: textWidget(
                    text: widget.itemsList?[index].name,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimensions.textSizeSmall),
              ),
              Row(
                children: [
                  CircularIconButton(
                    width: 0.08.sw,
                    height: 0.08.sw,
                    onPressed: () {},
                    icon: CustomIcon.cross,
                    backgroundColor: AppColors.backIconBackgroundColor,
                    iconSize: 0.050.sw,
                    iconColor: AppColors.blackColor,
                  ),
                  width(0.07.sw),
                  CircularIconButton(
                    width: 0.08.sw,
                    height: 0.08.sw,
                    onPressed: () {},
                    icon: CustomIcon.ok,
                    backgroundColor: AppColors.primaryColor,
                    iconSize: 0.050.sw,
                    iconColor: AppColors.whiteColor,
                  ),
                ],
              ),
            ]),
            const Divider()
          ],
        );
      },
    );
  }
}
