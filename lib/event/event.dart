import 'package:flutter/material.dart';
import 'package:side_hustle/bottom_tabs/widget/custom_home_app_bar.dart';
import 'package:side_hustle/event/widgets/event_list.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/primary_button.dart';
import 'package:side_hustle/widgets/dialogue/post_your_side_hustle.dart';
import 'package:side_hustle/widgets/text_field/search_text_field.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var index = 0;
  bool isProductSelected = true;

  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  void initState() {
    isProductSelected = true;
    super.initState();
  }

  List<List<Color>?>? bgColorsZero = [
    [AppColors.primaryColor],
    [Colors.transparent],
    [Colors.transparent],
    [Colors.transparent],
  ];

  List<List<Color>?>? bgColorsOne = [
    [Colors.transparent],
    [AppColors.primaryColor],
    [Colors.transparent],
    [Colors.transparent],
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contextBuilder) {
      print('switched to: ${_tabIndexBasicToggle.value}');
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: PrimaryPostButton(
              title: AppStrings.postAnEvent,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.postEventScreenRoute);
              }),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding),
              child: CustomHomeAppBarWidget(
                contextBuilder: contextBuilder,
                title: AppStrings.events,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.rootPadding,
                  right: AppDimensions.rootPadding,
                  top: AppDimensions.rootPadding),
              child: SearchTextField(
                  hintText: AppStrings.searchEvent,
                  suffixIcon:
                   Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 0),
                    child: Material(
                        child: InkWell(
                            onTap: (){
                              print("onClicked Filter");
                            },
                            child: const ImageIcon(AssetImage(AssetsPath.searchFilter)))),
                  ),
                  onChanged: (search) {}),
            ),
            // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
            const EventList()
          ],
        ),
      );
    });
  }
}
