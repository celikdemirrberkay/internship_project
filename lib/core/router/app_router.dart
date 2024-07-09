import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_project/feature/main_view.dart';
import 'package:internship_project/feature/prayer_times/view/prayer_times_view.dart';
import 'package:internship_project/feature/rosary/view/rosary_view.dart';
import 'package:internship_project/feature/settings/view/settings_view.dart';

/// We edit the route logic in our application from here
class AppRouter {
  ///
  static final GoRouter router = GoRouter(
    routes: [
      /// Main route
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(child: MainView()),
      ),
    ],
  );

  /// All views
  static const allViewsForBottomNavBar = [
    PrayerTimesView(),
    RosaryView(),
    SettingsView(),
  ];

  /// Initial index for the bottom navigation bar
  static ValueNotifier<int> initialIndex = ValueNotifier(0);
}
