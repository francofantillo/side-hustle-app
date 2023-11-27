import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BulletPointList extends StatefulWidget {
  final double? fontSize;
  final String? fontFamily;
  final Color? color;
  final List? itemsList;

  const BulletPointList(
      {super.key,
      required this.itemsList,
      this.fontFamily,
      this.fontSize,
      this.color});

  @override
  State<BulletPointList> createState() => _BulletPointListState();
}

class _BulletPointListState extends State<BulletPointList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
      itemCount: widget.itemsList?.length ?? 0,
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
                text: widget.itemsList?[index],
                fontFamily: widget.fontFamily,
                color: widget.color,
                fontSize: widget.fontSize ?? AppDimensions.textSizeVerySmall),
          )
        ]);
      },
    );
  }
}
