import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_project/core/canvas/canvas_view.dart';
import 'package:internship_project/feature/compass/view/qibla_compass_view.dart';
import 'package:internship_project/feature/main_view.dart';
import 'package:internship_project/feature/onboard/view/onboard_view.dart';
import 'package:internship_project/feature/prayer_times/view/prayer_times_view.dart';
import 'package:internship_project/feature/rosary/view/rosary_view.dart';
import 'package:internship_project/feature/settings/view/settings_view.dart';
import 'package:internship_project/feature/splash/view/splash_view.dart';

/// We edit the route logic in our application from here
class AppRouter {
  /// GoRouter instance
  static GoRouter router() => GoRouter(
        initialLocation: '/CanvasView',
        routes: [
          /// Canvas route
          GoRoute(
            path: '/CanvasView',
            name: 'canvas',
            pageBuilder: (context, state) => const MaterialPage(child: CanvasView()),
          ),

          /// Splash route
          GoRoute(
            path: '/SplashView',
            name: 'splash',
            pageBuilder: (context, state) => const MaterialPage(child: SplashView()),
          ),

          /// Onboard route
          GoRoute(
            path: '/OnboardView',
            name: 'onboard',
            pageBuilder: (context, state) => const MaterialPage(child: OnboardView()),
          ),

          /// Main route
          GoRoute(
            path: '/MainView',
            name: 'main',
            pageBuilder: (context, state) => const MaterialPage(child: MainView()),
          ),

          /// Settings route
          GoRoute(
            path: '/SettingsView',
            name: 'settings',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const SettingsView(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );

                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              },
            ),
          ),
        ],
      );

  /// All views
  static List<Widget> allViewsForBottomNavBar = [
    const PrayerTimesView(),
    const RosaryView(),
    const QiblahCompassView(),
  ];

  /// Initial index for the bottom navigation bar
  static final ValueNotifier<int> initialIndex = ValueNotifier(0);
}
