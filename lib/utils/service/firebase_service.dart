import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:side_hustle/base_widget/base_widget.dart';
import 'package:side_hustle/utils/constants.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  if (kDebugMode) {
    print("Handling a background message");
    print("_messaging onBackgroundMessage: ${message?.data}");
  }
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    if (message != null) {
      print("Background message data: ${message.data}");
    }
  } catch (e) {
    print("Error handling background message: $e");
  }
}

class FirebaseMessagingService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  IOSInitializationSettings? _initializationSettingsIOS;
  AndroidInitializationSettings? _initializationSettingsAndroid;
  AndroidNotificationDetails? _androidLocalNotificationDetails;
  AndroidNotificationChannel? androidNotificationChannel;
  static FirebaseMessagingService? _messagingService;
  NotificationDetails? _androidNotificationDetails;
  InitializationSettings? _initializationSettings;

  static FirebaseMessaging? _firebaseMessaging;

  FirebaseMessagingService._createInstance();

  factory FirebaseMessagingService() {
    // factory with constructor, return some value
    if (_messagingService == null) {
      _messagingService = FirebaseMessagingService
          ._createInstance(); // This is executed only once, singleton object

      _firebaseMessaging = _getMessagingService();
    }
    return _messagingService!;
  }

  static FirebaseMessaging _getMessagingService() {
    return _firebaseMessaging ??= FirebaseMessaging.instance;
  }

Future<String?> getToken() async {
  try {

    // Check if messaging instance exists
    _firebaseMessaging ??= FirebaseMessaging.instance;

    // Get token for both platforms
    final apnsToken = await _firebaseMessaging!.getAPNSToken();
    final token = await _firebaseMessaging?.getToken();
    if (kDebugMode) {
      print('FCM Token: $token');
    }
    return token;
  }
    // Get the token on iOS
    // if (Platform.isIOS) {
    //   final apnsToken = await _firebaseMessaging!.getAPNSToken();
    //   if (apnsToken != null) {
    //     final token = await _firebaseMessaging!.getToken();
    //     if (kDebugMode) {
    //       print('FCM Token: $token');
    //     }
    //     return token;
    //   }
    // }
    // else {
    //   // Get the token on Android
    //   final token = await _firebaseMessaging!.getToken();
    //   if (kDebugMode) {
    //     print('FCM Token: $token');
    //   }
    //   return token;

   catch (e) {
    //if (kDebugMode) {
      print('Error getting FCM token: $e');
    //}
    return null;
  }
}

  Future initializeNotificationSettings() async {
    NotificationSettings? settings =
        await _firebaseMessaging?.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings?.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings?.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }

    androidNotificationChannel = const AndroidNotificationChannel(
      Constants.NOTIFICATION_ID, // id
      Constants.NOTIFICATION_TITLE, // title
      description: Constants.NOTIFICATION_DESCRIPTION,
      importance: Importance.max,
    );
    //
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel!);
    await terminateTapNotification();
    //check if data comes from any link(app yaha sa start hogi)

    if (Platform.isIOS) {
      //configure local notification for ios
      await _initializeIosLocalNotificationSettings();
    } else {
      //configure local notification for android
      await _initializeAndroidLocalNotificationSettings();
    }
  }

  //This will work when the app is killed and notification comes and tap on that notification
  Future<void> terminateTapNotification() async {
    RemoteMessage? _terminatedMessage =
        await _firebaseMessaging?.getInitialMessage();
    try {
      if (_terminatedMessage != null && _terminatedMessage.data != null) {}
    } on Exception catch (e) {
      log("Temrinated Message Catch:${e}");
      log("Application launch when no notification");
    }
  }

  Future<void> _initializeIosLocalNotificationSettings() async {
    _initializationSettingsIOS = const IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    _initializationSettings =
        InitializationSettings(iOS: _initializationSettingsIOS);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings!,
        onSelectNotification: onTapLocalNotification);
  }

  Future<void> _initializeAndroidLocalNotificationSettings() async {
    _initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    _initializationSettings = InitializationSettings(
      android: _initializationSettingsAndroid,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _androidLocalNotificationDetails = const AndroidNotificationDetails(
        Constants.LOCAL_NOTIFICATION_ID, Constants.LOCAL_NOTIFICATION_TITLE,
        channelDescription: Constants.LOCAL_NOTIFICATION_DESCRIPTION,
        importance: Importance.max,
        priority: Priority.high);
    _androidNotificationDetails =
        NotificationDetails(android: _androidLocalNotificationDetails);

    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings!,
        onSelectNotification: onTapLocalNotification);
  }

  //on tap local notification
  void onTapLocalNotification(String? payload) async {}

  //This will execute when the app is open and in foreground
  void foregroundNotification() {
    //To registered firebase messaging listener only once
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      log("Message ForeGround:${message?.data.toString()}");
      log("Notification:${message?.notification?.title}");
      if (message != null) {}
      try {
        _showLocalNotification(
          localNotificationId: DateTime.now().hour +
              DateTime.now().minute +
              DateTime.now().second,
          notificationData: message?.data,
          messageTitle: message?.notification?.title,
          messageBody: message?.notification?.body,
        );
      } catch (error) {
        log("error");
      }
    });
  }

  void _showLocalNotification(
      {int? localNotificationId,
      Map<String, dynamic>? notificationData,
      String? messageTitle,
      String? messageBody}) async {
    if (notificationData != null) {
      log("Notification Data:${notificationData}");

      //agar same friend ki chat ha to phir local notification nhi aigi

      await _flutterLocalNotificationsPlugin.show(
          localNotificationId ?? 0,
          notificationData["title"] ?? messageTitle,
          notificationData["body"] ?? messageBody,
          _androidNotificationDetails,
          payload: jsonEncode(notificationData));
    }
  }

  // This will execute when the app is in background but not killed and tap on that notification
  void backgroundTapNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      RemoteMessage? terminatedMessage =
          await _firebaseMessaging?.getInitialMessage();
      if (kDebugMode) {
        print("clicked background message ${message?.data['type']}");
      }

      /// Type == New Session
      print(
          "Notification Type:${message?.data['notification_type']}, NotificationTypes:\$NotificationTypes.new_session.name");
    });
  }

  void terminateNotification() async {
    RemoteMessage? msg = await _firebaseMessaging?.getInitialMessage();
    // msg.data
  }
}
