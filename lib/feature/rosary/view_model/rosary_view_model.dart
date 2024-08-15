import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/constants/local_database_constants.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/core/exception/exception_util.dart';
import 'package:internship_project/service/local/hive/db_service.dart';
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
      dbName: LocalDatabaseNames.rosaryDB.value,
      key: LocalDatabaseKeys.dhikrList.value,
    );

    /// If db get operation success
    if (dbList is SuccessState<List<String>>) {
      /// Add dhikr to list
      dbList.data!.add(value);

      /// Set new dhikr list to local database
      final response = await db.set(
        dbName: LocalDatabaseNames.rosaryDB.value,
        key: LocalDatabaseKeys.dhikrList.value,
        value: dbList.data!,
      );

      /// Add dhikr to static list and update ui for listeners
      dhikrStringList.value.clear();
      dhikrStringList.value.addAll(dbList.data!);
      notifyListeners();

      /// Show success toast message
      await Fluttertoast.showToast(msg: response.data!);
    } else {
      /// Show error toast message if db get operation failed
      await Fluttertoast.showToast(
        msg: ExceptionUtil.getExceptionMessage(dbList.exceptionType!),
      );
    }
  }

  /// -------------------------------------------------------------
  /// Get dhikr list from local database
  Future<List<String>> getDhikrList() async {
    /// Get dhikr list from local database
    final dbList = await db.get<List<String>>(
      dbName: LocalDatabaseNames.rosaryDB.value,
      key: LocalDatabaseKeys.dhikrList.value,
    );

    /// Return dhikr list
    if (dbList is SuccessState<List<String>>) {
      /// If db get operation success return dhikr list
      return dbList.data!;
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
    /// Get dhikr list from local database
    final dhikrList = await db.get<List<String>>(
      dbName: LocalDatabaseNames.rosaryDB.value,
      key: LocalDatabaseKeys.dhikrList.value,
    );

    /// Remove dhikr from list
    dhikrList.data!.remove(name);

    /// Set new dhikr list to local database
    await db.set(
      dbName: LocalDatabaseNames.rosaryDB.value,
      key: LocalDatabaseKeys.dhikrList.value,
      value: dhikrList.data,
    );

    /// Remove dhikr from static list and update ui for listeners
    dhikrStringList.value.remove(name);
    notifyListeners();

    /// Show success toast message
    await Fluttertoast.showToast(msg: 'Başarıyla silindi');
  }
}
