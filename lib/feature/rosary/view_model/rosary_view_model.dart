import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/service&repository/local/hive/db_service.dart';
import 'package:stacked/stacked.dart';

/// Rosary page ViewModel
class RosaryViewModel extends BaseViewModel {
  /// Constructor
  RosaryViewModel(this.db) {
    /// First thing first, get dhikr list from local database
    /// and add to dhikrStringList
    getDhikrList().then(
      (value) {
        dhikrStringList.value.addAll(value);
        notifyListeners();
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
  /// It's a static list for default dhikr values
  ValueNotifier<List<String>> dhikrStringList = ValueNotifier([]);

  /// -------------------------------------------------------------
  /// Increase rosary count
  void increaseRosaryCount() {
    _rosaryCount.value++;
  }

  /// -------------------------------------------------------------
  /// Reset rosary count
  void resetRosaryCount() {
    _rosaryCount.value = 0;
  }

  /// -------------------------------------------------------------
  /// Add dhikr to list
  Future<void> addDhikrToList(String value) async {
    /// Get dhikr list from local database
    final dbList = await db.get<List<String>>(
      dbName: _LocalDbServiceEnum.databaseService.name,
      key: _LocalDbServiceEnum.dhikrList.name,
    );

    /// If db get operation success
    if (dbList.isRight) {
      /// Add dhikr to list
      dbList.right.add(value);

      /// Set new dhikr list to local database
      final response = await db.set(
        dbName: _LocalDbServiceEnum.databaseService.name,
        key: _LocalDbServiceEnum.dhikrList.name,
        value: dbList.right,
      );

      /// Add dhikr to static list and update ui for listeners
      dhikrStringList.value.clear();
      dhikrStringList.value.addAll(dbList.right);
      notifyListeners();

      /// Show success toast message
      await Fluttertoast.showToast(msg: response.right);
    } else {
      /// Show error toast message if db get operation failed
      await Fluttertoast.showToast(msg: ExceptionMessage.errorOccured.message);
    }
  }

  /// -------------------------------------------------------------
  /// Get dhikr list from local database
  Future<List<String>> getDhikrList() async {
    /// Get dhikr list from local database
    final dbList = await db.get<List<String>>(
      dbName: _LocalDbServiceEnum.databaseService.name,
      key: _LocalDbServiceEnum.dhikrList.name,
    );

    /// Return dhikr list
    if (dbList.isRight) {
      /// If db get operation success return dhikr list
      return dbList.right;
    } else {
      /// If db get operation failed return empty list
      /// and show error toast message
      await Fluttertoast.showToast(msg: ExceptionMessage.errorOccured.message);
      return [];
    }
  }

  /// -------------------------------------------------------------
  /// Remove dhikr from list
  Future<void> removeDhikrFromList(String name) async {
    // !!First get then remove then set!!
    /// Get dhikr list from local database
    final dhikrList = await db.get<List<String>>(
      dbName: _LocalDbServiceEnum.databaseService.name,
      key: _LocalDbServiceEnum.dhikrList.name,
    );

    /// If db get operation success
    if (dhikrList.isRight) {
      /// Remove dhikr from list
      dhikrList.right.remove(name);

      /// Set new dhikr list to local database
      await db.set(
        dbName: _LocalDbServiceEnum.databaseService.name,
        key: _LocalDbServiceEnum.dhikrList.name,
        value: dhikrList.right,
      );

      /// Remove dhikr from static list and update ui for listeners
      dhikrStringList.value.remove(name);
      notifyListeners();

      /// Show success toast message
      await Fluttertoast.showToast(msg: 'Başarıyla silindi');
    }
  }
}

/// Database service enum
enum _LocalDbServiceEnum {
  /// Database service
  databaseService,

  /// Dhikr
  dhikrList,
}
