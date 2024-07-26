/// This class is used to store the names of the gods
class God {
  ///
  God({
    required this.name,
    required this.meaning,
  });

  /// Factory method to create a GodNames object from a json object
  factory God.fromJson(Map<String, dynamic> json) {
    return God(
      name: json['name'] as String,
      meaning: json['meaning'] as String,
    );
  }

  /// Name of the god
  final String name;

  /// Meaning of the god's name
  final String meaning;
}
