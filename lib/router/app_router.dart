import 'package:flutter/material.dart';
import 'package:side_hustle/auth/forgot_password.dart';
import 'package:side_hustle/auth/login.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/auth/reset_password.dart';
import 'package:side_hustle/auth/signup.dart';
import 'package:side_hustle/home/home.dart';
import 'package:side_hustle/job/post_job.dart';
import 'package:side_hustle/product/post_product.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/post_service.dart';
import 'package:side_hustle/splash/splash.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          //-------------- User Navigation Routes ---------------------- //
          case AppRoutes.splashScreenRoute:
            return const SplashScreen();

          case AppRoutes.loginScreenRoute:
            return const LoginScreen();

          case AppRoutes.signupScreenRoute:
            return const SignupScreen();

          case AppRoutes.forgotPasswordScreenRoute:
            return const ForgotPasswordScreen();

          case AppRoutes.resetPasswordScreenRoute:
            return const ResetPassword();

          case AppRoutes.otpVerificationScreenRoute:
            final args = routeSettings.arguments as OtpVerificationScreen?;
            return OtpVerificationScreen(isSocial: args?.isSocial ?? false);

          case AppRoutes.homeScreenRoute:
            return const HomeScreen();

          case AppRoutes.postProductScreenRoute:
            return const PostProduct();

          case AppRoutes.postServiceScreenRoute:
            return const PostService();

          case AppRoutes.postJobScreenRoute:
            return const PostJob();

          default:
            return Container();
        }
      },
    );
  }
}
