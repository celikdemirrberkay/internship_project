import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Log class for notification.
/// It was created to better follow the code we wrote in debug mode.
class NotificationLogger {
  /// Log notification details
  static Future<void> logNotificationDetails() async {
    if (kDebugMode) {
      // iOS
      if (Platform.isIOS) {
        final iosPlugin = FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
        final pendingNotif = await iosPlugin?.pendingNotificationRequests();
        print('${pendingNotif?.length} notifications pending');
        for (PendingNotificationRequest notification in pendingNotif ?? []) {
          print('--------------------${notification.id}-------------------------');
          print('Notification title: ${notification.title}');
          print('Notification body: ${notification.body}');
          print('Notification payload: ${notification.payload}');
        }
      }

      // Android
      if (Platform.isAndroid) {
        final androidPlugin = FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        final pendingNotif = await androidPlugin?.pendingNotificationRequests();
        print('${pendingNotif?.length} notifications pending');
        for (PendingNotificationRequest notification in pendingNotif ?? []) {
          print('--------------------${notification.id}-------------------------');
          print('Notification title: ${notification.title}');
          print('Notification body: ${notification.body}');
          print('Notification payload: ${notification.payload}');
        }
      }
    }
  }
}
