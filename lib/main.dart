import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:side_hustle/base_widget/base_widget.dart';
import 'package:side_hustle/utils/app_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppUtils.configEasyLoading();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    const BaseWidget(),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
