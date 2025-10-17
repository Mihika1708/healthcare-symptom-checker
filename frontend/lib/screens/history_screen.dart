import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/query_history.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ApiService _apiService = ApiService();
  List<QueryHistory> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final history = await _apiService.getQueryHistory(limit: 20);
      setState(() {
        _history = history;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading history: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Query History'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _history.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No history yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Your symptom analysis history will appear here',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadHistory,
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      final item = _history[index];
                      return HistoryItem(history: item);
                    },
                  ),
                ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final QueryHistory history;

  const HistoryItem({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  '${history.createdAt.day}/${history.createdAt.month}/${history.createdAt.year} ${history.createdAt.hour}:${history.createdAt.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Symptoms:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 4),
            Text(
              history.symptoms.length > 100
                  ? '${history.symptoms.substring(0, 100)}...'
                  : history.symptoms,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            if (history.response['probable_conditions'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Conditions:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  ...(history.response['probable_conditions'] as List).take(2).map((condition) {
                    return Text(
                      '• ${condition['condition']}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    );
                  }),
                ],
              ),
          ],
        ),
      ),
    );
  }
}