import 'package:flutter/material.dart';
import 'package:internship_project/core/common/app_appbar.dart';
import 'package:internship_project/core/common/app_navbar.dart';
import 'package:internship_project/core/config/dependency_injection/dependency_container.dart';
import 'package:internship_project/core/router/app_router.dart';
import 'package:internship_project/service/local/hive/db_service.dart';

/// A top view to manage our routes
class MainView extends StatefulWidget {
  ///
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  @override
  void initState() {
    // Add observer
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // Remove observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    /// When the app is detached
    if (state == AppLifecycleState.detached) {
      /// Set the isManuelSelected value to false
      await locator<LocalDatabaseService>().set<bool>(
        dbName: 'localDatabase',
        key: 'isManuelSelected',
        value: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

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
