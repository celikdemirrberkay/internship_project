import 'dart:math';

import 'package:flutter/material.dart';
import '../../../core/base/resource.dart';
import '../../../model/ayah.dart';
import '../../../model/god_names.dart';
import '../../../model/times_response.dart';
import '../../../service/local/god_names/god_names_service.dart';
import '../../../service/remote/ayah/ayah_service.dart';
import '../../../service/remote/location/location_service.dart';
import '../../../service/remote/prayer_times/prayer_times_service.dart';
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
      city: LocationService.cityName.value,
      country: LocationService.countryName.value,
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
  Resource<PrayerApiData> _prayerTimesData = const LoadingState();
  Resource<PrayerApiData> get prayerTimesData => _prayerTimesData;

  /// --------------------------------------------------------------------------
  /// God names
  Resource<God> _godNames = const LoadingState();
  Resource<God> get godNames => _godNames;

  /// --------------------------------------------------------------------------
  /// Ayah
  Resource<Ayah> _ayah = const LoadingState();
  Resource<Ayah> get ayah => _ayah;

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
    final response = await _prayerTimesService.getPrayerTimes(city, country);
    _prayerTimesData = response;
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Fetching data from json file and returning a list of GodNames
  Future<void> randomGodNameAndMeaning(BuildContext context) async {
    final response = await _godNamesService.randomGodNameAndMeaning(context);
    _godNames = response;
    notifyListeners();
  }

  /// --------------------------------------------------------------------------
  /// Get specific Ayah
  Future<void> getSpecificAyah() async {
    final response = await _ayahService.getSpecificAyah();
    _ayah = response;
    notifyListeners();
  }
}
