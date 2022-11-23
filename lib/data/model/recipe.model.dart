class Recipe {
  final String uri;
  final String label;

  Recipe({required this.uri, required this.label});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      uri: json['uri'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uri': uri,
      'label': label,
    };
  }
}
