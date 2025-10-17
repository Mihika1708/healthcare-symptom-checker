import 'package:flutter/material.dart';
import '../models/symptom_response.dart';

class ResultsScreen extends StatelessWidget {
  final SymptomResponse response;

  const ResultsScreen({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Results'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.medical_services, color: Colors.blue, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Symptom Analysis Complete',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Probable Conditions:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            ...response.probableConditions.map((condition) => ConditionCard(condition: condition)),
            SizedBox(height: 24),
            Text(
              'Recommended Next Steps:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            ...response.recommendedNextSteps.map((step) => NextStepItem(step: step)),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: Text(
                response.disclaimer,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red[800],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConditionCard extends StatelessWidget {
  final ConditionSuggestion condition;

  const ConditionCard({Key? key, required this.condition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color confidenceColor = Colors.grey;
    switch (condition.confidence.toLowerCase()) {
      case 'high':
        confidenceColor = Colors.red;
        break;
      case 'medium':
        confidenceColor = Colors.orange;
        break;
      case 'low':
        confidenceColor = Colors.green;
        break;
    }

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    condition.condition,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: confidenceColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: confidenceColor),
                  ),
                  child: Text(
                    '${condition.confidence[0].toUpperCase()}${condition.confidence.substring(1)} confidence',
                    style: TextStyle(
                      fontSize: 12,
                      color: confidenceColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              condition.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextStepItem extends StatelessWidget {
  final String step;

  const NextStepItem({Key? key, required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      color: Colors.green[50],
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                step,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}