import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/router/app_router.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/state_management/cubit/events/events_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/my_behaviour.dart';
import 'package:side_hustle/utils/screen_design_size.dart';

import '../utils/app_font.dart';

class BaseWidget extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const BaseWidget({super.key});

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
        "ScreenDesignSize sh: ${ScreenDesignSize.sh}, ScreenDesignSize sw: ${ScreenDesignSize.sw}");
    ScreenDesignSize.setDesignSize(context: context);
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
                // initialRoute: AppRoutes.paymentMethodScreenRoute,
                onGenerateRoute: AppRouter().onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
