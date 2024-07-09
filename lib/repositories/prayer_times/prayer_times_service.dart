import 'package:internship_project/repositories/model/response.dart';
import 'package:internship_project/repositories/prayer_times/prayer_times_interface.dart';

/// The service where we fetch prayer times
class PrayerTimesService extends IPrayerTimesService {
  ///
  PrayerTimesService(super.dio);

  @override
  Future<ApiResponse?> getPrayerTimes() {
    // TODO: implement getPrayerTimes
    throw UnimplementedError();
  }
}
