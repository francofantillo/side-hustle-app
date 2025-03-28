import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/notifications/widgets/notifications_list.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/date_time_conversions.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';
import 'package:side_hustle/widgets/size_widget.dart';

import '../widgets/text/text_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final AuthCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getNotifications();
    super.initState();
  }

  getNotifications() async {
    await _bloc.getNotificationsCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.notifications,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        return state.notificationsLoading
            ? const SizedBox.shrink()
            : (state.notificationsModel?.data?.length ?? 0) == 0
                ? const CustomErrorWidget(
                    errorMessage: AppStrings.notificationsNotFound,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DateTimeConversions.isPastDate(
                              timeStamp:
                                  state.notificationsModel?.data?[0].datetime)
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: textWidget(
                                  text: "Today",
                                  color: AppColors.blackColor,
                                  fontFamily: AppFont.gilroyBold,
                                  fontSize: AppDimensions.textSizeNormal,
                                  fontWeight: FontWeight.bold),
                            ),
                      const NotificationsList(),
                      height(0.02.sh)
                    ],
                  );
      }),
    );
  }
}
