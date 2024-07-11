import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// Rosary page ViewModel
class RosaryViewModel extends BaseViewModel {
  /// Rosary count
  ValueNotifier<int> _rosaryCount = ValueNotifier(0);
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
}
