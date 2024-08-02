import 'exception_message.dart';
import 'exception_type.dart';

/// ExceptionUtil class is responsible for getting exception message.
class ExceptionUtil {
  /// Get exception message
  static String getExceptionMessage(ExceptionType exceptionType) {
    switch (exceptionType) {
      case ExceptionType.errorOccured:
        return ExceptionMessage.errorOccured.message;
      case ExceptionType.noInternetConnection:
        return ExceptionMessage.noInternetConnection.message;
      case ExceptionType.noData:
        return ExceptionMessage.noData.message;
      case ExceptionType.accessDeniedForLocation:
        return ExceptionMessage.accessDeniedForLocation.message;
      case ExceptionType.accessDeniedForeverForLocation:
        return ExceptionMessage.accessDeniedForeverForLocation.message;
      case ExceptionType.accessDeniedForNotification:
        return ExceptionMessage.accessDeniedForNotification.message;
    }
  }
}
