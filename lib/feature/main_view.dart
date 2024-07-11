import 'package:flutter/material.dart';
import 'package:internship_project/core/common/app_appbar.dart';
import 'package:internship_project/core/common/app_navbar.dart';
import 'package:internship_project/core/router/app_router.dart';

/// A top view to manage our routes
class MainView extends StatefulWidget {
  ///
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      /// BottomNavigationBar and Appbar
      bottomNavigationBar: const AppNavbar(),
      appBar: const Appbarforapp(),

      /// ValueListenableBuilder is used to listen to changes in the initialIndex value
      /// and rebuild the widget tree when the value changes.
      body: ValueListenableBuilder(
        valueListenable: AppRouter.initialIndex,
        builder: (context, value, child) => SafeArea(
          /// IndexedStack is used to show only one child at a time
          child: IndexedStack(
            index: AppRouter.initialIndex.value,
            children: AppRouter.allViewsForBottomNavBar,
          ),
        ),
      ),
    );
  }
}
