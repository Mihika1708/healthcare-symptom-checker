import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/symptom_request.dart';
import 'results_screen.dart';

class SymptomCheckerScreen extends StatefulWidget {
  @override
  _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _symptomsController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  final List<String> _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void dispose() {
    _symptomsController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _analyzeSymptoms() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final request = SymptomRequest(
        symptoms: _symptomsController.text,
        age: _ageController.text.isNotEmpty ? int.parse(_ageController.text) : null,
        gender: _selectedGender,
      );

      final response = await _apiService.analyzeSymptoms(request);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(response: response),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error analyzing symptoms: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Checker'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Describe Your Symptoms',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please describe your symptoms in detail for better analysis',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _symptomsController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Symptoms *',
                          hintText: 'Describe your symptoms here...\nExample: headache, fever, cough for 3 days',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please describe your symptoms';
                          }
                          if (value.length < 10) {
                            return 'Please provide more detailed symptoms (at least 10 characters)';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Age',
                                hintText: 'e.g., 25',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  final age = int.tryParse(value);
                                  if (age == null || age < 1 || age > 120) {
                                    return 'Please enter a valid age (1-120)';
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField<String>(
                              value: _selectedGender,
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder(),
                              ),
                              items: _genders.map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedGender = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _analyzeSymptoms,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  'Analyze Symptoms',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: Text(
                          '⚠️ Important: This tool provides educational information only. Always consult healthcare professionals for medical advice and proper diagnosis.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}