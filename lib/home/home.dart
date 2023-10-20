import 'package:flutter/material.dart';
import 'package:side_hustle/home/widgets/home_first_item_list.dart';
import 'package:side_hustle/home/widgets/home_widgets.dart';
import 'package:side_hustle/home/widgets/jobs_events_item_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var index = 0;
  bool isProductSelected = true;

  @override
  void initState() {
    isProductSelected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contextBuilder) {
      return SafeArea(
        child: Column(
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
              child: SearchTextField(
                  hintText: AppStrings.searchHintText,
                  onChanged: (search) {}),
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
                        isProductSelected: (v) {
                          isProductSelected = v;
                          print("prodcut: $isProductSelected");
                        },
                        onPressed: () {
                          print("pressed Dialogue");
                          if(isProductSelected) {
                            /// reset to Default Value
                            isProductSelected = true;
                            // Navigator.pop(contextBuilder);
                            AppDialogues.postSideHustleDialogue(context: contextBuilder).dismiss();
                            Navigator.pushNamed(contextBuilder, AppRoutes.postProductScreenRoute);
                          } else {
                            /// reset to Default Value
                            isProductSelected = true;
                            AppDialogues.postSideHustleDialogue(context: contextBuilder).dismiss();
                            // Navigator.pop(contextBuilder);
                            Navigator.pushNamed(contextBuilder, AppRoutes.postServiceScreenRoute);
                          }
                        },
                        onTapClose: () {
                          Navigator.pop(contextBuilder);
                        },
                      ))
                  // ..show()
                      .show();
                }),
          ],
        ),
      );
    });
  }
}
