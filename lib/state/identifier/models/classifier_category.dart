class ClassifierCategory {
  final String label;
  final double score;

  ClassifierCategory({required this.label, required this.score});

  factory ClassifierCategory.fromJson(Map<String, dynamic> data) {
    final label = data['label'] as String;
    final score = data['score'] as double;
    return ClassifierCategory(
      label: label,
      score: score,
    );
  }
  Map<String, dynamic> toJson() => {
        'label': label,
        'score': score,
      };
  @override
  String toString() {
    return 'Category{label: $label, score: $score}';
  }
}
