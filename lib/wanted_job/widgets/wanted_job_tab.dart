import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class WantedJobTab extends StatefulWidget {
  final int currentTabIndex;
  final ValueChanged<int> onChanged;

  const WantedJobTab(
      {super.key,
      this.currentTabIndex = 0,
      required this.onChanged});

  @override
  State<WantedJobTab> createState() => _WantedJobTabState();
}

class _WantedJobTabState extends State<WantedJobTab> {

  late final ValueNotifier<int> _tabIndexBasicToggle;
  
  @override
  void initState() {
    _tabIndexBasicToggle = ValueNotifier(widget.currentTabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.switchTabBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Material(
                elevation: 0,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: InkWell(
                  onTap: () {
                    _tabIndexBasicToggle.value = 0;
                    widget.onChanged(_tabIndexBasicToggle.value);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.switchTabBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                    child: Container(
                        padding: EdgeInsets.only(
                          top: AppDimensions.tabBarWantedTabsHeight,
                          bottom: AppDimensions.tabBarWantedTabsHeight,
                          // left: 4,
                          // right: 1,
                        ),
                        decoration: BoxDecoration(
                            color: _tabIndexBasicToggle.value == 0
                                ? AppColors.primaryColor
                                : AppColors.switchTabBackgroundColor,
                            borderRadius: _tabIndexBasicToggle.value == 0
                                ? const BorderRadius.all(Radius.circular(25))
                                : const BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    topLeft: Radius.circular(25))),
                        child: textWidget(
                            text: "${AppStrings.wantedJob}s",
                            textAlign: TextAlign.center,
                            color: _tabIndexBasicToggle.value == 0
                                ? AppColors.whiteColor
                                : AppColors.tabBarInactiveTextColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.tabBarFontSize)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    _tabIndexBasicToggle.value = 1;
                    widget.onChanged(_tabIndexBasicToggle.value);
                  },
                  child: Container(
                      color: AppColors.switchTabBackgroundColor,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: AppDimensions.tabBarWantedTabsHeight,
                          bottom: AppDimensions.tabBarWantedTabsHeight,
                        ),
                        decoration: BoxDecoration(
                            color: _tabIndexBasicToggle.value == 1
                                ? AppColors.primaryColor
                                : AppColors.switchTabBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(
                                _tabIndexBasicToggle.value == 1
                                    ? 25
                                    : 0))),
                        child: textWidget(
                            text: AppStrings.applied,
                            textAlign: TextAlign.center,
                            color: _tabIndexBasicToggle.value == 1
                                ? AppColors.whiteColor
                                : AppColors.tabBarInactiveTextColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.tabBarFontSize),
                      )),
                ),
              ),
            ),
            Expanded(
              child: Material(
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    _tabIndexBasicToggle.value = 2;
                    widget.onChanged(_tabIndexBasicToggle.value);
                  },
                  child: Container(
                    color: AppColors.switchTabBackgroundColor,
                    child: Container(
                        padding: EdgeInsets.only(
                          top: AppDimensions.tabBarWantedTabsHeight,
                          bottom: AppDimensions.tabBarWantedTabsHeight,
                        ),
                        decoration: BoxDecoration(
                            color: _tabIndexBasicToggle.value == 2
                                ? AppColors.primaryColor
                                : AppColors.switchTabBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(
                                _tabIndexBasicToggle.value == 2
                                    ? 25
                                    : 0))),
                        child: textWidget(
                            text: AppStrings.booked,
                            textAlign: TextAlign.center,
                            color: _tabIndexBasicToggle.value == 2
                                ? AppColors.whiteColor
                                : AppColors.tabBarInactiveTextColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.tabBarFontSize)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    _tabIndexBasicToggle.value = 3;
                    widget.onChanged(_tabIndexBasicToggle.value);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.switchTabBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Container(
                        // padding: const EdgeInsets.all(8),
                        padding: EdgeInsets.only(
                          top: AppDimensions.tabBarWantedTabsHeight,
                          bottom: AppDimensions.tabBarWantedTabsHeight,
                        ),
                        decoration: BoxDecoration(
                            color: _tabIndexBasicToggle.value == 3
                                ? AppColors.primaryColor
                                : AppColors.switchTabBackgroundColor,
                            borderRadius: _tabIndexBasicToggle.value == 3
                                ? const BorderRadius.all(Radius.circular(25))
                                : const BorderRadius.only(
                                    bottomRight: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                        child: textWidget(
                            text: AppStrings.completed,
                            textAlign: TextAlign.center,
                            color: _tabIndexBasicToggle.value == 3
                                ? AppColors.whiteColor
                                : AppColors.tabBarInactiveTextColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: AppDimensions.tabBarFontSize)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
