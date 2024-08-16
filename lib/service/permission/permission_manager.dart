import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internship_project/core/exception/exception_message.dart';

/// App permission manager
class PermissionManager {
  /// Check permission for location
  static Future<bool> checkPermissionForLocation() async {
    final permissionStatus = await Geolocator.checkPermission();
    switch (permissionStatus) {
      case LocationPermission.denied:
        await Fluttertoast.showToast(msg: ExceptionStrings.accessDeniedForLocation.message);
        return false;
      case LocationPermission.deniedForever:
        await Fluttertoast.showToast(msg: ExceptionStrings.accessDeniedForLocation.message);
        return false;
      case LocationPermission.whileInUse:
        return true;
      case LocationPermission.always:
        return true;
      case LocationPermission.unableToDetermine:
        return false;
    }
  }

  /// Request permission for location
  static Future<bool> requestPermissionForLocation() async {
    final permissionStatus = await Geolocator.requestPermission();
    switch (permissionStatus) {
      case LocationPermission.denied:
        await Fluttertoast.showToast(msg: ExceptionStrings.accessDeniedForLocation.message);
        return false;
      case LocationPermission.deniedForever:
        await Fluttertoast.showToast(msg: ExceptionStrings.accessDeniedForeverForLocation.message);
        return false;
      case LocationPermission.whileInUse:
        return true;
      case LocationPermission.always:
        return true;
      case LocationPermission.unableToDetermine:
        return false;
    }
  }
}
