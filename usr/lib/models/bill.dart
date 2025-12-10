class Bill {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  final String status;

  Bill({required this.id, required this.title, required this.amount, required this.dueDate, required this.status});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      dueDate: DateTime.parse(json['due_date']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'due_date': dueDate.toIso8601String(),
      'status': status,
    };
  }
}