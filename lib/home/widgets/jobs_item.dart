import 'package:flutter/material.dart';
import 'package:side_hustle/home/widgets/home_first_item_list.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class JobsItem extends StatelessWidget {
  const JobsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3, // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your vertical list item
          return HorizontalItemHomeWidget(
            title: "xyz",
            horizontalListSize: AppDimensions.homeFirstHorizontalListSize,
            onTapLabel: () {
              print("Clicked");
            },
          );
        },
      ),
    );
  }
}
