import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';

/// WorkManager is a plugin that allows you to schedule background work on Android and iOS.
class BackgroundService {
  /// Constructor
  BackgroundService();

  /// --------------------------------------------------------------------------
  /// Configure Background Service
  static Future<void> configureAndStartBackgroundService() async {
    await locator<FlutterBackgroundService>().startService();
    await locator<FlutterBackgroundService>().configure(
      iosConfiguration: IosConfiguration(
        onBackground: _iosBackground,
        onForeground: _onStart,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        isForegroundMode: true,
        foregroundServiceNotificationId: 90,
      ),
    );
  }

  /// --------------------------------------------------------------------------
  /// On Start foreground
  @pragma('vm:entry-point')
  static Future<void> _onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    // Call startForeground with a notification
    service.invoke('foregroundServiceStarted');

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    Timer.periodic(const Duration(hours: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          await checkAndShowNotification();
        }
      }
    });
  }

  /// --------------------------------------------------------------------------
  /// iOS Background
  @pragma('vm:entry-point')
  static Future<bool> _iosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  /// --------------------------------------------------------------------------
  /// Show Notification
  //TODO : Bad usage. Must refactor this method.
  static Future<void> checkAndShowNotification() async {
    await Hive.initFlutter();
    final localDatabaseService = LocalDatabaseService();
    final notificationService = LocalNotificationService(
      PrayerTimesService(Dio()),
      FlutterLocalNotificationsPlugin(),
    );

    final isNotifOpen = await localDatabaseService.get<bool>(
      dbName: 'notificationDatabase',
      key: 'isNotificationOpen',
    );

    await notificationService.scheduleNotificationForPrayerTimesOnBackground(
      isNotificationOpen: isNotifOpen.data ?? false,
    );
  }
}
