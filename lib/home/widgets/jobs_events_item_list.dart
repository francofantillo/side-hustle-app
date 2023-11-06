import 'package:flutter/material.dart';
import 'package:side_hustle/home/widgets/jobs_horizontal_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class JobsAndEventsList extends StatelessWidget {
  final double? rightPadding, leftPadding;
  final List<JobsAndEvents>? jobsAndEventsList;

  const JobsAndEventsList(
      {super.key, this.jobsAndEventsList, this.rightPadding, this.leftPadding});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),

        itemCount: jobsAndEventsList?.length ?? 0,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your vertical list item
          return Padding(
            padding: EdgeInsets.only(
                left: leftPadding ?? 0, right: rightPadding ?? 0, bottom: 6),
            child: JobsHorizontalListWidget(
              isEvent: index == 1 ? true : false,
              title: jobsAndEventsList?[index].title,
              horizontalListSize: AppDimensions.listItemHeight,
              itemsList: jobsAndEventsList?[index].itemList,
              onTapLabel: () {
                if (index == 1) {
                  Navigator.pushNamed(context, AppRoutes.viewEventScreenRoute);
                } else {
                  Navigator.pushNamed(context, AppRoutes.viewJobScreenRoute);
                }
                print("Clicked");
              },
            ),
          );
        },
      ),
    );
  }
}
