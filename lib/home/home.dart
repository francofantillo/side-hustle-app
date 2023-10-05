import 'package:flutter/material.dart';
import 'package:side_hustle/drawer/app_drawer.dart';
import 'package:side_hustle/home/widgets/home_first_item_list.dart';
import 'package:side_hustle/home/widgets/home_widgets.dart';
import 'package:side_hustle/home/widgets/jobs_item.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/height_widget.dart';
import 'package:side_hustle/widgets/search_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      drawer: const AppDrawer(),
      body: Builder(builder: (contextBuilder) {
        return Padding(
          padding: EdgeInsets.all(AppDimensions.rootPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeTopWidgets(contextBuilder: contextBuilder),
              height(AppDimensions.homeSearchSpacingTop),
              SearchTextField(onChanged: (search) {}),
              height(
                AppDimensions.homeSearchSpacingBelow,
              ),
              HorizontalItemHomeWidget(
                horizontalListSize: AppDimensions.homeFirstHorizontalListSize,
                onTapLabel: () {
                  print("Clicked");
                },
              ),
              // Vertical ListView
              const JobsItem(),
              height(20),
              Container(
                height: 20,
                color: Colors.red,
              )
            ],
          ),
        );
      }),
    );
  }
}
