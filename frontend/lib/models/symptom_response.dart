class ConditionSuggestion {
  final String condition;
  final String confidence;
  final String description;

  ConditionSuggestion({
    required this.condition,
    required this.confidence,
    required this.description,
  });

  factory ConditionSuggestion.fromJson(Map<String, dynamic> json) {
    return ConditionSuggestion(
      condition: json['condition'],
      confidence: json['confidence'],
      description: json['description'],
    );
  }
}

class SymptomResponse {
  final List<ConditionSuggestion> probableConditions;
  final List<String> recommendedNextSteps;
  final String disclaimer;
  final String? queryId;

  SymptomResponse({
    required this.probableConditions,
    required this.recommendedNextSteps,
    required this.disclaimer,
    this.queryId,
  });

  factory SymptomResponse.fromJson(Map<String, dynamic> json) {
    return SymptomResponse(
      probableConditions: (json['probable_conditions'] as List)
          .map((item) => ConditionSuggestion.fromJson(item))
          .toList(),
      recommendedNextSteps: List<String>.from(json['recommended_next_steps']),
      disclaimer: json['disclaimer'],
      queryId: json['query_id'],
    );
  }
}