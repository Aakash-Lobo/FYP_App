import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewExamFeedbackPage extends StatefulWidget {
  final String username;

  ViewExamFeedbackPage({required this.username});

  @override
  _ViewExamFeedbackPageState createState() => _ViewExamFeedbackPageState();
}

class _ViewExamFeedbackPageState extends State<ViewExamFeedbackPage> {
  List<Map<String, dynamic>> feedbackData = [];

  @override
  void initState() {
    super.initState();
    // Fetch feedback data
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/exam/viewfeedback.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          feedbackData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Feedback',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Examinee')),
                DataColumn(label: Text('Feedbacks')),
                DataColumn(label: Text('Date')),
              ],
              rows: feedbackData.map((feedback) {
                return DataRow(
                  cells: [
                    DataCell(Text(feedback['fb_exmne_as'] ?? 'N/A')),
                    DataCell(Text(feedback['fb_feedbacks'] ?? 'N/A')),
                    DataCell(Text(feedback['fb_date'] ?? 'N/A')),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
