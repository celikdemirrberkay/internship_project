/// Exception messages
enum ExceptionMessage {
  /// Error occurred
  errorOccured('Hata meydana geldi!'),

  /// No internet connection
  noInternetConnection('İnternet bağlantınızı kontrol edip tekrar deneyin'),

  /// If data is null
  noData('Veri bulunamadı!'),

  /// Access denied
  accessDeniedForLocation('Konum erişim reddedildi! Bu sebeple İstanbul konumu kullanılacak');

  /// Message
  final String message;

  ///
  const ExceptionMessage(this.message);
}
