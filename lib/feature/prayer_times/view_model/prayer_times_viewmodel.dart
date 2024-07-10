import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/local/god_names/god_names_service.dart';
import 'package:internship_project/repositories/model/god_names.dart';
import 'package:internship_project/repositories/model/times_response.dart';
import 'package:internship_project/repositories/remote/prayer_times/prayer_times_service.dart';
import 'package:stacked/stacked.dart';

///
class PrayerTimesViewmodel extends BaseViewModel {
  ///
  PrayerTimesViewmodel(
    this._prayerTimesService,
    this._godNamesService,
    this._context,
  ) {
    getPrayerTimes('istanbul', 'Turkey');
    randomGodNameAndMeaning(_context);
  }

  /// The service where we fetch prayer times
  final PrayerTimesService _prayerTimesService;

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

  /// Get prayer times
  Future<void> getPrayerTimes(
    String city,
    String country,
  ) async {
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
  }
}
