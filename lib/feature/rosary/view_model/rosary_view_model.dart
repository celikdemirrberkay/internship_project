import 'package:flutter/material.dart';
import 'package:internship_project/repositories/local/shared_pref/db_service.dart';
import 'package:stacked/stacked.dart';

/// Rosary page ViewModel
class RosaryViewModel extends BaseViewModel {
  ///
  RosaryViewModel(this.db);

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
    await db.set(value, value);

    dhikrStringList.value.add(value);
    notifyListeners();
  }
}
