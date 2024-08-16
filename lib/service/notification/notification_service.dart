import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/core/constants/service_constant.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_logger.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Local Notification Service
class LocalNotificationService {
  ///
  LocalNotificationService(
    this._prayerTimesService,
    this._flutterLocalNotificationsPlugin,
  );

  /// Flutter Local Notifications Plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// Prayer Time Service
  final PrayerTimesService _prayerTimesService;

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
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotification,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
      );

      return await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    } catch (e) {
      return false;
    }
  }

  /// --------------------------------------------------------------------------
  /// Schedule Notification for Prayer Times
  Future<void> scheduleNotificationForPrayerTimes({
    required String title,
    required String body,
  }) async {
    // Initialize the time zone database
    tz.initializeTimeZones();

    /// Get prayer times for schedule notifications as Map<String,dynamic>
    final prayerResponse = await _prayerTimesService.getPrayerTimesAsMap(
      LocationService.cityName.value,
      LocationService.countryName.value,
    );

    /// If the response is success, schedule the notifications
    if (prayerResponse is SuccessState<Map<String, dynamic>>) {
      final prayerTimesWithDuplicates = prayerResponse.data!['data']['timings'] as Map<String, dynamic>;
      final prayerTimesWithoutDuplicates = prayerTimesWithDuplicates
        ..remove(LocalNotificationServiceConstants.sunset.value)
        ..remove(LocalNotificationServiceConstants.imsak.value)
        ..remove(LocalNotificationServiceConstants.midnight.value)
        ..remove(LocalNotificationServiceConstants.lastthird.value)
        ..remove(LocalNotificationServiceConstants.firstthird.value);

      var id = 0;

      /// For each prayer time, schedule the notification
      await Future.forEach(prayerTimesWithoutDuplicates.entries, (entry) async {
        final now = DateTime.now();

        /// Each prayer time (Fajr, Dhuhr, Asr, Maghrib, Isha)
        final prayerTime = DateTime.parse(
          '${DateFormat('yyyy-MM-dd').format(now)} ${entry.value as String}:15',
        );
        if (prayerTime.isAfter(now)) {
          /// Scheculed Notification Date Times
          final scheduledNotificationDateTime = prayerTime;

          /// Set Zoned Schedule
          await _setZonedSchedule(id, title, body, scheduledNotificationDateTime);

          /// Increment the id for each prayer time
          id++;
        }
      });

      /// Reset id to 0 at the end
      id = 0;
    }

    /// Log notification details
    await NotificationLogger.logNotificationDetails();
  }

  /// --------------------------------------------------------------------------
  /// Schedule Notification for Prayer Times on Background
  /// Fetch periodically prayer times and schedule notifications
  Future<void> scheduleNotificationForPrayerTimesOnBackground({
    required bool isNotificationOpen,
  }) async {
    if (isNotificationOpen) {
      /// Schedule notification for prayer times
      await scheduleNotificationForPrayerTimes(
        title: LocalNotificationServiceConstants.title.value,
        body: LocalNotificationServiceConstants.body.value,
      );
    }
  }

  /// --------------------------------------------------------------------------
  /// Set zonedSchedule for Notification
  Future<void> _setZonedSchedule(
    int id,
    String title,
    String body,
    DateTime scheduledNotificationDateTime,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      payload: '$scheduledNotificationDateTime',
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

  /// --------------------------------------------------------------------------
  /// Check Notification Permission
  Future<bool> checkNotificationPermission() async {
    try {
      // Android
      if (Platform.isAndroid) {
        final androidImplementation = _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        final areNotificationsEnabled = await androidImplementation?.areNotificationsEnabled() ?? false;
        return areNotificationsEnabled;
      }

      // iOS
      if (Platform.isIOS) {
        final iosPlugin = _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
        final areNotificationsEnabled = await iosPlugin?.checkPermissions();
        return areNotificationsEnabled?.isEnabled ?? false;
      }

      /// Default return value
      return false;
    } catch (e) {
      return false;
    }
  }

  /// --------------------------------------------------------------------------
  /// Cancel All Notifications
  Future<void> cancelPrayerTimeNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(
      0,
      tag: 'prayer-reminder',
    );
  }

  /// Set notification disable for first time
  /// Notifications of the application will only be active if the user opens it
  /// from the settings screen.
  Future<void> setNotificationDisableForFirstTime() async {
    final isNotificationOpen = await locator<LocalDatabaseService>().get<bool>(
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
    );
    if (isNotificationOpen is SuccessState<bool>) {
      if (isNotificationOpen.data == null) {
        await locator<LocalDatabaseService>().set<bool>(
          dbName: LocalDatabaseNames.notificationDB.value,
          key: LocalDatabaseKeys.isNotificationOpen.value,
          value: false,
        );
      }
    } else {
      await locator<LocalDatabaseService>().set<bool>(
        dbName: LocalDatabaseNames.notificationDB.value,
        key: LocalDatabaseKeys.isNotificationOpen.value,
        value: false,
      );
    }
  }
}
