import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/service&repository/permission/permission_manager.dart';
import 'package:internship_project/service&repository/remote/location/location_service.dart';
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

    if (city.isLeft || country.isLeft) {
      await Fluttertoast.showToast(msg: ExceptionMessage.accessDeniedForeverForLocation.message);
    } else {
      LocationService.cityName = city.right == '' ? 'İstanbul' : city.right;
      LocationService.countryName = country.right == '' ? 'Turkey' : country.right;
    }
  }
}
