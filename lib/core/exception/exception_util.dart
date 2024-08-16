import 'package:internship_project/core/exception/exception_message.dart';
import 'package:internship_project/core/exception/exception_type.dart';

/// ExceptionUtil class is responsible for getting exception message.
/// For Toast message, pass message according to error type
class ExceptionMessager {
  /// Get exception message
  static String getExceptionMessage(ExceptionTypes exceptionType) {
    switch (exceptionType) {
      case ExceptionTypes.errorOccured:
        return ExceptionStrings.errorOccured.message;
      case ExceptionTypes.noInternetConnection:
        return ExceptionStrings.noInternetConnection.message;
      case ExceptionTypes.noData:
        return ExceptionStrings.noData.message;
      case ExceptionTypes.accessDeniedForLocation:
        return ExceptionStrings.accessDeniedForLocation.message;
      case ExceptionTypes.accessDeniedForeverForLocation:
        return ExceptionStrings.accessDeniedForeverForLocation.message;
      case ExceptionTypes.accessDeniedForNotification:
        return ExceptionStrings.accessDeniedForNotification.message;
      case ExceptionTypes.locationNotFound:
        return ExceptionStrings.locationNotFound.message;
    }
  }
}
