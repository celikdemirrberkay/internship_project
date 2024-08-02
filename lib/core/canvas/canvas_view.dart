import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../common/app_elevated_button.dart';
import '../config/dependency_injection/dependency_container.dart';
import '../../feature/settings/view_model/settings_view_model.dart';

/// Test Template
class CanvasView extends StatefulWidget {
  ///
  const CanvasView({super.key});

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 200,
              child: Center(
                child: AppElevatedButton(
                  text: 'Notif set',
                  color: Colors.black,
                  onPressed: () async {
                    await SettingsViewModel(
                      locator(),
                      locator(),
                      locator(),
                    ).updateNotificationStatus(
                      value: true,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 200,
              child: Center(
                child: AppElevatedButton(
                  text: 'Check notif',
                  color: Colors.red,
                  onPressed: () async {
                    // iOS
                    if (Platform.isIOS) {
                      final iosPlugin = FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
                      final areNotificationsEnabled = await iosPlugin?.pendingNotificationRequests();
                      print(areNotificationsEnabled?.length ?? 'null');
                    }
                    if (Platform.isAndroid) {
                      final androidPlugin = FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
                      final areNotificationsEnabled = await androidPlugin?.pendingNotificationRequests();
                      print(areNotificationsEnabled?.length ?? 'null');
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
