import 'package:stacked/stacked.dart';

/// Rosary page ViewModel
class RosaryViewModel extends BaseViewModel {
  /// Rosary count
  int _rosaryCount = 0;
  int get rosaryCount => _rosaryCount;

  /// Increase rosary count
  void increaseRosaryCount() {
    _rosaryCount++;
    notifyListeners();
  }

  /// Reset rosary count
  void resetRosaryCount() {
    _rosaryCount = 0;
    notifyListeners();
  }
}
