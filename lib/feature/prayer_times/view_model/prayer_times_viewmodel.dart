import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/model/ayah.dart';
import 'package:internship_project/model/god_names.dart';
import 'package:internship_project/model/times_response.dart';
import 'package:internship_project/service&repository/local/god_names/god_names_service.dart';
import 'package:internship_project/service&repository/remote/ayah/ayah_service.dart';
import 'package:internship_project/service&repository/remote/location/location_service.dart';
import 'package:internship_project/service&repository/remote/prayer_times/prayer_times_service.dart';
import 'package:stacked/stacked.dart';

///
class PrayerTimesViewmodel extends BaseViewModel {
  ///
  PrayerTimesViewmodel(
    this._prayerTimesService,
    this._godNamesService,
    this._ayahService,
    this._context,
  ) {
    getSpecificAyah();
    randomGodNameAndMeaning(_context);

    /// Fetching data from the API's beginning
    /// First, we get the city name then the country name
    /// Then we fetch the prayer times with country and city name we got

    getPrayerTimes(
      city: LocationService.cityName,
      country: LocationService.countryName,
    );
  }

  /// --------------------------------------------------------------------------
  /// The service where we fetch prayer times
  final PrayerTimesService _prayerTimesService;

  /// --------------------------------------------------------------------------
  /// The service where we fetch god names
  final GodNamesService _godNamesService;

  /// --------------------------------------------------------------------------
  /// The service where we fetch specific Ayah
  final AyahService _ayahService;

  /// --------------------------------------------------------------------------
  /// BuildContext
  /// Required for fetching data from json file
  final BuildContext _context;

  /// --------------------------------------------------------------------------
  /// Prayer times
  Either<String, PrayerApiData> _datas = Left(ExceptionMessage.errorOccured.message);
  Either<String, PrayerApiData> get datas => _datas;

  /// --------------------------------------------------------------------------
  /// God names
  Either<String, List<GodNames>> _godNames = Left(ExceptionMessage.errorOccured.message);
  Either<String, List<GodNames>> get godNames => _godNames;

  /// --------------------------------------------------------------------------
  /// Ayah
  Either<String, Ayah> _ayah = Left(ExceptionMessage.errorOccured.message);
  Either<String, Ayah> get ayah => _ayah;

  /// --------------------------------------------------------------------------
  /// Random integer for random god name
  int randomInt = Random().nextInt(99);

  /// --------------------------------------------------------------------------
  /// Booleans for loading states
  bool isGodNameLoading = false;
  bool isPrayerTimesLoading = false;
  bool isRandomAyahLoading = false;

  /// --------------------------------------------------------------------------
  /// Get prayer times
  Future<void> getPrayerTimes({
    required String city,
    required String country,
  }) async {
    /// Set isPrayerTimesLoaded state as true
    isPrayerTimesLoading = true;
    notifyListeners();
    await Future.delayed(Durations.extralong4);

    final response = await _prayerTimesService.getPrayerTimes(city, country);
    _datas = response;

    /// Set isPrayerTimesLoaded state as false
    isPrayerTimesLoading = false;
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Fetching data from json file and returning a list of GodNames
  Future<void> randomGodNameAndMeaning(BuildContext context) async {
    /// Set isGodNameLoaded state as true
    isGodNameLoading = true;
    notifyListeners();

    final response = await _godNamesService.randomGodNameAndMeaning(context);
    _godNames = response;

    /// Set isGodNameLoaded state as false
    isGodNameLoading = false;
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Get specific Ayah
  Future<void> getSpecificAyah() async {
    /// Set isRandomAyahLoaded state as true
    isRandomAyahLoading = true;
    notifyListeners();

    final response = await _ayahService.getSpecificAyah();
    _ayah = response;

    /// Set isRandomAyahLoaded state as false
    isRandomAyahLoading = false;
    notifyListeners();
  }
}
