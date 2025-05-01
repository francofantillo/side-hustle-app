import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:side_hustle/base_widget/base_widget.dart';
import 'package:side_hustle/state_management/service/stripe_service.dart';
import 'package:side_hustle/utils/api_keys.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Validate API keys - will crash the app with a clear error if keys are not properly configured
  ApiKeys.validateKeys();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppUtils.configEasyLoading();
  HttpOverrides.global = MyHttpOverrides();
  StripeService.init();

  runApp(
    const BaseWidget(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
