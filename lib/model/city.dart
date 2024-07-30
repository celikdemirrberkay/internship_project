/// Turkey cities model
class City {
  ///
  City({required this.name, required this.cityId});

  /// City name
  final String name;

  /// City id
  final int cityId;

  /// From json
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      cityId: json['cityId'] as int,
    );
  }
}
