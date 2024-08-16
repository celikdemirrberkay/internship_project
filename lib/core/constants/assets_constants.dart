/// Assets constants like lottie files, images, etc.
enum LottieConstants {
  /// Lottie file path
  prayerViewTopLottie('assets/lottie/prayer.json');

  const LottieConstants(this.path);

  /// Path parameter
  final String path;
}

/// ----------------------------------------------------------------------------
/// City name service constants
enum AssetsConstants {
  /// Turkey cities asset path
  turkeysCityAsset('assets/static/turkeys_city.json'),

  /// God names asset path
  godNamesAsset('assets/static/god_names.json');

  const AssetsConstants(this.value);

  /// Value parameter
  final String value;
}
