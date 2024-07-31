import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Local Notification Service
class LocalNotificationService {
  /// Flutter Local Notifications Plugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Prayer Time Service
  final PrayerTimesService _prayerTimesService = PrayerTimesService(locator());

  /// --------------------------------------------------------------------------
  /// On Did Receive Notification
  static Future<void> onDidReceiveNotification(
    NotificationResponse notificationResponse,
  ) async {}

  /// --------------------------------------------------------------------------
  /// Initialize the Notification Service
  Future<bool?> initNotifications() async {
    try {
      const androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
      const iOSInitializationSettings = DarwinInitializationSettings();

      const initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iOSInitializationSettings,
      );
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotification,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
      );

      return await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    } catch (e) {
      return false;
    }
  }

  /// --------------------------------------------------------------------------
  /// Schedule Notification for Prayer Times
  Future<void> scheduleNotificationForPrayerTimes({
    required int id,
    required String title,
    required String body,
  }) async {
    // Initialize the time zone database
    tz.initializeTimeZones();

    /// Get prayer times for schedule notifications as Map<String,dynamic>
    final prayerResponse = await _prayerTimesService.getPrayerTimesForScheduleNotifications(
      LocationService.cityName.value,
      LocationService.countryName.value,
    );

    /// If the response is success, schedule the notifications
    if (prayerResponse is SuccessState<Map<String, dynamic>>) {
      final prayerTimes = prayerResponse.data!['data']['timings'] as Map<String, dynamic>;

      /// For each prayer time, schedule the notification
      // ignore: cascade_invocations
      prayerTimes.forEach((key, value) async {
        /// Each prayer time (Fajr, Dhuhr, Asr, Maghrib, Isha)
        final prayerTime = DateTime.parse(
          '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${value as String}:15',
        );

        if (prayerTime.isAfter(DateTime.now())) {
          final scheduledNotificationDateTime = prayerTime;
          await flutterLocalNotificationsPlugin.zonedSchedule(
            id,
            title,
            body,
            payload: 'prayer-times',
            tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
            const NotificationDetails(
              iOS: DarwinNotificationDetails(),
              android: AndroidNotificationDetails(
                'reminder_channel',
                'Reminder Channel',
                tag: 'prayer-reminder',
                importance: Importance.high,
                priority: Priority.high,
              ),
            ),
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.dateAndTime,
            androidScheduleMode: AndroidScheduleMode.exact,
          );
        }
      });
    }
  }

  /// --------------------------------------------------------------------------
  /// Check Notification Permission
  Future<bool> checkNotificationPermission() async {
    try {
      // Android
      if (Platform.isAndroid) {
        final androidImplementation = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        final areNotificationsEnabled = await androidImplementation?.areNotificationsEnabled() ?? false;

        if (areNotificationsEnabled) {
          return true;
        } else {
          return false;
        }
      }

      // iOS
      if (Platform.isIOS) {
        final iosPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
        final areNotificationsEnabled = await iosPlugin?.checkPermissions();
        return areNotificationsEnabled?.isEnabled ?? false;
      }

      /// If the platform is not Android or iOS, return false
      return false;
    } catch (e) {
      return false;
    }
  }

  /// --------------------------------------------------------------------------
  /// Check Notification Permission
  Future<void> requestNotificationPermission() async {
    try {
      // Android
      if (Platform.isAndroid) {
        final androidImplementation = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        await androidImplementation?.requestNotificationsPermission();
      }

      // iOS
      if (Platform.isIOS) {
        final iosPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
        await iosPlugin?.requestPermissions();
      }
    } catch (e) {
      return;
    }
  }

  /// --------------------------------------------------------------------------
  /// Cancel All Notifications
  Future<void> cancelPrayerTimeNotification() async {
    await flutterLocalNotificationsPlugin.cancel(
      0,
      tag: 'prayer-reminder',
    );
  }
}
