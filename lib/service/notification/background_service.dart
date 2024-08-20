import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
import 'package:internship_project/service/notification/notification_service.dart';
import 'package:internship_project/service/remote/prayer_times/prayer_times_service.dart';

/// WorkManager is a plugin that allows you to schedule
/// background work on Android and iOS.
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
        autoStart: true,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        isForegroundMode: true,
        autoStart: true,
        autoStartOnBoot: true,
        foregroundServiceNotificationId: 90,
        initialNotificationContent: 'Namaz vakitleri bildirimleri açık',
        initialNotificationTitle: 'Namaz Vakti',
      ),
    );
  }

  /// --------------------------------------------------------------------------
  /// On Start foreground
  @pragma('vm:entry-point')
  static Future<void> _onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on(_OnStartEvent.setAsForeground.name).listen((event) {
        service.setAsForegroundService();
      });

      service.on(_OnStartEvent.setAsBackground.name).listen((event) {
        service.setAsBackgroundService();
      });
    }

    /// Call startForeground with a notification
    service.invoke(_OnStartEvent.foregroundServiceStarted.name);

    /// Listen for stopService event
    service.on(_OnStartEvent.stopService.name).listen((event) {
      service.stopSelf();
    });

    /// Check and show notification every 5 hours
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
      dbName: LocalDatabaseNames.notificationDB.value,
      key: LocalDatabaseKeys.isNotificationOpen.value,
    );

    final remainingTime = await localDatabaseService.get<int>(
      dbName: LocalDatabaseNames.remainingTimeDB.value,
      key: LocalDatabaseKeys.isTimeRemainingActive.value,
    );

    if (remainingTime is SuccessState<bool> && remainingTime.data != 0) {
      await notificationService.scheduleNotificationForPrayerTimesMinutesRemainingOnBackground(
        isNotificationOpen: isNotifOpen.data ?? false,
        minutesRemaining: remainingTime.data ?? 0,
      );
      return;
    } else {
      await notificationService.scheduleNotificationForPrayerTimesOnBackground(
        isNotificationOpen: isNotifOpen.data ?? false,
      );
    }
  }
}

/// Holds the events that will be triggered when the service starts.
enum _OnStartEvent {
  /// Set as foreground
  setAsForeground,

  /// Set as background
  setAsBackground,

  /// Stop service
  stopService,

  /// Foreground service started
  foregroundServiceStarted,
}
