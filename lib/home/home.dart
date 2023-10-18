import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_navigation/bottom_nav.dart';
import 'package:side_hustle/drawer/app_drawer.dart';
import 'package:side_hustle/home/widgets/home_first_item_list.dart';
import 'package:side_hustle/home/widgets/home_widgets.dart';
import 'package:side_hustle/home/widgets/jobs_events_item_list.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

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
      bottomNavBar: BottomNav(
        onTap: (index) {},
      ),
      body: Builder(builder: (contextBuilder) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding),
              child: HomeTopWidgets(contextBuilder: contextBuilder),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding),
              child: SearchTextField(onChanged: (search) {}),
            ),
            // Horizontal ListView
            Padding(
              padding: EdgeInsets.only(
                left: AppDimensions.rootPadding,
                right: AppDimensions.rootPadding,
              ),
              child: FirstHomeListItemWidget(
                horizontalListSize: AppDimensions.homeFirstHorizontalListSize,
                itemsList: AlphaAppData.homeFirstList,
                onTapLabel: () {
                  print("Clicked");
                },
              ),
            ),
            // Vertical ListView
            JobsAndEventsList(
                rightPadding: AppDimensions.rootPadding,
                leftPadding: AppDimensions.rootPadding,
                jobsAndEventsList: AlphaAppData.jobsAndEventsList),
            height(20),
            PrimaryPostButton(
                title: AppStrings.postASideHustle,
                onPressed: () {
                  AppDialogues.postSideHustleDialogue(
                          context: contextBuilder,
                          body: PostYourSideHustle(
                            onPressed: () {
                              print("pressed Dialogue");
                            },
                            onTapClose: () {
                              Navigator.pop(contextBuilder);
                            },
                          ))
                      // ..show()
                      .show();
                }),
          ],
        );
      }),
    );
  }
}
