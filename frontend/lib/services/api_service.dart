import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/symptom_request.dart';
import '../models/symptom_response.dart';
import '../models/query_history.dart';

class ApiService {
  // Use localhost for development - Flutter web can access localhost
  static final String baseUrl = 'http://localhost:8000';
  
  Future<SymptomResponse> analyzeSymptoms(SymptomRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/analyze-symptoms'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
      
      if (response.statusCode == 200) {
        return SymptomResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to analyze symptoms: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  Future<List<QueryHistory>> getQueryHistory({int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/query-history?limit=$limit'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => QueryHistory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch query history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  Future<bool> healthCheck() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/health'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}