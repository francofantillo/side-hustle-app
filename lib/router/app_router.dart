import 'package:flutter/material.dart';
import 'package:side_hustle/auth/forgot_password.dart';
import 'package:side_hustle/auth/login.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/auth/reset_password.dart';
import 'package:side_hustle/auth/signup.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/event/attendees.dart';
import 'package:side_hustle/event/event.dart';
import 'package:side_hustle/event/post_event.dart';
import 'package:side_hustle/event/view_event.dart';
import 'package:side_hustle/event/view_event_self.dart';
import 'package:side_hustle/home/home.dart';
import 'package:side_hustle/job/apply_job.dart';
import 'package:side_hustle/job/post_job.dart';
import 'package:side_hustle/product/post_product.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/post_service.dart';
import 'package:side_hustle/side_hustle/side_hustle.dart';
import 'package:side_hustle/splash/splash.dart';
import 'package:side_hustle/splash/splash_transparent.dart';
import 'package:side_hustle/wanted_job/wanted_job.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          //-------------- User Navigation Routes ---------------------- //
          case AppRoutes.splashScreenRoute:
            return const SplashScreen();

          case AppRoutes.splashTransParentScreenRoute:
            return const SplashTransParentScreen();

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

          case AppRoutes.applyForJobScreenRoute:
            return const ApplyForJob();

          case AppRoutes.wantedJobScreenRoute:
            return const WantedJobScreen();

          case AppRoutes.eventScreenRoute:
            return const EventScreen();

          case AppRoutes.postEventScreenRoute:
            return const PostEvent();

          case AppRoutes.viewEventScreenRoute:
            return const ViewEvent();

          case AppRoutes.viewEventSelfScreenRoute:
            return const ViewEventSelf();

          case AppRoutes.attendeesEventScreenRoute:
            return const AttendeesEvent();

          case AppRoutes.sideHustleScreenRoute:
            return const SideHustle();

          case AppRoutes.viewProductScreenRoute:
            return const ViewPorduct();

          case AppRoutes.bottomTabsScreenRoute:
            return const BottomTabsScreen();

          default:
            return Container();
        }
      },
    );
  }
}
