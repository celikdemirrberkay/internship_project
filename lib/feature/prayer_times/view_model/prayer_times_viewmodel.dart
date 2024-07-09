import 'package:either_dart/either.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/repositories/model/response.dart';
import 'package:internship_project/repositories/prayer_times/prayer_times_service.dart';
import 'package:stacked/stacked.dart';

///
class PrayerTimesViewmodel extends BaseViewModel {
  ///
  PrayerTimesViewmodel(this._prayerTimesService) {
    getPrayerTimes('Istanbul', 'Turkey');
  }

  /// The service where we fetch prayer times
  final PrayerTimesService _prayerTimesService;

  /// Prayer times
  Either<String, ApiData> _datas = Left(ExceptionMessage.errorOccured.message);

  /// Times getter
  Either<String, ApiData> get datas => _datas;

  /// Get prayer times
  Future<void> getPrayerTimes(
    String city,
    String country,
  ) async {
    /// Set busy state to true
    setBusy(true);

    /// Fetch data from the api
    final response = await _prayerTimesService.getPrayerTimes(city, country);
    _datas = response;

    /// Set busy state to false
    setBusy(false);
  }
}
