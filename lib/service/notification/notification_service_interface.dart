import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Interface for Notification Service
abstract class INotificationService {
  ///
  INotificationService();

  /// Show Notification
  Future<void> showNotification({
    required String title,
    required String body,
    required int id,
    required String payload,
  });
}