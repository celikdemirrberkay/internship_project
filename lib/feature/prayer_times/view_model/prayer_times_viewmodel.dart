<<<<<<< HEAD
<<<<<<< HEAD
import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/local/god_names/god_names_service.dart';
import 'package:internship_project/repositories/model/god_names.dart';
import 'package:internship_project/repositories/model/times_response.dart';
<<<<<<< HEAD
=======
=======
import 'dart:math';
>>>>>>> 47ff30c (View and view model structure change a bit)
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/core/exception/exception_message.dart';
<<<<<<< HEAD
import 'package:internship_project/repositories/model/response.dart';
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
=======
import 'package:internship_project/repositories/god_names/god_names_service.dart';
import 'package:internship_project/repositories/model/god_names.dart';
import 'package:internship_project/repositories/model/times_response.dart';
>>>>>>> 47ff30c (View and view model structure change a bit)
import 'package:internship_project/repositories/prayer_times/prayer_times_service.dart';
=======
import 'package:internship_project/repositories/remote/prayer_times/prayer_times_service.dart';
>>>>>>> 8196ae1 (Bottom navbar refactoring)
import 'package:stacked/stacked.dart';

///
class PrayerTimesViewmodel extends BaseViewModel {
  ///
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 47ff30c (View and view model structure change a bit)
  PrayerTimesViewmodel(
    this._prayerTimesService,
    this._godNamesService,
    this._context,
  ) {
<<<<<<< HEAD
<<<<<<< HEAD
    getPrayerTimes('Istanbul', 'Turkey');
=======
    getPrayerTimes('istanbul', 'Turkey');
>>>>>>> 8196ae1 (Bottom navbar refactoring)
    randomGodNameAndMeaning(_context);
=======
  PrayerTimesViewmodel(this._prayerTimesService) {
    getPrayerTimes('Istanbul', 'Turkey');
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
=======
    getPrayerTimes('Istanbul', 'Turkey');
    randomGodNameAndMeaning(_context);
>>>>>>> 47ff30c (View and view model structure change a bit)
  }

  /// The service where we fetch prayer times
  final PrayerTimesService _prayerTimesService;

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 47ff30c (View and view model structure change a bit)
  /// The service where we fetch god names
  final GodNamesService _godNamesService;

  /// BuildContext
  final BuildContext _context;

<<<<<<< HEAD
  /// Prayer times
  Either<String, ApiData> _datas = Left(ExceptionMessage.errorOccured.message);
  Either<String, ApiData> get datas => _datas;

  /// God names
  Either<String, List<GodNames>> _godNames = Left(ExceptionMessage.errorOccured.message);
  Either<String, List<GodNames>> get godNames => _godNames;

  /// Random integer for random god name
  int randomInt = Random().nextInt(99);

  /// Booleans for loading states
  bool isGodNameLoaded = false;
  bool isPrayerTimesLoaded = false;

=======
=======
>>>>>>> 47ff30c (View and view model structure change a bit)
  /// Prayer times
  Either<String, ApiData> _datas = Left(ExceptionMessage.errorOccured.message);
  Either<String, ApiData> get datas => _datas;

<<<<<<< HEAD
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
=======
  /// God names
  Either<String, List<GodNames>> _godNames = Left(ExceptionMessage.errorOccured.message);
  Either<String, List<GodNames>> get godNames => _godNames;

  /// Random integer for random god name
  int randomInt = Random().nextInt(99);

  /// Booleans for loading states
  bool isGodNameLoaded = false;
  bool isPrayerTimesLoaded = false;

>>>>>>> 47ff30c (View and view model structure change a bit)
  /// Get prayer times
  Future<void> getPrayerTimes(
    String city,
    String country,
  ) async {
<<<<<<< HEAD
<<<<<<< HEAD
    /// Fetch data from the api
    isPrayerTimesLoaded = true;
    notifyListeners();

    final response = await _prayerTimesService.getPrayerTimes(city, country);
    _datas = response;

    isPrayerTimesLoaded = false;
    notifyListeners();
  }

  /// Fetching data from json file and returning a list of GodNames
  Future<void> randomGodNameAndMeaning(BuildContext context) async {
    isGodNameLoaded = true;
    notifyListeners();

    final response = await _godNamesService.randomGodNameAndMeaning(context);
    _godNames = response;

    isGodNameLoaded = false;
<<<<<<< HEAD
    rebuildUi();
<<<<<<< HEAD
=======
    /// Set busy state to true
    setBusy(true);

=======
>>>>>>> 47ff30c (View and view model structure change a bit)
    /// Fetch data from the api
    isPrayerTimesLoaded = true;
    rebuildUi();

    final response = await _prayerTimesService.getPrayerTimes(city, country);
    _datas = response;

<<<<<<< HEAD
    /// Set busy state to false
    setBusy(false);
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
=======
    isPrayerTimesLoaded = false;
    rebuildUi();
  }

  /// Fetching data from json file and returning a list of GodNames
  Future<void> randomGodNameAndMeaning(BuildContext context) async {
    final response = await _godNamesService.randomGodNameAndMeaning(context);
    _godNames = response;
>>>>>>> 47ff30c (View and view model structure change a bit)
=======
>>>>>>> 0a4e4a0 (Realtime clock added.)
=======
    notifyListeners();
>>>>>>> 580ddc9 (Rosary development continued)
  }
}
