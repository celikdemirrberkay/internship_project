import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// Onboard view model
class OnboardViewModel extends BaseViewModel {
  /// Page index
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  /// Increment page index
  void incrementPageIndex() {
    if (_pageIndex != 2) {
      _pageIndex++;
    }
    notifyListeners();
  }

  /// Decrement page index
  void decrementPageIndex() {
    if (_pageIndex != 0) {
      _pageIndex--;
    }
    notifyListeners();
  }
}
