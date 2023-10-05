import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/text_widget.dart';

class HorizontalItemHomeWidget extends StatelessWidget {
  final String? title;
  final List? itemsList;
  final double horizontalListSize;
  final Function()? onTapLabel;

  const HorizontalItemHomeWidget(
      {super.key,
      this.title,
      this.itemsList,
      this.onTapLabel,
      required this.horizontalListSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: onTapLabel,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(
                    text: title ?? AppStrings.blessTheseBusinesses,
                    fontSize: AppDimensions.textSizeNormal,
                    fontWeight: FontWeight.w500,
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10, // Replace with your item count
            itemBuilder: (context, index) {
              // Replace with your horizontal list item
              return Container(
                width: 100, // Set the desired width
                color: Colors.blue, // Example background color
                margin: const EdgeInsets.all(8),
                child: Center(
                  child: Text('Item $index',
                      style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
