import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_router.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/state_management/cubit/favourites/favourites_cubit.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/state_management/cubit/wanted_job/wanted_job_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/my_behaviour.dart';
import 'package:side_hustle/utils/screen_design_size.dart';
import 'package:side_hustle/utils/service/firebase_service.dart';

import '../firebase_options.dart';
import '../utils/app_font.dart';

class BaseWidget extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const BaseWidget({super.key});

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  void initState() {
    _setNotifications();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print(
          "ScreenDesignSize sh: ${ScreenDesignSize.sh}, ScreenDesignSize sw: ${ScreenDesignSize.sw}");
    }
    ScreenDesignSize.setDesignSize(context: context);
  }

  void _setNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    // print(apnsToken);
    // print(fcmToken);

    await FirebaseMessagingService().initializeNotificationSettings();
    FirebaseMessagingService().foregroundNotification();
    FirebaseMessagingService().backgroundTapNotification();
    final String? deviceToken = await FirebaseMessagingService().getToken();
    // if (kDebugMode) {
    print("Firebase Token: $deviceToken");
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<CardCubit>(create: (context) => CardCubit()),
        BlocProvider<EventsCubit>(create: (context) => EventsCubit()),
        BlocProvider<FavouritesCubit>(create: (context) => FavouritesCubit()),
        BlocProvider<JobsCubit>(create: (context) => JobsCubit()),
        BlocProvider<SideHustleCubit>(create: (context) => SideHustleCubit()),
        BlocProvider<ChatCubit>(create: (context) => ChatCubit()),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) {
          return ScreenUtilInit(
            // designSize: const Size(AppSize.fullScreenWidth, AppSize.fullScreenHeight),
            designSize: Size(ScreenDesignSize.sw, ScreenDesignSize.sh),
            builder: (context, child) {
              return MaterialApp(
                navigatorKey: BaseWidget.globalKey,
                theme: ThemeData(
                  fontFamily: AppFont.gilroyRegular,
                  colorScheme: ThemeData()
                      .colorScheme
                      .copyWith(primary: AppColors.primaryColor)
                      .copyWith(background: AppColors.backgroundColor),
                  // This makes the visual density adapt to the platform that you run
                  // the app on. For desktop platforms, the controls will be smaller and
                  // closer together (more dense) than on mobile platforms.
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                locale: DevicePreview.locale(context),
                builder: EasyLoading.init(builder: (context, child) {
                  return (MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child!,
                    ),
                  ));
                }),
                title: AppStrings.APP_TITLE,
                debugShowCheckedModeBanner: false,
                // initialRoute: AppRoutes.splashScreenRoute,
                // initialRoute: AppRoutes.postEventScreenRoute,
                onGenerateRoute: AppRouter().onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
