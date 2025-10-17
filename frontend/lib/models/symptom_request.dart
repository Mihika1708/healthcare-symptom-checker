class SymptomRequest {
  final String symptoms;
  final int? age;
  final String? gender;

  SymptomRequest({
    required this.symptoms,
    this.age,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'symptoms': symptoms,
      'age': age,
      'gender': gender,
    };
  }
}