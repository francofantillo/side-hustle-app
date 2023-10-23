import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_list.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/circular_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AttendeesEvent extends StatefulWidget {
  const AttendeesEvent({super.key});

  @override
  State<AttendeesEvent> createState() => _AttendeesEventState();
}

class _AttendeesEventState extends State<AttendeesEvent> {
  final ValueNotifier<int> _tabIndexBasicToggle = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.attendees,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.rootPadding),
        child: Column(
          children: [
            SizedBox(
              width: 1.sw,
              child: ToggleSwitch(
                customWidths: [.5.sw, .43.sw],
                isVertical: false,
                minWidth: 90,
                cornerRadius: 20.0,
                changeOnTap: true,
                activeBgColors: const [
                  [AppColors.primaryColor],
                  [AppColors.primaryColor]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: AppColors.switchTabBackgroundColor,
                inactiveFgColor: Colors.black,
                initialLabelIndex: _tabIndexBasicToggle.value,
                totalSwitches: 2,
                labels: [
                  AttendeesEnum.Interested.name,
                  AttendeesEnum.Confirmed.name,
                ],
                radiusStyle: true,
                onToggle: (index) {
                  _tabIndexBasicToggle.value = index ?? 0;
                  print('switched to: ${_tabIndexBasicToggle.value}');
                  setState(() {});
                },
              ),
            ),
            Builder(builder: (context) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.rootPadding, vertical: 8),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
                    itemCount: AppList.attendeesList.length ?? 0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Row(children: [
                        CircularCacheImageWidget(
                          showLoading: true,
                          assetImage: AppList.attendeesList[index].image,
                          imageWidth: .15.sw,
                        ),
                        //bullet text
                        width(
                          0.02.sw,
                        ),
                        //space between bullet and text
                        Expanded(
                          child: textWidget(
                              text: AppList.attendeesList[index].name,
                              fontSize: AppDimensions.textSizeSmall),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                print("clicked cancel");
                              },
                              icon: Icon(
                                Icons.cancel_sharp,
                                size: 0.06.sh,
                              ),
                              color: AppColors.cancelIconBackgroundColor,
                            ),
                            IconButton(
                              onPressed: () {
                                print("clicked checked");
                              },
                              icon: Icon(
                                Icons.check_circle,
                                size: 0.059.sh,
                              ),
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ]);
                    },
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
