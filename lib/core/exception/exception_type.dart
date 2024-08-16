/// Exception type enum that holds exception type.
/// It is used to return errors in services.
enum ExceptionTypes {
  /// Error occured
  errorOccured,

  /// No internet connection
  noInternetConnection,

  /// No data
  noData,

  /// Access denied for location
  accessDeniedForLocation,

  /// Location not found
  locationNotFound,

  /// Access denied forever for location
  accessDeniedForeverForLocation,

  /// Access denied for notification
  accessDeniedForNotification,
}
