/// Ayah model
class Ayah {
  /// Ayah constructor
  Ayah({required this.text});

  /// Ayah from json
  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      text: json['text'] as String,
    );
  }

  /// Ayah text
  final String text;
}
