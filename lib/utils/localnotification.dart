// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:demo-project/utils/utils.dart';

class LocalNotificationService {
  // Instance of FlutterNotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        List<String> payloadList = details.payload
                ?.replaceAll('{', '')
                .replaceAll('}', '')
                .split(', ') ??
            [];

        // Create a Map from the key-value pairs
        Map<String, String> payloadMap = {};
        for (var item in payloadList) {
          var keyValue = item.split(': ');
          payloadMap[keyValue[0].trim()] = keyValue[1].trim();
        }

        // Extract the values from the map and parse integers if necessary
        List<String> payloadValues = [
          payloadMap['order_id'] ?? '',
          payloadMap['status'] ?? '',
          payloadMap['notificationId'] ?? ''
        ];
        Utils.handleNotification(payloadValues[1].toString(),
            payloadValues[0].toString(), context, payloadValues[2].toString());
      },
    );
  }

  Future<void> display(
      {required String body,
      required int id,
      String? payload,
      required String title}) async {
    // To display the notification in device
    try {
      const AndroidNotificationDetails notificationDetails =
          AndroidNotificationDetails(
        //android: AndroidNotificationDetails(
        'demo notify', // Change this to a unique ID for your channel
        'demo Notification',
        channelDescription: 'Hello App',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: notificationDetails);
      await _notificationsPlugin.show(id, title, body, platformChannelSpecifics,
          payload: payload);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    // return _notificationsPlugin.show(id, title, body, NotificationDetails(
    //   android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max)
    // ));
  }
}
