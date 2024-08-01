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
        final areNotificationsEnabled = await iosPlugin?.pendingNotificationRequests();
        print(areNotificationsEnabled?.length ?? 'null');
      }
      if (Platform.isAndroid) {
        final androidPlugin = FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        final areNotificationsEnabled = await androidPlugin?.pendingNotificationRequests();
        print(areNotificationsEnabled?.first.payload);
      }
    }
  }
}
