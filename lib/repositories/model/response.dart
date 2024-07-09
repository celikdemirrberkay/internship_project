/// Response returned from api
class ApiResponse {
  ///
  ApiResponse({
    this.code,
    this.data,
  });

  /// Status code
  int? code;

  /// Including times data
  Data? data;

  /// Convert json to factory ApiResponse object
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'] as int?,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

/// Data returned from api
/// Including timings and date
class Data {
  ///
  Data({
    this.timings,
    this.date,
  });

  /// All pray times
  Timings? timings;

  /// Date of specific pray times
  Date? date;

  /// Convert json to factory Data object
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      timings: Timings.fromJson(json['timings'] as Map<String, dynamic>),
      date: Date.fromJson(json['date'] as Map<String, dynamic>),
    );
  }
}

///
class Date {
  ///
  Date({
    this.readable,
    this.timestamp,
  });

  /// Date in human readable format
  String? readable;

  /// Date in timestamp format
  String? timestamp;

  /// Convert json to factory Date object
  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      readable: json['readable'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }
}

/// Times for prayers data class
class Timings {
  ///
  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  /// Fajr time
  String? fajr;

  /// Sunrise time
  String? sunrise;

  /// Dhuhr time
  String? dhuhr;

  /// Asr time
  String? asr;

  /// Sunset time
  String? sunset;

  /// Maghrib time
  String? maghrib;

  /// Isha time
  String? isha;

  /// Imsak time
  String? imsak;

  /// Midnight time
  String? midnight;

  /// First third time
  String? firstthird;

  /// Last third time
  String? lastthird;

  /// Convert json to factory Timings object
  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'] as String?,
      sunrise: json['Sunrise'] as String?,
      dhuhr: json['Dhuhr'] as String?,
      asr: json['Asr'] as String?,
      sunset: json['Sunset'] as String?,
      maghrib: json['Maghrib'] as String?,
      isha: json['Isha'] as String?,
      imsak: json['Imsak'] as String?,
      midnight: json['Midnight'] as String?,
      firstthird: json['Firstthird'] as String?,
      lastthird: json['Lastthird'] as String?,
    );
  }
}
