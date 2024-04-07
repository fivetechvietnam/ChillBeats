import 'dart:math';

import 'package:chillbeats/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  Future<NotificationDetails> notificationDetails(
      String channelId, String channelName) async {
    // Fill in appropriate values for channelId and channelName
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId, // Change this to a unique value for your app
      channelName, // Change this to a unique value for your app
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      threadIdentifier: channelId,
    );
    final details = await notificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      behaviorSubject.add(details.notificationResponse.toString());
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    return platformChannelSpecifics;
  }

// Function to generate a unique notification ID
  int generateNotificationId() {
    // Use current timestamp as the base
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    // Generate a random number between 0 and 999999 to add variability
    int random = Random().nextInt(1000000);

    // Combine timestamp and random number to create a unique ID
    int notificationId = timestamp + random;

    return notificationId;
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    String channelId = id != 0 ? "$id" : "${generateNotificationId()}";
    String channelName = "local_notification";
    final platformChannelSpecifics =
        await notificationDetails(channelId, channelName);

    notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {}
}
