import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/models/events_model.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BulletPointList extends StatelessWidget {
  final double? fontSize;
  final String? fontFamily;
  final Color? color;
  final List? itemsList;
  final List<String>? vendorList;
  final List<AvailableAttractions>? availableAttractions;

  const BulletPointList(
      {super.key,
      // required this.itemsList,
      this.itemsList,
      this.vendorList,
      this.availableAttractions,
      this.fontFamily,
      this.fontSize,
      this.color});

  @override
  Widget build(BuildContext context) {
    return availableAttractions?.length != null
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
            itemCount: availableAttractions?.length ?? 0,
            // Replace with your item count
            itemBuilder: (context, index) {
              // Replace with your horizontal list item
              return Row(children: [
                textWidget(
                  text: "\u2022",
                  fontSize: 14.sp,
                ),
                //bullet text
                width(
                  0.02.sw,
                ),
                //space between bullet and text
                Expanded(
                  child: textWidget(
                      text: availableAttractions?[index].attr,
                      fontFamily: fontFamily,
                      color: color,
                      fontSize: fontSize ?? AppDimensions.textSizeVerySmall),
                )
              ]);
            },
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
            itemCount: vendorList != null
                ? vendorList?.length ?? 0
                : itemsList?.length ?? 0,
            // Replace with your item count
            itemBuilder: (context, index) {
              // Replace with your horizontal list item
              return Row(children: [
                textWidget(
                  text: "\u2022",
                  fontSize: 14.sp,
                ),
                //bullet text
                width(
                  0.02.sw,
                ),
                //space between bullet and text
                Expanded(
                  child: textWidget(
                      text: itemsList?[index],
                      fontFamily: fontFamily,
                      color: color,
                      fontSize: fontSize ?? AppDimensions.textSizeVerySmall),
                )
              ]);
            },
          );
  }
}
