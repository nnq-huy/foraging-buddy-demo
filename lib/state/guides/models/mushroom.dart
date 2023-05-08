class Mushroom {
  final int? id;
  final String latinName;
  final String name;
  final String family;
  final String edibility;
  final String description;

  Mushroom({
    this.id,
    required this.latinName,
    required this.name,
    required this.family,
    required this.edibility,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latin_name': latinName,
      'name': name,
      'family': family,
      'edibility': edibility,
      'description': description,
    };
  }

  factory Mushroom.fromMap(Map<String, dynamic> map) {
    return Mushroom(
      id: map['id'],
      latinName: map['latin_name'],
      name: map['name'],
      family: map['family'],
      edibility: map['edibility'],
      description: map['description'],
    );
  }

  @override
  String toString() {
    return 'Mushroom{id: $id, name: $name, latin name: $latinName}';
  }
}
