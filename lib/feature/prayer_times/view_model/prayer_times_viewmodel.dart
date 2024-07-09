<<<<<<< HEAD
import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/god_names/god_names_service.dart';
import 'package:internship_project/repositories/model/god_names.dart';
import 'package:internship_project/repositories/model/times_response.dart';
=======
import 'package:either_dart/either.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/model/response.dart';
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
import 'package:internship_project/repositories/prayer_times/prayer_times_service.dart';
import 'package:stacked/stacked.dart';

///
class PrayerTimesViewmodel extends BaseViewModel {
  ///
<<<<<<< HEAD
  PrayerTimesViewmodel(
    this._prayerTimesService,
    this._godNamesService,
    this._context,
  ) {
    getPrayerTimes('Istanbul', 'Turkey');
    randomGodNameAndMeaning(_context);
=======
  PrayerTimesViewmodel(this._prayerTimesService) {
    getPrayerTimes('Istanbul', 'Turkey');
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
  }

  /// The service where we fetch prayer times
  final PrayerTimesService _prayerTimesService;

<<<<<<< HEAD
  /// The service where we fetch god names
  final GodNamesService _godNamesService;

  /// BuildContext
  final BuildContext _context;

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
  /// Prayer times
  Either<String, ApiData> _datas = Left(ExceptionMessage.errorOccured.message);

  /// Times getter
  Either<String, ApiData> get datas => _datas;

>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
  /// Get prayer times
  Future<void> getPrayerTimes(
    String city,
    String country,
  ) async {
<<<<<<< HEAD
    /// Fetch data from the api
    isPrayerTimesLoaded = true;
    rebuildUi();

    final response = await _prayerTimesService.getPrayerTimes(city, country);
    _datas = response;

    isPrayerTimesLoaded = false;
    rebuildUi();
  }

  /// Fetching data from json file and returning a list of GodNames
  Future<void> randomGodNameAndMeaning(BuildContext context) async {
    isGodNameLoaded = true;
    rebuildUi();

    final response = await _godNamesService.randomGodNameAndMeaning(context);
    _godNames = response;

    isGodNameLoaded = false;
    rebuildUi();
=======
    /// Set busy state to true
    setBusy(true);

    /// Fetch data from the api
    final response = await _prayerTimesService.getPrayerTimes(city, country);
    _datas = response;

    /// Set busy state to false
    setBusy(false);
>>>>>>> ccd2c88 (Home screen created with lottie animation (%70))
  }
}
