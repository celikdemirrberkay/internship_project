import 'package:flutter/material.dart';
import 'package:internship_project/repositories/local/shared_pref/db_service.dart';
import 'package:stacked/stacked.dart';

/// Rosary page ViewModel
class RosaryViewModel extends BaseViewModel {
  ///
  RosaryViewModel(this.db) {
    getDhikrList().then(
      (value) {
        dhikrStringList.value.addAll(value);
      },
    );
  }

  /// Database service instance
  final LocalDatabaseService db;

  /// Text controller for dhikr input
  final TextEditingController dhikrInputController = TextEditingController();

  /// Rosary count
  final ValueNotifier<int> _rosaryCount = ValueNotifier(0);
  ValueNotifier<int> get rosaryCount => _rosaryCount;

  /// Dhikr list
  ValueNotifier<List<String>> dhikrStringList = ValueNotifier([
    'Subhanallah',
    'Elhamdulillah',
    'Allahu ekber',
    'La ilahe illallah',
  ]);

  /// Increase rosary count
  void increaseRosaryCount() {
    _rosaryCount.value++;
  }

  /// Reset rosary count
  void resetRosaryCount() {
    _rosaryCount.value = 0;
  }

  /// Add dhikr to list
  Future<void> addDhikrToList(String value) async {
    final dbList = await db.get<List<String>>(
      dbName: _DbServiceEnum.databaseService.name,
      key: _DbServiceEnum.dhikrList.name,
    );

    if (dbList.isRight) {
      dbList.right.add(value);
      await db.set(
        dbName: _DbServiceEnum.databaseService.name,
        key: _DbServiceEnum.dhikrList.name,
        value: dbList.right,
      );
    } else {
      print(dbList.left);
    }

    notifyListeners();
  }

  /// Get dhikr list
  Future<List<String>> getDhikrList() async {
    /// Get dhikr list from local database
    final dbList = await db.get<List<String>>(
      dbName: _DbServiceEnum.databaseService.name,
      key: _DbServiceEnum.dhikrList.name,
    );

    /// Return dhikr list
    if (dbList.isRight) {
      return dbList.right;
    } else {
      return [];
    }
  }
}

/// Database service enum
enum _DbServiceEnum {
  /// Database service
  databaseService,

  /// Dhikr
  dhikrList,
}
