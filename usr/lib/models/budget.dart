class Budget {
  final String id;
  final String category;
  final double limit;
  final double spent;

  Budget({required this.id, required this.category, required this.limit, required this.spent});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      category: json['category'],
      limit: json['limit'],
      spent: json['spent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'limit': limit,
      'spent': spent,
    };
  }
}