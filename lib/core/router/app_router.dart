import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_project/feature/compass/view/compass_view.dart';
import 'package:internship_project/feature/main_view.dart';
import 'package:internship_project/feature/onboard/view/onboard_view.dart';
import 'package:internship_project/feature/prayer_times/view/prayer_times_view.dart';
import 'package:internship_project/feature/rosary/view/rosary_view.dart';

/// We edit the route logic in our application from here
class AppRouter {
  /// GoRouter instance
  static GoRouter router({required bool isOnboardDone}) => GoRouter(
        initialLocation: isOnboardDone ? '/OnboardView' : '/OnboardView',
        routes: [
          /// Main route
          GoRoute(
            path: '/MainView',
            pageBuilder: (context, state) => const MaterialPage(child: MainView()),
          ),

          /// Onboard route
          GoRoute(
            path: '/OnboardView',
            pageBuilder: (context, state) => const MaterialPage(child: OnboardView()),
          ),
        ],
      );

  /// All views
  static List<Widget> allViewsForBottomNavBar = [
    const PrayerTimesView(),
    const RosaryView(),
    const CompassView(),
  ];

  /// Initial index for the bottom navigation bar
  static ValueNotifier<int> initialIndex = ValueNotifier(0);
}
