class QueryHistory {
  final String id;
  final String symptoms;
  final Map<String, dynamic> response;
  final DateTime createdAt;

  QueryHistory({
    required this.id,
    required this.symptoms,
    required this.response,
    required this.createdAt,
  });

  factory QueryHistory.fromJson(Map<String, dynamic> json) {
    return QueryHistory(
      id: json['id'],
      symptoms: json['symptoms'],
      response: Map<String, dynamic>.from(json['response']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}