class Promotion {
  final String id;
  final String title;
  final int discount;
  final bool isActive;
  final String? conditions;

  Promotion({
    required this.id,
    required this.title,
    required this.discount,
    required this.isActive,
    this.conditions,
  });

  factory Promotion.fromMap(Map<String, dynamic> map, String id) {
    return Promotion(
      id: id,
      title: map['title'] as String,
      discount: map['discount'] as int,
      isActive: map['isActive'] as bool,
      conditions: map['conditions'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'discount': discount,
      'isActive': isActive,
      'conditions': conditions,
    };
  }
}
