import 'package:flutter/material.dart';
import 'package:side_hustle/auth/about_us.dart';
import 'package:side_hustle/auth/change_password.dart';
import 'package:side_hustle/auth/download_book_screen.dart';
import 'package:side_hustle/auth/flyer_under_capitalism.dart';
import 'package:side_hustle/auth/forgot_password.dart';
import 'package:side_hustle/auth/login.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/auth/privacy_policy.dart';
import 'package:side_hustle/auth/reset_password.dart';
import 'package:side_hustle/auth/signup.dart';
import 'package:side_hustle/auth/terms_and_conditions.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/chat/chat_all_users.dart';
import 'package:side_hustle/chat/chat_block_users.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/chat/order_detail.dart';
import 'package:side_hustle/common_screens/post_added.dart';
import 'package:side_hustle/event/attendees.dart';
import 'package:side_hustle/event/event.dart';
import 'package:side_hustle/event/my_events/my_events.dart';
import 'package:side_hustle/event/post_event.dart';
import 'package:side_hustle/event/view_event.dart';
import 'package:side_hustle/event/view_event_self.dart';
import 'package:side_hustle/favourites/favourites.dart';
import 'package:side_hustle/home/home.dart';
import 'package:side_hustle/job/apply_job.dart';
import 'package:side_hustle/job/my_jobs/job_request.dart';
import 'package:side_hustle/job/my_jobs/my_jobs.dart';
import 'package:side_hustle/job/my_jobs/view_job.dart';
import 'package:side_hustle/job/post_job.dart';
import 'package:side_hustle/notifications/notifications.dart';
import 'package:side_hustle/payment_methods/payment_methods.dart';
import 'package:side_hustle/product/post_product.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/product/your_cart_products.dart';
import 'package:side_hustle/profile/other_user_profile/events_posted_other_user.dart';
import 'package:side_hustle/profile/other_user_profile/jobs_posted_other_user.dart';
import 'package:side_hustle/profile/other_user_profile/other_user_profile.dart';
import 'package:side_hustle/profile/profile.dart';
import 'package:side_hustle/profile/your_resume.dart';
import 'package:side_hustle/profile/your_resume_edit.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/post_service.dart';
import 'package:side_hustle/service/view_service.dart';
import 'package:side_hustle/service/your_service_cart.dart';
import 'package:side_hustle/shop/shop.dart';
import 'package:side_hustle/shop/your_shop.dart';
import 'package:side_hustle/side_hustle/side_hustle.dart';
import 'package:side_hustle/splash/splash.dart';
import 'package:side_hustle/splash/splash_transparent.dart';
import 'package:side_hustle/walkthrough/walkthrough.dart';
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

          case AppRoutes.changePasswordScreenRoute:
            return const ChangePassword();

          case AppRoutes.signupScreenRoute:
            return const SignupScreen();

          case AppRoutes.forgotPasswordScreenRoute:
            return const ForgotPasswordScreen();

          case AppRoutes.resetPasswordScreenRoute:
            return const ResetPassword();
          case AppRoutes.otpVerificationScreenRoute:
            final args = routeSettings.arguments as OtpVerificationScreen?;
            return OtpVerificationScreen(
              isSocial: args?.isSocial ?? false,
              isSignUp: args?.isSignUp ?? false,
              isLogin: args?.isLogin ?? false,
              phone: args?.phone,
              email: args?.email,
              isForgotPassword: args?.isForgotPassword ?? false,
            );

          case AppRoutes.homeScreenRoute:
            return const HomeScreen();

          case AppRoutes.postProductScreenRoute:
            final args = routeSettings.arguments as PostProduct?;
            return PostProduct(
              isEdit: args?.isEdit ?? false,
              id: args?.id,
              isEditFromShop: args?.isEditFromShop ?? false,
            );

          case AppRoutes.yourResumeEditScreenRoute:
            final args = routeSettings.arguments as YourResumeEdit?;
            return YourResumeEdit(
                itemsList: args?.itemsList,
                profileImagePath: args?.profileImagePath,
                pdfFilePath: args?.pdfFilePath,
                pdfFileName: args?.pdfFileName);

          case AppRoutes.yourResumeScreenRoute:
            return const YourResume();

          case AppRoutes.postServiceScreenRoute:
            final args = routeSettings.arguments as PostService?;
            return PostService(
              isEdit: args?.isEdit ?? false,
              id: args?.id,
              isEditFromShop: args?.isEditFromShop ?? false,
            );

          case AppRoutes.postJobScreenRoute:
            final args = routeSettings.arguments as PostJob?;
            return PostJob(
              isEdit: args?.isEdit ?? false,
              isJobFromMyJobs: args?.isJobFromMyJobs ?? false,
              id: args?.id,
            );

          case AppRoutes.applyForJobScreenRoute:
            final args = routeSettings.arguments as ApplyForJob?;
            return ApplyForJob(
              jobId: args?.jobId,
            );

          case AppRoutes.wantedJobScreenRoute:
            final args = routeSettings.arguments as WantedJobScreen?;
            return WantedJobScreen(currentTabIndex: args?.currentTabIndex ?? 0);

          case AppRoutes.eventScreenRoute:
            return const EventScreen();

          case AppRoutes.postEventScreenRoute:
            final args = routeSettings.arguments as PostEvent?;
            return PostEvent(
                id: args?.id,
                isEdit: args?.isEdit ?? false,
                isEventEditFromPostAdded:
                    args?.isEventEditFromPostAdded ?? false);

          case AppRoutes.viewEventScreenRoute:
            final args = routeSettings.arguments as ViewEvent?;
            return ViewEvent(
              id: args?.id,
            );

          case AppRoutes.viewEventSelfScreenRoute:
            final args = routeSettings.arguments as ViewEventSelf?;
            return ViewEventSelf(
              id: args?.id,
              index: args?.index ?? 0,
              showEdit: args?.showEdit ?? true,
              isEventEditFromPostAdded: args?.isEventEditFromPostAdded ?? false,
            );

          case AppRoutes.attendeesEventScreenRoute:
            final args = routeSettings.arguments as AttendeesEvent?;
            return AttendeesEvent(
              eventId: args?.eventId,
            );

          case AppRoutes.sideHustleScreenRoute:
            return const SideHustle();

          case AppRoutes.viewProductScreenRoute:
            final args = routeSettings.arguments as ViewProduct?;
            return ViewProduct(
              id: args?.id,
              isMyProduct: args?.isMyProduct ?? false,
              viewCart: args?.viewCart ?? false,
              isViewingProductFromOthersShop:
                  args?.isViewingProductFromOthersShop ?? false,
            );

          case AppRoutes.viewServiceScreenRoute:
            final args = routeSettings.arguments as ViewService?;
            return ViewService(
              id: args?.id,
              isMyService: args?.isMyService ?? false,
              isEditFromShop: args?.isEditFromShop ?? false,
              isViewingServiceFromOthersShop:
                  args?.isViewingServiceFromOthersShop ?? false,
            );

          case AppRoutes.shopScreenRoute:
            final args = routeSettings.arguments as ShopScreen?;
            return ShopScreen(
              shopId: args?.shopId,
            );

          case AppRoutes.profileScreenRoute:
            return const ProfileScreen();

          case AppRoutes.otherUserProfileScreenRoute:
            return const OtherUserProfileScreen();

          case AppRoutes.otherUserEventsPostedScreenRoute:
            return const OtherUserEventsPostedScreen();

          case AppRoutes.otherUserJobsPostedScreenRoute:
            return const OtherUserJobsPostedScreen();

          case AppRoutes.yourShopScreenRoute:
            return const YourShopScreen();

          // case AppRoutes.otherUserShopScreenRoute:
          //   return const OtherUserShopScreen();

          case AppRoutes.favouritesScreenRoute:
            final args = routeSettings.arguments as FavouritesScreen?;
            return FavouritesScreen(
              isFromDrawer: args?.isFromDrawer ?? false,
            );

          case AppRoutes.myJobsScreenRoute:
            final args = routeSettings.arguments as MyJobsScreen?;
            return MyJobsScreen(
              selectedIndex: args?.selectedIndex ?? 0,
            );

          case AppRoutes.myEventsScreenRoute:
            return const MyEventsScreen();

          case AppRoutes.jobRequestScreenRoute:
            final args = routeSettings.arguments as JobRequest?;
            return JobRequest(
                jobId: args?.jobId,
                isViewRequestFromJobDetail:
                    args?.isViewRequestFromJobDetail ?? false);

          case AppRoutes.viewJobScreenRoute:
            final args = routeSettings.arguments as ViewJob?;
            return ViewJob(
              jobId: args?.jobId,
            );

          case AppRoutes.paymentMethodScreenRoute:
            return const ManagePaymentMethods();

          case AppRoutes.chatAllUsersScreenRoute:
            return const ChatAllUsers();

          case AppRoutes.chatOneToOneScreenRoute:
            final args = routeSettings.arguments as ChatOneToOne?;
            return ChatOneToOne(
              userName: args?.userName,
              isBlockedUser: args?.isBlockedUser ?? false,
              isOrderChat: args?.isOrderChat ?? false,
              isOrderService: args?.isOrderService ?? false,
              index: args?.index ?? 0,
              customerId: args?.customerId,
              modelId: args?.modelId,
              modelName: args?.modelName,
              chatId: args?.chatId,
              senderModel: args?.senderModel,
              receiverModel: args?.receiverModel,
            );

          case AppRoutes.chatBlockUsersScreenRoute:
            return const ChatBlockUsers();

          case AppRoutes.aboutUsScreenRoute:
            return const AboutUs();

          case AppRoutes.privacyPolicyScreenRoute:
            return const PrivacyPolicy();

          case AppRoutes.termsAndConditionsScreenRoute:
            return const TermsAndConditions();

          case AppRoutes.flyerUnderCapitalismScreenRoute:
            return const FlyerUnderCapitalismScreen();

          case AppRoutes.downloadBookScreenRoute:
            return const DownloadBookScreen();

          case AppRoutes.walkthroughScreenRoute:
            return const Walkthrough();

          case AppRoutes.yourServiceCartScreenRoute:
            return const YourServiceCart();

          case AppRoutes.yourProductsCartScreenRoute:
            return const YourProductsCart();

          case AppRoutes.orderDetailScreenRoute:
            final args = routeSettings.arguments as OrderDetail?;
            return OrderDetail(
              orderId: args?.orderId,
            );

          case AppRoutes.postAddedScreenRoute:
            final args = routeSettings.arguments as PostAdded?;
            return PostAdded(
                buttonName: args?.buttonName,
                id: args?.id,
                title: args?.title,
                subTitle: args?.subTitle,
                isEvent: args?.isEvent ?? false,
                isService: args?.isService ?? false,
                isProduct: args?.isProduct ?? false);

          case AppRoutes.notificationsScreenRoute:
            return const NotificationsScreen();

          case AppRoutes.bottomTabsScreenRoute:
            final args = routeSettings.arguments as BottomTabsScreen?;
            return BottomTabsScreen(
              currentIndex: args?.currentIndex ?? 0,
              wantedTabCurrentIndex: args?.wantedTabCurrentIndex ?? 0,
            );

          default:
            return Container();
        }
      },
    );
  }
}
