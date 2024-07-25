import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/base/resource.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/service/permission/permission_manager.dart';
import 'package:internship_project/service/remote/location/location_service.dart';
import 'package:stacked/stacked.dart';

/// Splash view model
class SplashViewModel extends BaseViewModel {
  ///
  SplashViewModel(this.locationService);

  /// Location service instance
  final LocationService locationService;

  /// Request and check permission for location
  Future<void> requestAndCheckPermissionForLocation() async {
    await PermissionManager.requestPermissionForLocation();
  }

  /// Set city and country name
  Future<void> setCityAndCountryName() async {
    final city = await locationService.getCityName();
    final country = await locationService.getCountryName();

    if (city.runtimeType == ErrorState || country.runtimeType == ErrorState) {
      await Fluttertoast.showToast(
        msg: ExceptionMessage.accessDeniedForeverForLocation.message,
      );
    } else {
      LocationService.cityName = city.data == '' ? 'İstanbul' : city.data!;
      LocationService.countryName = country.data == '' ? 'Turkey' : country.data!;
    }
  }
}
