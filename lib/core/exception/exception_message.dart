/// Exception messages enum that holds exception messages.
enum ExceptionStrings {
  /// Error occurred
  errorOccured('Hata meydana geldi!'),

  /// No internet connection
  noInternetConnection('İnternet bağlantınızı kontrol edip tekrar deneyin'),

  /// If data is null
  noData('Veri bulunamadı!'),

  /// Location not found
  locationNotFound('Konum bilgisi alınamadı. Varsayılan olarak İstanbul konumu kullanılacak'),

  /// Access denied for notification
  accessDeniedForNotification('Bildirim erişim izni verilmedi! Ayarlardan bildirim için izni vermelisiniz'),

  /// Access denied for location
  accessDeniedForLocation('Konum erişim reddedildi! Bu sebeple İstanbul konumu kullanılacak'),

  /// Access denied forever for location
  accessDeniedForeverForLocation('Konum erişim reddedildi! Uygulamanın ayarlarından konum erişim izni vermelisiniz');

  /// Message
  final String message;

  ///
  const ExceptionStrings(this.message);
}
