/// Ayah model
class Ayah {
  /// Ayah constructor
  Ayah({required this.text});

  /// Ayah text
  final String text;

  /// Ayah from json
  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      text: json['text'] as String,
    );
  }
}
